class ExercisesApiClient
  def fetch_exercises(type, muscle, difficulty, offset)
    url = URI("https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?type=#{type}&muscle=#{muscle}&difficulty=#{difficulty}&offset=#{offset}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV.fetch('RAPID_API_KEY')
    request["X-RapidAPI-Host"] = 'exercises-by-api-ninjas.p.rapidapi.com'

    response = http.request(request)
    response.read_body
  end
end
