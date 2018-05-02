#
# Cookbook Name:: kernel-modules
# Author:: Jeremy MAURO <j.mauro@criteo.com>
#
# Copyright 2016, Criteo.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

provides :kernel_module, platform_family: 'rhel'

MODPROBE_BIN = '/sbin/modprobe'.freeze

def whyrun_supported?
  true
end

use_inline_resources

action :configure do
  # Requirements
  package node['kernel_modules']['packages']

  # Module init loading section
  template modload_file do
    source "#{node['platform_family']}-#{node['platform_version'].to_i}/init-load.erb"
    cookbook 'kernel-modules'
    mode '0755'
    variables(
      name: new_resource.name,
      bin: MODPROBE_BIN,
    )
    action new_resource.onboot ? :create : :delete
  end

  # Module loading options
  template modprobe_file do
    source 'modprobe.conf.erb'
    cookbook 'kernel-modules'
    mode '0644'
    variables(
      name: new_resource.name,
      alias: new_resource.alias,
      options: new_resource.options,
      install: new_resource.install,
      remove: new_resource.remove,
      blacklist: new_resource.blacklist,
    )
    action :create
    if current_resource.loaded? &&
       (
         new_resource.reload ||
         new_resource.force_reload ||
         new_resource.blacklisted?
       )
      notifies :run, "execute[Unloading module #{new_resource.name}]", :immediately
    end
  end

  execute "Unloading module #{new_resource.name}" do
    command reload_cmd
    action :nothing
  end
end

action :load do
  # When loading a module it means the module must be configured
  run_action :configure

  execute "(Re)Loading module #{new_resource.name}" do
    command "#{MODPROBE_BIN} -v #{new_resource.name}"
    not_if { current_resource.loaded? }
    not_if { new_resource.blacklisted? } # No need to load if blacklisted
  end
end

action :unload do
  # Requirements
  package node['kernel_modules']['packages']

  execute "Unloading module #{new_resource.name}" do
    command reload_cmd
    only_if { current_resource.loaded? }
  end
end

action :remove do
  run_action :unload
  [modload_file, modprobe_file].each do |f|
    file f do
      action :delete
    end
  end
end

def load_current_resource
  @current_resource = ::Chef::Resource::KernelModules.new(new_resource.name, run_context)
end

# Function to return the correct command for removing module
def reload_cmd
  # First unload the module nicely
  unload_cmd = MODPROBE_BIN + " -r #{new_resource.name}"
  # If asked do it the strong way
  unload_cmd << " || /sbin/rmmod -f #{new_resource.name}" if new_resource.force_reload
  unload_cmd
end

def modload_file
  case node['platform_version']
  when /^6/
    ::File.join(node['kernel_modules']['modules_load.d'], new_resource.name + '.modules')
  when /^7/
    ::File.join(node['kernel_modules']['modules_load.d'], new_resource.name + '.conf')
  end
end

def modprobe_file
  ::File.join(node['kernel_modules']['modprobe.d'], new_resource.name + '.conf')
end
