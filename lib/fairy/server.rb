module Fairy
  class Server
    attr_accessor :channel, :host, :ws_port, :tcp_port

    def initialize(host, ws_port, tcp_port)
      @channel = EM::Channel.new
      @host = host
      @ws_port = ws_port
      @tcp_port = tcp_port
    end

    def start
      EventMachine::WebSocket.start(host: host, port: ws_port) do |ws|
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

      EventMachine.start_server(host, tcp_port, Connection) do |con|
        con.channel = channel
      end
    end
  end
end


