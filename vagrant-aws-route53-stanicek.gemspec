$:.unshift File.expand_path('../lib', __FILE__)
require 'vagrant-aws-route53/version'

Gem::Specification.new do |s|
  s.name          = 'vagrant-aws-route53-stanicek'
  s.version       = VagrantPlugins::AwsRoute53::VERSION
  s.platform      = Gem::Platform::RUBY
  s.license       = 'MIT'
  s.authors       = 'Naohiro Oogatta, Josef Stanicek'
  s.email         = 'oogatta@gmail.com, josef@stanicek.cz'
  s.homepage      = 'https://github.com/stanicek/vagrant-aws-route53'
  s.summary       = 'Assigns IPs or public DNS name of Vagrant AWS instances to route 53.'
  s.description   = 'A Vagrant plugin assigns the IP or public DNS name of the instance which vagrant-aws provider created to a specific Route 53 record set.'
  s.require_path  = 'lib'
  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)

  s.add_runtime_dependency 'aws-sdk-v1'
end
