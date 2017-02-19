require 'vagrant'

module VagrantPlugins
  module AwsRoute53Stanicek
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :hosted_zone_id
      attr_accessor :record_set

      def initialize
        @hosted_zone_id = UNSET_VALUE
        @record_set     = UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors

        { 'AwsRoute53Stanicek' => errors }
      end
    end
  end
end
