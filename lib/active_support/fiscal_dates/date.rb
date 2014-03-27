class Date
  def self.current_financial_year
    today = Date.today
    today.month < 7 ? today.year : today.year + 1
  end

  def financial_year
    self.month < 7 ? self.year : self.year + 1
  end

  def financial_year_first_day
    if self.month < 7
      Date.new(self.year - 1, 7)
    else
      Date.new(self.year, 7)
    end
  end

  def financial_year_last_day
    if self.month < 7
      Date.new(self.year, 6).end_of_month
    else
      Date.new(self.year + 1, 6).end_of_month
    end
  end
end
