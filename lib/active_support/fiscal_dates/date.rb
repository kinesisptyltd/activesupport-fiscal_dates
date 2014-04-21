class Date
  def self.current_fiscal_year
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
    start_date_fiscal_year_start = start_date.fiscal_year_first_day
    end_date_fiscal_year_start = end_date.fiscal_year_first_day

    (start_date_fiscal_year_start.year..end_date_fiscal_year_start.year).map do |year|
      Date.new(year, 7).fiscal_year_range
    end
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
