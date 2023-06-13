class CreateWeeklyPlanJob # < ApplicationJob
  # queue_as :default

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

  def fetch_plans
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

    # The daily calories is currently hardcoded. It must be modified to accept variables. AI would not return appropriate response.
    prompt = "You are a personal trainer.
      I want to lose weight.
      Suggest a 7 day exercise plan for me. Do not include any introductory text.
      I like strength training and yoga.
      I only want to work out 3 days and rest for the other 4 days of the week. The values of the rest days should be 'rest'.
      Each workout should be 1 hour long.
      Start your response with Day 1.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      With each day as a key (e.g. day_1) and the value as the name of each exercise which are themselves keys.
      The value of each exercise key should be a short set of instructions for the exercise and how long should be spent doing the exercise.
      Every key should be lowercase and separated by underscores.
      Do not include line breaks. The response must be no greater than 1500 tokens."

    diet_plan = make_request(prompt, client)

    return diet_plan
  end

  def make_request(prompt_type, client)
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
    puts response["choices"][0]["message"]["content"]
    response["choices"][0]["message"]["content"]
  end
end
