require 'httparty'
require 'json'

class Holiday

  def call(url)
    HTTParty.get(url)
  end

  def upcoming_holidays
    response = call("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[0..2]
  end

  def next_3_holidays
    holiday_name_and_date = Hash.new
    upcoming_holidays.each do |holiday|
      holiday_name_and_date[holiday[:name]] = holiday[:date]
    end
    holiday_name_and_date
  end
end
