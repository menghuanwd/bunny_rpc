require 'bundler/setup'
require 'minitest/autorun'
require 'bunny_rpc'

class TestClient < Minitest::Test
  describe 'connect' do
    before do
      @client = BunnyRpc::Client.new
    end

    it 'connect ok' do
      skip 'connect ！'
    end

    it 'client response' do
      result = @client.publish('request body', 'queue1')
      @client.close
      assert_equal result, 'get it !'
    end
  end
end
