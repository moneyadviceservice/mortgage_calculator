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

## Usage

To start the dummy application:

```sh
$ cd spec/dummy
$ rails s
```

## Running JS Tests

Unit tests are handled by Karma while End 2 End tests are dealt with Protractor. To run tests you
need to have both installed which can be done via NPM (note, you also need to have node installed)
to do this.

```sh
$ npm install
```

Run unit tests:

```sh
$ rake app:karma:run
```


## Running Ruby Tests

RSpec is used for unit tests. These tests can be ran with the following command.

```sh
bundle exec rspec
```

There are yet any integration tests. These will be added soon.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
