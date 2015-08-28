# ChinaBank::PayrollTextFile

[![Gem Version](https://badge.fury.io/rb/china_bank-payroll_text_file.svg)](http://badge.fury.io/rb/china_bank-payroll_text_file)
[![Code Climate](https://codeclimate.com/github/payrollhero/china_bank-payroll_text_file/badges/gpa.svg)](https://codeclimate.com/github/payrollhero/china_bank-payroll_text_file)
[![Build Status](https://travis-ci.org/payrollhero/china_bank-payroll_text_file.svg)](https://travis-ci.org/payrollhero/china_bank-payroll_text_file)

A payroll text file generator for China Bank. This specifically supports the format [China Bank Auto
Credit Arrangement (ACA)](http://www.chinabank.ph/business.aspx?title=China+Bank+Auto+Credit+Arrangement+%28ACA%29) requires.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'china_bank-payroll_text_file'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install china_bank-payroll_text_file

## Usage

```ruby
    file = ChinaBank::PayrollTextFile.generate account_type: "SA",
                                               account_number: "1850889513",
                                               bank_code: "102",
                                               transactions: [
                                                 {
                                                   account_type: "CA",
                                                   account_number: "2030347812",
                                                   bank_code: "102",
                                                   amount: BigDecimal("12965.50")
                                                 }
                                               ]

    file.content #=> "*CA2030347812   00000012965.50 C102*\r\n*SA1850889513   00000012965.50 D102*"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/china_bank-payroll_text_file/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
