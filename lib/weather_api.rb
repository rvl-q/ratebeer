class WeatherApi
  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch("weather#{city}", expires_in: 1.hour) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    weather = response.parsed_response['current']
    location = response.parsed_response['location']['name'] if response.parsed_response['location']
    weather['location'] = location
    Weather.new(weather)
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?

    ENV.fetch('WEATHER_APIKEY')
  end
end
