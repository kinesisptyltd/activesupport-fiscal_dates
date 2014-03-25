class Date
  def self.current_financial_year
    today = Date.today
    today.month < 7 ? today.year : today.year + 1
  end

  def financial_year
    self.month < 7 ? self.year : self.year + 1
  end
end
