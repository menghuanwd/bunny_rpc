module BunnyRpc
  class Server
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

      queue(queue_name).subscribe(block: true) do |_, properties, payload|
        @reply_to = properties.reply_to
        @reply_correlation_id = properties.correlation_id

        publish(yield payload)
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

    def queue(queue_name)
      @queue ||= channel.queue(queue_name, exclusive: true)
    end

  end
end
