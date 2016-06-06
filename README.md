# BunnyRpc

rabbitmq RPC on bunny

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bunny_rpc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bunny_rpc

## Usage

### Client

```
require 'bunny_rpc'

client = BunnyRpc::Client.new

client.publish('okokokokok', 'queue1')

client.close
```

### Server

```
require 'bunny_rpc'

server = BunnyRpc::Server.new

server.subscribe('queue1') do |data|
  puts data

  'get it !'
end

the last block body is the return body.
```

## TODO

* to become backend_work.
