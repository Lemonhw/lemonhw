class WeeklyPlanApiClient

  def fetch_plans(user_info, criteria)
    # Access the API key based on the current environment
    # development:
    config_file = File.join(File.dirname(__FILE__), '..', '..', 'config', 'api_keys.yml')
    config = YAML.load_file(config_file)
    api_key = config['development']['api_key']
    # production
    # config_file = Rails.root.join('config', 'api_keys.yml')
    # api_key = config[Rails.env]['api_key']
    client = OpenAI::Client.new(access_token: api_key) do |config|
      config.http_client = Faraday.new do |faraday|
        faraday.options.timeout = 180 # Set the response timeout to 180 seconds
        faraday.options.open_timeout = 180 # Set the connection timeout to 180 seconds
      end
    end

    age, gender, height = user_info.values_at(:age, :gender, :height)
    current_weight, weight_goal, fitness_goal = criteria.values_at(:current_weight, :weight_goal, :fitness_goal)

    if fitness_goal.downcase == "weight loss"
      prompt_for_fitness_goal = "They want to get down to #{weight_goal}"
    else
      prompt_for_fitness_goal = "They want to get up to #{weight_goal}"
    end

    diet_prompt = <<~PROMPT
      You are a personal trainer.
      Your client is a #{age} year old #{gender} who weighs #{current_weight}kg.
      #{prompt_for_fitness_goal}
      Suggest a 7 day diet plan for them. Do not include any introductory text.
      Start your response with Day 1.
      After you have finished day 7 give a bief explanation of the diet plan, explaining why this diet plan suits your client.
      Give the explanation as though you are addressing your client.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      With each day as a key and the value as each meal (breakfast, lunch, dinner and snack) separated into separate keys.
      The value of each meal key should be a list of the different foods each meal contains and a total_calories key of which the value is total amount of calories in the meal.
      Those foods should be keys themselves with the value being the calories that each food contains.
      The final explanation should be a key with the value being the explanation.
      Every key should be lowercase and separated by underscores.
      Do not include line breaks. The response must be under 4000 tokens.
    PROMPT

    exercise_prompt = <<~PROMPT
      You are a personal trainer.
      Your client is a #{age} year old #{gender} who weighs #{current_weight}kg.
      #{prompt_for_fitness_goal}
      Suggest a 7 day exercise plan for them. Do not include any introductory text.
      Start your response with Day 1.
      For each day, list 5 distinct exercises that the client can do.
      After you have finished day 7 give a bief explanation of the exercise plan, explaining why this exercise plan suits your client.
      Give the explanation as though you are addressing your client.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      With each day as a key and the value as each exercise separated into separate keys.
      The value of each exercise key should be a brief description of the exercise.
      The final explanation should be a key with the value being the explanation.
      Every key should be lowercase and separated by underscores.
      Do not include line breaks. The response must be under 4000 tokens.
    PROMPT

    test_prompt = <<~PROMPT
      You are a personal trainer.
      Your client is a #{age} year old #{gender} who weighs #{current_weight}kg.
      Suggest a 7-day diet plan and a 7-day exercise plan for them. Do not include any introductory text.
      For the diet plan, start your response with Day 1. After you have finished day 7, give a brief explanation of the diet plan, explaining why this diet plan suits your client.
      For the exercise plan, start your response with Day 1. For each day, list 5 distinct exercises that the client can do. After you have finished day 7, give a brief explanation of the exercise plan, explaining why this exercise plan suits your client.
      Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
      For the diet plan, use the "diet_plan" key and include nested keys inside it with each day as a key and the value as each meal (breakfast, lunch, dinner, and snack) separated into separate keys. The value of each meal key should be a list of the different foods each meal contains, and a "total_calories" key with the value being the total amount of calories in the meal. The foods should be keys themselves with the value being the calories that each food contains.
      For the exercise plan, use the "exercise_plan" key and include nested keys inside it with each day as a key and the value as each exercise separated into separate keys. The value of each exercise key should be a brief description of the exercise.
      The final explanation for both the diet plan and the exercise plan should be a key with the value being the explanation.
      Every key should be lowercase and separated by underscores. Do not include line breaks. The response must be under 10000 tokens.
    PROMPT

    diet_plan = make_request(diet_prompt, client)
    exercise_plan = make_request(exercise_prompt, client)

    return {diet_plan: diet_plan, exercise_plan: exercise_plan}
  end

  private

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
          temperature: 0.7,
      })
    puts response
    response["choices"][0]["message"]["content"]
  end
end
