class FitnessApiClient

  def initialize
    @base_url = 'https://fitness-calculator.p.rapidapi.com'
    # @height = current_user.height.to_s
    # @weight = current_user.weight.to_s
    # @age = User.age.to_s
    # @activity_level = current_user.activity_level
    # @gender = current_user.gender
    @height = "180"
    @weight = "90"
    @age = "29"
    @activity_level = "level_2"
    @gender = "male"
  end

  def calc_bmi
    url = URI("#{@base_url}/bmi?age=#{@age}&weight=#{@weight}&height=#{@height}")
    return make_request(url)
  end

  def calc_daily_calories
    url = URI("https://fitness-calculator.p.rapidapi.com/dailycalorie?age=#{@age}&gender=#{@gender}&height=#{@height}&weight=#{@weight}&activitylevel=#{@activity_level}")
    return make_request(url)
  end

  def calc_ideal_weight
    url = URI("https://fitness-calculator.p.rapidapi.com/idealweight?gender=#{@gender}&height=#{@height}")
    return make_request(url)
  end

  private

  def make_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'bbe3ae6043msh65faa6d70c21d77p153ce9jsne9638654940e'
    request["X-RapidAPI-Host"] = 'fitness-calculator.p.rapidapi.com'

    response = http.request(request)
    puts response.read_body
    response["data"]
  end
end

client = FitnessApiClient.new
client.calc_bmi
client.calc_daily_calories
client.calc_ideal_weight
