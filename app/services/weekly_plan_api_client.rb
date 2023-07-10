class WeeklyPlanApiClient
  def initialize(profile)
    @calories = profile.daily_calories["goals"]["Weight loss"]["calory"]
  end

  def fetch_weekly_plan
    url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=week&targetCalories=#{@calories}&diet=vegetarian&exclude=shellfish%2C%20olives")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV.fetch('RAPID_API_KEY')
    request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'

    response = http.request(request)
    # binding.break
      items = JSON.parse(response.read_body)["items"]
      items.group_by { |item| item["day"] }
  end

  def fetch_meal(id)
    url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/information?includeNutrition=true")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'bbe3ae6043msh65faa6d70c21d77p153ce9jsne9638654940e'
    request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'

    response = http.request(request)
    JSON.parse(response.read_body)
  end
end

# client = WeeklyPlanApiClient.new(Profile.first)
# client.fetch_weekly_plan
