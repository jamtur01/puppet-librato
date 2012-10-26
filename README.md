puppet-Librato
==============

Description
-----------

A Puppet report processor for sending metrics to [Librato](https://metrics.librato.com/).

Requirements
------------

* `librato-metrics`
* `Puppet`

Installation & Usage
--------------------

1.  Install the `librato-metrics` gem on your Puppet master

        $ sudo gem install librato-metrics

2.  Install puppet-librato as a module in your Puppet master's module
    path.

3.  Update the `librato_email` and `librato_key` variables in the `librato.yaml` file with 
    your Librato account email and API key and copy the file to `/etc/puppet/`. An example file is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = librato
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2012 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
