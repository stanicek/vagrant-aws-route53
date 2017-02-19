require 'vagrant'

module VagrantPlugins
  module AwsRoute53Stanicek
    class Plugin < Vagrant.plugin('2')
      name 'AwsRoute53Stanicek'

      description <<-DESC
      DESC

      config :route53 do
        require_relative './config'
        Config
      end

      action_hook :assign_ip_to_route53, :machine_action_up do |hook|
        require_relative './action/set_ip'
        hook.after VagrantPlugins::AWS::Action::RunInstance,   VagrantPlugins::AwsRoute53Stanicek::Action::SetIp
        hook.after VagrantPlugins::AWS::Action::StartInstance, VagrantPlugins::AwsRoute53Stanicek::Action::SetIp
      end

      action_hook :cancel_ip_from_route53, :machine_action_halt do |hook|
        require_relative './action/unset_ip'
        hook.after VagrantPlugins::AWS::Action::StopInstance,      VagrantPlugins::AwsRoute53Stanicek::Action::UnsetIp
        hook.after VagrantPlugins::AWS::Action::TerminateInstance, VagrantPlugins::AwsRoute53Stanicek::Action::UnsetIp
      end

      action_hook :cancel_ip_from_route53, :machine_action_destroy do |hook|
        require_relative './action/unset_ip'
        hook.after VagrantPlugins::AWS::Action::StopInstance,      VagrantPlugins::AwsRoute53Stanicek::Action::UnsetIp
        hook.after VagrantPlugins::AWS::Action::TerminateInstance, VagrantPlugins::AwsRoute53Stanicek::Action::UnsetIp
      end
    end
  end
end
