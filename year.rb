class Year
  NUMBER_OF_WEEKDAYS = 250
  NUMBER_OF_SATURDAYS = 52
  NUMBER_OF_SUNDAYS = 51
  NUMBER_OF_PUBLIC_HOLIDAYS = 12

  # TODO loookup public holidays by region and year.

  START_YEAR = 2003

  # Returns an array of [month, year] which represents a financial reporting
  # year. month and year are numerical
  def self.financial_months(starting_year)
    result = []
    7.upto(12) {|n| result << [n, starting_year]}
    1.upto(6) {|n| result << [n, starting_year + 1]}
    result
  end

  # Returns true if today's date is past the end of the given financial year.
  def self.incomplete_financial_year(year)
    Date.today < financial_year_end_date(year)
  end

  def self.financial_months_menu_options(starting_year)
    result = ActiveSupport::OrderedHash.new
    7.upto(12) {|n| result["#{Date::MONTHNAMES[n]} #{starting_year}"] = "#{n},#{starting_year}"}
    1.upto(6) {|n| result["#{Date::MONTHNAMES[n]} #{starting_year + 1}"] = "#{n},#{starting_year + 1}"}
    result
  end

  def self.financial_months_menu_values(starting_year)
    result = []
    7.upto(12) {|n| result << "#{n},#{starting_year}"}
    1.upto(6) {|n| result << "#{n},#{starting_year + 1}"}
    result
  end

  def self.financial_months_menu_labels(starting_year)
    result = []
    7.upto(12) {|n| result << "#{n} #{starting_year}"}
    1.upto(6) {|n| result << "#{n} #{starting_year + 1}"}
    result
  end

  # Returns an array of [month, year] counting back from the given month, year,
  # by the given num_prior
  def self.months_prior(year, month, num_prior)
    count = num_prior.to_i
    y = year.to_i
    m = month.to_i
    result = []
    while count > 0
      result << [m, y]
      if m == 1
        y -= 1
        m = 12
      else
        m -= 1
      end
      count -= 1
    end
    return result
  end

  # Returns an array of [month, year] counting forward from the given month,
  # year, by the given num_prior
  def self.months_ahead(year, month, num_ahead)
    count = num_ahead.to_i
    y = year.to_i
    m = month.to_i
    result = []
    while count > 0
      result << [m, y]
      if m == 12
        y += 1
        m = 1
      else
        m += 1
      end
      count -= 1
    end
    return result
  end

  def self.natural_year_months(year)
    result = Array.new
    for month in 1..12
      result << [month, year]
    end
    result
  end

  # Returns an array of [year, month] starting from start_date and counting to
  # end_date
  def self.months_between(start_date, end_date)
    if start_date && end_date
      cur_year = start_date.year
      cur_month = start_date.month
      result = [[cur_month, cur_year]]
      while cur_year < end_date.year || cur_month < end_date.month
        if cur_month >= 12
          cur_month = 0
          cur_year += 1
        end
        cur_month += 1
        result << [cur_month, cur_year]
      end
      result
    else
      []
    end
  end

  # Returns an array of ranges for start_date =>
  # month_start_date..month_end_date
  def self.financial_year_month_ranges(starting_year)
    result = Array.new
    financial_months(starting_year).each {|m|
      result << month_range(m[1], m[0])
    }
    result
  end

  #Return the first_day_of_month for each month of the financial year of starting_year
  def self.financial_year_start_months(starting_year)
    result = Array.new
    financial_months(starting_year).each {|m|
      result << Date.new(m[1],m[0], 01)
    }
    result
  end

  def self.last_day_of_month(year, month)
    last_date_of_month(year.to_i, month.to_i).day
  end

  def self.last_date_of_month(year, month)
    d = Date.new(year.to_i, month.to_i, -1)
    d
  end

  # Returns a range from the first day to the last day of the month.
  def self.month_range(year, month)
    last_day = last_date_of_month(year, month)
    Range.new(Date.new(year.to_i, month.to_i, 1), last_day)
  end

  # Returns a range from the first day to the last day of the previous month
  def self.previous_month_range(year,month)
      y = month == 1 ? year - 1 : year
      m = month == 1 ? 12 : month - 1
      month_range(y,m)
  end

  # Returns a range from the first day to the last day of the next month
  def self.next_month_range(year,month)
      y = month == 12 ? year + 1 : year
      m = month == 12 ? 1 : month + 1
      month_range(y,m)
  end

  # Returns a hash with :first_day_of_month => (<first day of month>..<end of
  # month>)
  def self.month_range_condition(year, month)
    {:first_day_of_month => month_range(year, month)}
  end

  # returns an array with a start and end date for the given australian
  # financial year.
  def self.financial_year_dates(year)
    [financial_year_start_date(year), financial_year_end_date(year)]
  end

  def self.financial_year_range(starting_year)
    fyr = financial_year_dates(starting_year)
    Range.new(fyr[0], fyr[1])
  end

  def self.financial_years_range(starting_year, finishing_year)
    Range.new(financial_year_start_date(starting_year), financial_year_end_date(finishing_year))
  end

  def self.financial_year_start_date(year)
    if year.is_a? Date
      year = if year.month >= 7
               year.year
             else
               year.year - 1
             end
    end
    Date.new(year.to_i, 7, 1)
  end

  def self.financial_year_end_date(year)
    if year.is_a? Date
      year = if year.month >= 7
               year.year
             else
               year.year - 1
             end
    end
    Date.new(year.to_i + 1, 6, 30)
  end

  def self.natural_year_dates(year)
    [Date.new(year.to_i, 1, 1), Date.new(year.to_i, 12, 31)]
  end

  def self.natural_year_range(year)
    nyr = natural_year_dates(year)
    Range.new(nyr[0], nyr[1])
  end

  def self.year_range(year, financial = true)
    return Year.financial_year_range(year) if financial
    Year.natural_year_range(year)
  end

  def self.year_conditions(year, financial = true)
    return Year.financial_year_conditions(year) if financial
    Year.natural_year_conditions(year)
  end

  def self.natural_year_conditions(year)
    {:start_date => natural_year_range(year)}
  end

  def self.financial_year_conditions(starting_year)
    {:start_date => financial_year_range(starting_year)}
  end

  def self.useable_natural_years(start_year = START_YEAR)
    result = Array.new
    (start_year..DateTime.now.year).each {|y| result << y}
    result
  end

  def self.useable_financial_years(start_year = START_YEAR)
    result = Array.new
    now = DateTime.now
    y = now.year.to_i
    m = now.month.to_i
    c = y - 1
    c = y if m >= 7
    (start_year..c).each {|y| result << [financial_year_label(y), y.to_s]}
    result
  end

  def self.financial_year_label(starting_year)
    next_year = (starting_year.to_i + 1).to_s[-1,1]
    next_year = (starting_year.to_i + 1).to_s[-2,2] if (starting_year.to_i + 1).to_s[-2,2].to_i > 9
    "#{starting_year}-#{next_year}"
  end

  def self.in_financial_year?(date, starting_year)
    financial_year_range(starting_year).include?(date)
  end

  def self.financial_year_of(date)
    year = date.year
    month = date.month
    return year - 1 if month < 7
    year
  end

  def self.natural_years_range(starting_year, finishing_year)
    Range.new(Date.new(starting_year, 01, 01), last_date_of_month(finishing_year,12))
  end

  def self.financial_year_first_label(date)
    year = date.year
    if date.month > 6
      year
    else
      year - 1
    end
  end

  def self.current_financial_year
    current_year = Date.today.year
    month = Date.today.month
    month >= 7 ? current_year : current_year - 1
  end
end
