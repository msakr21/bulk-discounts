require 'rails_helper'
require './lib/holiday'


RSpec.describe Holiday do
  response = "[{\"date\":\"2022-11-24\",\"localName\":\"Thanksgiving Day\",\"name\":\"Thanksgiving Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":1863,\"types\":[\"Public\"]},{\"date\":\"2022-12-26\",\"localName\":\"Christmas Day\",\"name\":\"Christmas Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-01-02\",\"localName\":\"New Year's Day\",\"name\":\"New Year's Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-01-16\",\"localName\":\"Martin Luther King, Jr. Day\",\"name\":\"Martin Luther King, Jr. Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-02-20\",\"localName\":\"Presidents Day\",\"name\":\"Washington's Birthday\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]}]"

  let(:base_uri) { "https://date.nager.at/api/v3/NextPublicHolidays/US" } 
  let(:response_body) { response }

  it "has a method 'upcoming holidays' that returns a hash of the next 3 holidays in the US" do
    stub_request(:get, base_uri).
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: response_body, headers: {})

    expect(Holiday.new.upcoming_holidays.length).to eq(3)
    expect(Holiday.new.upcoming_holidays).to eq([{:date=>"2022-11-24", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :types=>["Public"]},
      {:date=>"2022-12-26", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :types=>["Public"]},
      {:date=>"2023-01-02", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :types=>["Public"]}])
  end

  it "has a method 'next_3_holidays' that returns a hash of only the name and date of the next three holidays" do
    stub_request(:get, base_uri).
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: response_body, headers: {})

    expect(Holiday.new.next_3_holidays). to eq({"Thanksgiving Day"=>"2022-11-24", "Christmas Day"=>"2022-12-26", "New Year's Day"=>"2023-01-02"})
  end
end