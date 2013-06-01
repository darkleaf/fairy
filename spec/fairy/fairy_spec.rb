require "spec_helper"

describe Fairy do
  before do
    @host = '127.0.0.1'
    @port = '8081'
  end

  it "multicast" do
    EM.run do
      server = Fairy::Server.new @host, @port
      server.start

      client1 = EventMachine::WebSocketClient.connect("ws://#{@host}:#{@port}")
      client2 = EventMachine::WebSocketClient.connect("ws://#{@host}:#{@port}")

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
end
