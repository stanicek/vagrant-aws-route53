require 'aws-sdk'

module VagrantPlugins
  module AwsRoute53
    module Action
      class SetIp
        def initialize(app, environment)
          @app = app
        end

        def call(environment)
          config          = environment[:machine].config
          provider_config = environment[:machine].provider_config

          access_key_id     = provider_config.access_key_id
          secret_access_key = provider_config.secret_access_key
          region            = provider_config.region
          instance_id       = environment[:machine].id
          hosted_zone_id    = config.route53.hosted_zone_id
          record_set        = config.route53.record_set

          set(
            access_key_id:     access_key_id,
            secret_access_key: secret_access_key,
            region:            region,
            instance_id:       instance_id,
            hosted_zone_id:    hosted_zone_id,
            record_set:        record_set,
          ) do |instance_id, pubilic_ip, record_set|
            environment[:ui].info("#{instance_id}'s #{pubilic_ip} has been assigned to #{record_set[0]}[#{record_set[1]}]")
          end

          @app.call(environment)
        end

        private

        def set(options)
          ::AWS.config(access_key_id: options[:access_key_id], secret_access_key: options[:secret_access_key], region: options[:region])

          ec2 = ::AWS.ec2
          public_ip = ec2.instances[options[:instance_id]].public_ip_address

          record_sets = ::AWS::Route53::HostedZone.new(options[:hosted_zone_id]).rrsets
          record_set  = record_sets[*options[:record_set]]
          record_set.resource_records = [{ value: public_ip }]
          record_set.update

          if block_given?
            yield options[:instance_id], public_ip, options[:record_set]
          end

          nil
        end
      end
    end
  end
end
