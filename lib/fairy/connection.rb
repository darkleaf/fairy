module Fairy
  class Connection < EventMachine::Connection
    attr_accessor :channel

    def receive_data(msg)
      channel.push msg
    end
  end
end
