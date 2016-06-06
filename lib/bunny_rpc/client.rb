require 'bunny'

module BunnyRpc
  class Client
    def initialize(options={})
      @options = options
      @mutex = Mutex.new
      @timeout = options[:timeout] || 5
      @condition_variable = ConditionVariable.new
      @correlation_id = correlation_id
    end

    def publish(body, queue_name)
      subscribe

      exchange.publish(body, routing_key: queue_name, reply_to: reply_queue.name, correlation_id: @correlation_id)

      add_lock

      @payload
    end

    def close
      @connect.stop
    end

    def subscribe
      reply_queue.subscribe do |_, properties, payload|
        if properties.correlation_id == @correlation_id
          @payload = payload

          del_lock
        else
          del_lock
          raise 'correlation_id error !'
        end
      end
    end

    def add_lock
      @mutex.synchronize do
        expire_time = Time.now + @timeout
        loop do
           if @payload.nil?
             remaining = expire_time - Time.now
             raise(Timeout::Error, "Waited #{@timeout} seconds") if(remaining <= 0)
           else
             @condition_variable.wait(@mutex, remaining)
             return
           end
         end
      end
    end

    def del_lock
      @mutex.synchronize { @condition_variable.signal }
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

    def reply_queue
      @reply_queue ||= channel.queue(reply_queue_name, exclusive: true, auto_delete: true)
    end

    def reply_queue_name
      "reply_to-#{rand(10)}"
    end

    def correlation_id
      "#{rand(10)}#{rand(10)}#{rand(10)}"
    end
  end
end
