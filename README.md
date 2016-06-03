# BunnyRpc

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bunny_rpc`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

  payload = 'get it !'

  server.publish(payload)
end
```
