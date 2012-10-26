require 'puppet'
require 'yaml'

begin
  require 'librato/metrics'
rescue LoadError => e
  Puppet.info "You need the `librato-metrics` gem to use the Librato report"
end

Puppet::Reports.register_report(:librato) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "librato.yaml"])
  raise(Puppet::ParseError, "Librato report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  LIBRATO_EMAIL = config[:librato_email]
  LIBRATO_KEY = config[:librato_key]

  desc <<-DESC
  Send metrics to Librato.
  DESC

  def process
    Puppet.debug "Sending metrics for #{self.host} to Librato account: #{LIBRATO_EMAIL} and #{LIBRATO_KEY}"
    @client = Librato::Metrics::Client.new
    @client.authenticate(LIBRATO_EMAIL, LIBRATO_KEY)
    @client_queue = @client.new_queue
      self.metrics.each { |metric,data|
        data.values.each { |val|
          n = val[1].downcase
          #Puppet.debug "#{n} and #{metric}"
          name = "puppet.#{n.gsub(/\s/, '_')}_#{metric}"
          Puppet.debug "#{name}"
          @client_queue.add name => {:source => self.host, :value => val[2]}
        }
      }
    @client_queue.submit
  end
end
