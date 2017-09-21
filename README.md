# Activesupport::FiscalDates

Activesupport::FiscalDates adds some useful methods for fiscal year calculations to the `Date` class. Currently it only supports the Australian fiscal year period (July to June).

## Installation

Add this line to your application's Gemfile:

    gem 'activesupport-fiscal_dates'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activesupport-fiscal_dates

## Usage

### Getting Fiscal Years and Ranges

Use `.current_fiscal_year` to get the current fiscal year as an integer. Returns `2015` for FY 2014-15.

```ruby
# Today is September 10th, 2014

Date.current_fiscal_year
# => 2015
```

Or get the fiscal year range with `.current_fiscal_year_range`.

```ruby
# Today is September 10th, 2014

Date.current_fiscal_year_range
# => Tue, 01 Jul 2014..Tue, 30 Jun 2015
```

Use `.fiscal_year_ranges_between` and `.calendar_year_ranges_between` to get an array of fiscal or calendar year ranges.

```ruby
start_date = Date.new(2012)
end_date = Date.new(2014)

Date.fiscal_year_ranges_between(start_date, end_date)

# => [
#     [0] Fri, 01 Jul 2011..Sat, 30 Jun 2012,
#     [1] Sun, 01 Jul 2012..Sun, 30 Jun 2013,
#     [2] Mon, 01 Jul 2013..Mon, 30 Jun 2014
# ]

Date.calendar_year_ranges_between(start_date, end_date)

# => [
#     [0] Sun, 01 Jan 2012..Mon, 31 Dec 2012,
#     [1] Tue, 01 Jan 2013..Tue, 31 Dec 2013,
#     [2] Wed, 01 Jan 2014..Wed, 31 Dec 2014
# ]
```

Use `.fiscal_years_since` to create an array of arrays of the format `[label, value]` that's useful for `<select>` options. It includes the current fiscal year. The output style is set in `.fiscal_year_label`.

```ruby
Date.fiscal_years_since(2012)

# => [
#     [0] [
#         [0] "2011-12",
#         [1] "2012"
#     ],
#     [1] [
#         [0] "2012-13",
#         [1] "2013"
#     ],
#     [2] [
#         [0] "2013-14",
#         [1] "2014"
#     ]
#     [3] [
#         [0] "2014-15",
#         [1] "2015"
#     ]
# ]
```

### Instance methods

Use `#fiscal_year` to get the specified date's fiscal year as an integer.

```ruby
Date.new(2014, 7).fiscal_year
# => 2015
```

Use `#fiscal_year_first_day`, `#fiscal_year_last_day`, `#calendar_year_first_day` and `#calendar_year_last_day` to get those specific days.

```ruby
Date.new(2014, 1).fiscal_year_first_day
# => Mon, 01 Jul 2013

Date.new(2014, 1).fiscal_year_last_day
# => Mon, 30 Jun 2014

Date.new(2014, 1).calendar_year_first_day
# => Wed, 01 Jan 2014

Date.new(2014, 1).calendar_year_last_day
# => Wed, 31 Dec 2014
```

And use `#fiscal_year_range` and `#calendar_year_range` to get the individual year as a range.

```ruby
Date.new(2014, 1).fiscal_year_range
# => Mon, 01 Jul 2013..Mon, 30 Jun 2014

Date.new(2014, 1).calendar_year_range
# => Wed, 01 Jan 2014..Wed, 31 Dec 2014
```
