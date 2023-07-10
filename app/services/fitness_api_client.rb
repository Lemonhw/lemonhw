class FitnessApiClient

  def initialize(profile)
    @base_url = 'https://fitness-calculator.p.rapidapi.com'
    @height = profile.height.to_s
    @weight = profile.weight.to_s
    @age = profile.age.to_s
    @activity_level = profile.activity_level
    @gender = profile.gender
    @age = profile.age
    # @height = "180"
    # @weight = "90"
    # @age = "29"
    # @activity_level = "level_2"
    # @gender = "male"
  end

  def calc_bmi
    url = URI("#{@base_url}/bmi?age=#{@age}&weight=#{@weight}&height=#{@height}")
    return make_request(url)["bmi"]
  end

  def calc_daily_calories
    url = URI("#{@base_url}/dailycalorie?age=#{@age}&gender=#{@gender}&height=#{@height}&weight=#{@weight}&activitylevel=#{@activity_level}")
    return make_request(url)
  end

  def calc_ideal_weight
    url = URI("#{@base_url}/idealweight?gender=#{@gender}&height=#{@height}")
    result = make_request(url)
    return result
  end

  private

  def make_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV.fetch('RAPID_API_KEY')
    request["X-RapidAPI-Host"] = 'fitness-calculator.p.rapidapi.com'

    response = http.request(request)
    puts response.read_body
    JSON.parse(response.read_body)["data"]
  end
end
