require "spec_helper"

describe Date do

  describe ".current_financial_year" do
    context "before july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 1) } }

      it "returns the correct financial year" do
        expect(Date.current_financial_year).to eq 2013
      end
    end

    context "after july" do
      before { allow(Date).to receive(:today) { Date.new(2013, 8) } }

      it "returns the correct financial year" do
        expect(Date.current_financial_year).to eq 2014
      end
    end
  end

  describe "#financial_year" do
    context "before july" do
      let(:date) { Date.new(2013, 01) }

      it "returns the correct financial year" do
        expect(date.financial_year).to eq date.year
      end
    end

    context "after july" do
      let(:date) { Date.new(2013, 8) }

      it "returns the correct financial year" do
        expect(date.financial_year).to eq date.year + 1
      end
    end
  end
end
