# TourGuide

A small gem to use `shepherd.js` consistently across eLitmus applications


## Tour is page independent. To make tour go across the pages, The next button of the last step of the page should have the link of the next page and back button of the first step of the page should have the link of the previous page. Either you are going back or going forward you need to set the local storage variable 'return_back' to true or false. This helps you maintain the flow across the pages. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tour_guide'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tour_guide

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tour_guide. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

