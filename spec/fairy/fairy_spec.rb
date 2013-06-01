require "spec_helper"

describe Fairy do
  before do
    @host = '127.0.0.1'
    @ws_port = 8081
    @tcp_port = 8082
    @server = Fairy::Server.new @host, @ws_port, @tcp_port
  end

  it "multicast" do
    EM.run do
      @server.start

      client1 = EventMachine::WebSocketClient.connect("ws://#{@host}:#{@ws_port}")
      client2 = EventMachine::WebSocketClient.connect("ws://#{@host}:#{@ws_port}")

      message = 'message'

      client1.callback do
        client1.send_msg message
        set_em_steps :send_message
      end

      client2.stream do |msg|
        is_resived = message == msg
        expect(is_resived).to be(true)
        em_step_complete :send_message if is_resived
      end
    end
  end

  it "send message from tcp client" do
    EM.run do
      @server.start

      client = EventMachine::WebSocketClient.connect("ws://#{@host}:#{@ws_port}")

      message = 'message'

      client.callback do
        tcp_client = TCPSocket.open(@host, @tcp_port)
        tcp_client.write(message)
        tcp_client.close
        set_em_steps :send_message
      end

      client.stream do |msg|
        is_resived = message == msg
        expect(is_resived).to be(true)
        em_step_complete :send_message if is_resived
      end
    end
  end
end
