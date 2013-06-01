require 'bundler/setup'
Bundler.require

require 'em-websocket-client'
require 'support/event_machine_helper'

RSpec.configure do |config|
  config.include EventMachineHelper

  config.order = "random"
end
