module Fairy
  class Connection < EventMachine::Connection
    attr_accessor :server

    def receive_data(data)
      p data
    end

    def unbind
      server.connections.delete(self)
    end
  end
end
