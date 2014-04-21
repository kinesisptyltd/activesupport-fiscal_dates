require "spec_helper"
require "pry"
require "pry-debugger"

describe Date do
  describe ".current_fiscal_year" do
    context "before july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 1) } }

      it "returns the correct fiscal year" do
        expect(Date.current_fiscal_year).to eq 2013
      end
    end

    context "after july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 8) } }

      it "returns the correct fiscal year" do
        expect(Date.current_fiscal_year).to eq 2014
      end
    end
  end

  describe ".current_fiscal_year_range" do
    context "before july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 1) } }

      it "returns the correct fiscal year range" do
        expect(Date.current_fiscal_year_range).to eq Date.new(2012, 7)..Date.new(2013, 6, 30)
      end
    end

    context "after july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 8) } }

      it "returns the correct fiscal year" do
        expect(Date.current_fiscal_year_range).to eq Date.new(2013, 7)..Date.new(2014, 6, 30)
      end
    end
  end


  describe ".fiscal_year_ranges_between" do
    let(:start_date) { Date.new(2012, 1) }
    let(:end_date) { Date.new(2014, 8) }

    it "returns an array" do
      expect(Date.fiscal_year_ranges_between(start_date, end_date)).to be_an Array
    end

    it "returns the correct number of elements" do
      expect(Date.fiscal_year_ranges_between(start_date, end_date).length).to eq 4
    end

    it "contains ranges" do
      expect(Date.fiscal_year_ranges_between(start_date, end_date).first).to be_a Range
    end

    it "contains ranges with the correct dates" do
      expect(Date.fiscal_year_ranges_between(start_date, end_date).first).to eq Date.new(2011, 7)..Date.new(2012, 6 ,30)
    end
  end

  describe "#fiscal_year" do
    context "before july" do
      let(:date) { Date.new(2013, 01) }

      it "returns the correct fiscal year" do
        expect(date.fiscal_year).to eq date.year
      end
    end

    context "after july" do
      let(:date) { Date.new(2013, 8) }

      it "returns the correct fiscal year" do
        expect(date.fiscal_year).to eq date.year + 1
      end
    end
  end

  describe "#fiscal_year_first_day" do
    context "before july" do
      let(:date) { Date.new(2013, 01) }

      it "returns the correct date" do
        expect(date.fiscal_year_first_day).to eq Date.new(2012, 7)
      end
    end

    context "after july" do
      let(:date) { Date.new(2013, 8) }

      it "returns the correct date" do
        expect(date.fiscal_year_first_day).to eq Date.new(2013, 7)
      end
    end
  end

  describe "#fiscal_year_last_day" do
    context "before july" do
      let(:date) { Date.new(2013, 01) }

      it "returns the correct date" do
        expect(date.fiscal_year_last_day).to eq Date.new(2013, 6, 30)
      end
    end

    context "after july" do
      let(:date) { Date.new(2013, 8) }

      it "returns the correct date" do
        expect(date.fiscal_year_last_day).to eq Date.new(2014, 6, 30)
      end
    end
  end

  describe "#fiscal_year_range" do
    let(:date) { Date.new(2013, 01) }

    it "returns a range" do
      expect(date.fiscal_year_range).to be_a Range
    end

    it "returns the correct dates" do
      expect(date.fiscal_year_range).to eq Date.new(2012, 7)..Date.new(2013, 6, 30)
    end
  end

  describe "#calendar_year_first_day" do
    let(:date) { Date.new(2013, 8) }

    it "returns the correct date" do
      expect(date.calendar_year_first_day).to eq Date.new(2013, 1, 1)
    end
  end

  describe "#calendar_year_last_day" do
    let(:date) { Date.new(2013, 8) }

    it "returns the correct date" do
      expect(date.calendar_year_last_day).to eq Date.new(2013, 12, 31)
    end
  end

  describe "#calendar_year_range" do
    let(:date) { Date.new(2013, 8) }

    it "returns a range" do
      expect(date.calendar_year_range).to be_a Range
    end

    it "returns the correct dates" do
      expect(date.calendar_year_range).to eq Date.new(2013, 1)..Date.new(2013, 12, 31)
    end
  end
end
