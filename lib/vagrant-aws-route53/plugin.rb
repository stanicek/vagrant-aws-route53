require 'vagrant'

module VagrantPlugins
  module AwsRoute53
    class Plugin < Vagrant.plugin('2')
      name 'AwsRoute53'

      description <<-DESC
      DESC

      config :route53 do
        require_relative './config'
        Config
      end

      action_hook :assign_ip, :machine_action_up do |hook|
        require_relative './action/set_ip'
        hook.after VagrantPlugins::AWS::Action::RunInstance, VagrantPlugins::AwsRoute53::Action::SetIp
        hook.after VagrantPlugins::AWS::Action::StartInstance, VagrantPlugins::AwsRoute53::Action::SetIp
      end
    end
  end
end
