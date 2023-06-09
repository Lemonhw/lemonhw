class CreateWeeklyPlanJob < ApplicationJob
  queue_as :default

  def perform(user, age, bmr, calories_per_day, params)
    user_info = {
      age: age,
      gender: user.gender,
      height: user.height
    }

    @weekly_plan = WeeklyPlan.create!(params.merge(user: user))

    plans_json = fetch_plans(user_info, params, calories_per_day)
    week_diet_plan = JSON.parse(plans_json[:diet_plan])
    week_exercise_plan = JSON.parse(plans_json[:exercise_plan])
    diet_plans = week_diet_plan.values
    exercise_plans = week_exercise_plan.values

    (0...6).to_a.each do |index|
      @day_plan = DayPlan.create!(
        day_number: index + 1,
        weekly_plan: @weekly_plan
      )
      DietPlan.create!(
        day_plan_content: diet_plans[index],
        day_plan: @day_plan
      )
      ExercisePlan.create!(
        day_plan_content: exercise_plans[index],
        day_plan: @day_plan
      )
    end
  end

  def fetch_plans(user_info, params, calories)
    # Access the API key based on the current environment
    # development:
    config_file = File.join(File.dirname(__FILE__), '..', '..', 'config', 'api_keys.yml')
    config = YAML.load_file(config_file)
    api_key = config['development']['api_key']
    # production
    # config_file = Rails.root.join('config', 'api_keys.yml')
    # api_key = config[Rails.env]['api_key']
    client = OpenAI::Client.new(access_token: api_key, request_timeout: 240) do |config|
      config.http_client = Faraday.new do |faraday|
        faraday.options.timeout = 180 # Set the response timeout to 180 seconds
        faraday.options.open_timeout = 180 # Set the connection timeout to 180 seconds
      end
    end

    age, gender, height = user_info.values_at(:age, :gender, :height)
    current_weight, weight_goal, fitness_goal = params.values_at(:current_weight, :weight_goal, :fitness_goal)

    if fitness_goal.downcase == "weight loss"
      prompt_for_fitness_goal = "They want to get down to #{weight_goal}"
    else
      prompt_for_fitness_goal = "They want to get up to #{weight_goal}"
    end

    # The daily calories is currently hardcoded. It must be modified to accept variables. AI would not return appropriate response.
    diet_prompt = "You are a personal trainer.
      I want to lose weight.
      Suggest a 7 day diet plan for me. Do not include any introductory text.
      Start your response with Day 1.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      With each day as a key and the value as each meal (breakfast, lunch, dinner and snack) and the total_calories for the day separated into separate keys.
      The value of each meal key should be a list of the different foods each meal contains and a total_calories key of which the value is total amount of calories in the meal.
      The total_calories for each day MUST amount to between 2000 and 2600.
      Those foods should be keys themselves with the value being the calories that each food contains.
      Every key should be lowercase and separated by underscores.
      Do not include line breaks. The response must be no greater than 1500 tokens."

    exercise_prompt = "You are a personal trainer.
      I am a #{age} year old #{gender} who weighs #{current_weight}kg.
      #{prompt_for_fitness_goal}
      Suggest a 7 day exercise plan me. Do not include any introductory text.
      Each exercise should take 10 minutes.
      Start your response with Day 1.
      For each day, list 5 distinct exercises that I can do.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      With each day as a key and the value as each exercise separated into separate keys.
      The value of each exercise key should be a brief description of the exercise and how long the exercise should be done for given the 45 minute restraint.
      Every key should be lowercase and separated by underscores.
      Do not include line breaks. The response must be no greater than 1500 tokens."

    diet_plan = make_request(diet_prompt, client)
    exercise_plan = make_request(exercise_prompt, client)

    return {diet_plan: diet_plan, exercise_plan: exercise_plan}
  end

  def make_request(prompt_type, client)
    # response = client.completions(
    #   parameters:{
    #     model: model,
    #     prompt: prompt_type,
    #     max_tokens: 3600
    #   }

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: prompt_type}], # Required.
        temperature: 0.7
      }
    )
    # response = client.completions(
    #   parameters: {
    #     model: "text-davinci-003",
    #     prompt: prompt_type,
    #     max_tokens: 1500
    #   }
    # )
    puts response
    response["choices"][0]["message"]["content"]
  end
end
