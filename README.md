Mortgage Calculator
===================

Rails engine, providing a suite of calculators to determine affordability.


## Installation

Add this line to your application's Gemfile:

```sh
git clone git@github.com:moneyadviceservice/mortgage_calculator.git
```

And then execute:

```sh
$ bundle
$ bower install
```
### Dependencies

In your application.html.erb layout or equivalent. Javascript code uses this attribute to determine which locale to display.
```erb
<body class="locale-<%= I18n.locale %>">
```

In the short term, this lambda or equivalent must be set. Public website, for example, injects a lambda that sets the tool's translation URL.

```ruby
MortgageCalculator.stamp_duty_welsh_fix = lambda do |tool, locale|
end
```


## Usage

To start the dummy application:

```sh
$ cd spec/dummy
$ rails s
```

## Tests

Ensure you have node and npm installed

```sh
$ npm install
```
Then run the test suite

```sh
bundle exec rake
```
This will run cucumber tests through poltergeist with and without javascript. It will then run rspec and karma.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
