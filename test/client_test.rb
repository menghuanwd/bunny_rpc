require 'bundler/setup'
require 'minitest/autorun'
require 'bunny_rpc'

class TestClient < Minitest::Test
  describe 'connect' do
    before do
      @queue_name = 'queue1'
      @timeout = 3
    end

    it 'client response' do
      @client = BunnyRpc::Client.new
      result = @client.publish('request body', @queue_name)

      @client.close
      assert_equal result, 'get it !'
    end

    it 'client timeout' do
      @client = BunnyRpc::Client.new({timeout: @timeout})
      begin
        result = @client.publish('request body', @queue_name)
        assert_equal result, 'get it !'
      rescue Timeout::Error => e
        assert_equal "Waited #{@timeout} seconds", e.message
      end

      @client.close
    end
  end
end
