require 'bundler/setup'
require 'minitest/autorun'
require 'bunny_rpc'

class TestClient < Minitest::Test
  describe 'connect' do
    before do
      @server = BunnyRpc::Server.new
    end

    it 'server response' do
      @server.subscribe('queue1') do |data|
        puts data
        'get it !'
      end
    end
  end
end
