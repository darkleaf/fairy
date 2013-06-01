require "fairy/version"

#TODO: fix me
require 'eventmachine'
require 'em-websocket'

module Fairy
  autoload :Server, 'fairy/server'
  autoload :Connection, 'fairy/connection'
end
