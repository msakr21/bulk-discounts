require 'rails_helper'
require './lib/holiday'

RSpec.describe Holiday do
  it "has a method 'upcoming holidays' that returns a hash of the next 3 holidays in the US" do
    # time_set = Time.new(2022, 11, 25)
    # allow(Time).to receive(:now).and_return(time_set)
    # time_now = Time.now
    expect(Holiday.new.upcoming_holidays.length).to eq(3)
    expect(Holiday.new.upcoming_holidays).to eq([{:date=>"2022-11-24", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :types=>["Public"]},
      {:date=>"2022-12-26", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :types=>["Public"]},
      {:date=>"2023-01-02", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :types=>["Public"]}])
  end

  it "has a method 'next_3_holidays' that returns a hash of only the name and date of the next three holidays" do
    expect(Holiday.new.next_3_holidays). to eq({"Thanksgiving Day"=>"2022-11-24", "Christmas Day"=>"2022-12-26", "New Year's Day"=>"2023-01-02"})
  end
end