class Weather < OpenStruct
  # #<Weather observation_time="09:42 PM", temperature=-3, weather_code=122,
  # weather_icons=["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"],
  # weather_descriptions=["Overcast"], wind_speed=6, wind_degree=40, wind_dir="NE", pressure=1009, precip=0,
  # humidity=93, cloudcover=100, feelslike=-7, uv_index=1, visibility=10, is_day="no", location="Turku">
  def self.rendered_fields
    [:temperature, :weather_icons, :wind_speed, :wind_dir]
  end
end
