module Fairy
  class Server
    attr_accessor :channel, :host, :port

    def initialize(host, port)
      @channel = EM::Channel.new
      @host = host
      @port = port
    end

    def start
      EventMachine::WebSocket.start(host: @host, port: @port) do |ws|
        ws.onmessage do |msg|
          channel.push msg
        end

        ws.onopen do
          puts "WebSocket opened"

          channel.subscribe do |msg|
            ws.send msg
          end
        end
      end
    end

  end
end


