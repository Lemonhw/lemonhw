class WeeklyPlanApiClient
  def initialize
    @calories = current_user.profile.daily_calories
  end

  def fetch_weekly_plan
    url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=week&targetCalories=#{daily_calories}&diet=vegetarian&exclude=shellfish%2C%20olives")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'bbe3ae6043msh65faa6d70c21d77p153ce9jsne9638654940e'
    request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'

    response = http.request(request)
    puts response.read_body
  end

  def fetch_recipe

  end
end

client = WeeklyPlanApiClient.new
# client.fetch_weekly_plan
