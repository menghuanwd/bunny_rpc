module BunnyRpc
  class Server
    attr_accessor :reply_correlation_id, :reply_to, :queue_name

    def initialize(options={})
      @options = options
    end

    def publish(payload)
      exchange.publish(
        payload,
        routing_key: @reply_to,
        correlation_id: @reply_correlation_id
      )
    end

    def subscribe(queue_name)
      raise 'no queue name' if queue_name.nil?

      @queue_name = queue_name
      queue.subscribe(block: true) do |_, properties, payload|
        @reply_to = properties.reply_to
        @reply_correlation_id = properties.correlation_id

        yield payload
      end
    end

    def connect
      return @connect if defined?(@connect)
      @connect = Bunny.new(@options)
      @connect.start
      @connect
    end

    def channel
      @channel ||= connect.create_channel
    end

    def exchange
      @exchange ||= channel.default_exchange
    end

    def queue
      @queue ||= channel.queue(@queue_name, exclusive: true)
    end

  end
end
