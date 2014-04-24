# MiOS

Gem that uses the URL API for the Vera family of products from [MiCasaVerde](http://micasaverde.com).

## Installation

Add this line to your application's Gemfile:

    gem 'mios'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mios

## Usage

MiOS works on a job queue. If you wish to change an attribute or the status of a particular device, you must submit a
job to MiOS and wait for it to be succeed or fail or require a requeue. Most of this functionality is hidden behind the scenes
and an idiomatic synchronous closure interface is exposed that manages it all for you, as you'll see below. Most methods can also
be used asynchronously but you need to know what you are doing as this is not really an event-driven system and inconsistencies can
occur if used improperly.

### Create a reference to your local MiOS device
    mios = MiOS::Interface.new('http://192.168.15.1:3480')

### Devices could be anything of course, assuming here the first is a switch
    switch = mios.devices[0]

### Turn the switch off (light switch or outlet or anything classed as a switch)
    switch.off!

### The job object is returned from calls that require API calls
    job = switch.on!

### Execute some code once the job has finished
    switch.off! { |obj|
      puts "The #{obj.name} is now off"
    }
    puts "This will get printed once the switch is off and the block has been executed"

### Execute some code asynchronously from the job
    switch.on!(true) { |obj|
      puts "The #{obj.name} is now on"
    }
    puts "This will output immediately"
    sleep(5) # Sleep to wait for the thread to finish, will clean this up later

## Additional information

http://wiki.micasaverde.com/index.php/Category:Development
http://wiki.micasaverde.com/index.php/Luup_Requests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
