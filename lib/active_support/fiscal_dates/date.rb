class Date
  def self.current_fiscal_year
    # Returns "2015" for FY 2014-15
    today = Date.today
    today.month < 7 ? today.year : today.year + 1
  end

  def self.current_fiscal_year_range
    today = Date.today
    if today.month < 7
      Date.new(today.year - 1, 7)..Date.new(today.year, 6, 30)
    else
      Date.new(today.year, 7)..Date.new(today.year + 1, 6, 30)
    end
  end

  def self.fiscal_year_ranges_between(start_date, end_date)
    (start_date.fiscal_year_first_day.year..end_date.fiscal_year_first_day.year).map do |year|
      Date.new(year, 7).fiscal_year_range
    end
  end

  def self.calendar_year_ranges_between(start_date, end_date)
    (start_date.year..end_date.year).map { |year| Date.new(year).calendar_year_range }
  end

  def self.fiscal_years_since(start_year)
    # Includes the current fiscal year
    # Output gets set in .fiscal_year_label
    # Suitable for year select dropdowns in Corporate.

    result = []
    today = Date.today
    current_year = today.year.to_i
    month = today.month.to_i
    end_year = month >= 7 ? current_year + 1 : current_year

    (start_year..end_year).each do |year|
      result << [fiscal_year_label(year), year.to_s]
    end

    result
  end

  def self.fiscal_year_label(year)
    # Output example: [["2012-13", "2013"], ["2013-14", "2014"]]

    "#{year - 1}-#{year.to_s[-2, 2]}"
  end

  def fiscal_year
    self.month < 7 ? self.year : self.year + 1
  end

  def fiscal_year_first_day
    if self.month < 7
      Date.new(self.year - 1, 7)
    else
      Date.new(self.year, 7)
    end
  end

  def fiscal_year_last_day
    if self.month < 7
      Date.new(self.year, 6).end_of_month
    else
      Date.new(self.year + 1, 6).end_of_month
    end
  end

  def fiscal_year_range
    fiscal_year_first_day..fiscal_year_last_day
  end

  def calendar_year_first_day
    Date.new(self.year)
  end

  def calendar_year_last_day
    Date.new(self.year).end_of_year
  end

  def calendar_year_range
    calendar_year_first_day..calendar_year_last_day
  end
end
