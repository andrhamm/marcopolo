# Marcopolo

Marcopolo is a Rack middleware for use in Rails applications (currently) to aid in debugging HTTP requests and responses by logging the *raw* requests and their responses (including headers and body).

## Installation

Add this line to your application's Gemfile:

    gem 'marcopolo'

And then execute:

    $ bundle

## Usage

By simply including the gem in your Gemfile, your Rails app will automatically start logging raw incoming HTTP requests and your app's responses to your Rails log. That being said, you can choose a different log location if you wish.

Configure the logger settings in a Rails initializer like so:

    Marcopolo.options[:logger] = Logger.new(File.join(Rails.root, 'log', "#{Rails.env}-http-raw.log"))
    Marcopolo.options[:severity] = Logger::Severity::DEBUG

Consider adding logrote rules to your application server to prevent these extremely verbose logs from blowing up your storage.

Also, be mindful of cleaning up these logs appropriately, as sensative information like authorization headers and cookies will not be filtered out automatically (hence "raw").

## TODO

* Support for Sinatra?
* Noise filters?
* Ability to disable for certain endpoints, etc
* IP-based log segmenting?
* Tests?

## Contributing

1. Fork it ( http://github.com/<my-github-username>/marcopolo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
