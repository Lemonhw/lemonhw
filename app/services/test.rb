require 'benchmark'
require 'yaml'
require 'faraday'
require 'openai'

class TestAPIClient

  def fetch_plans
    time = Benchmark.measure do
      config_file = File.join(File.dirname(__FILE__), '..', '..', 'config', 'api_keys.yml')
      config = YAML.load_file(config_file)
      api_key = config['development']['api_key']
      # production:
      # config_file = Rails.root.join('config', 'api_keys.yml')
      # api_key = config[Rails.env]['api_key']
      client = OpenAI::Client.new(access_token: api_key, request_timeout: 240) do |config|
        config.http_client = Faraday.new do |faraday|
          faraday.options.timeout = 360 # Set the timeout to 60 seconds
          faraday.options.open_timeout = 360 # Set the connection timeout to 60 seconds
        end
      end

      age = 65
      gender = "male"
      height = 180
      dietary_requirements = "vegetarian"
      current_weight = 100
      weight_goal = 90


      prompt = <<~PROMPT
        You are a personal trainer.
        Your client is a #{age} year old #{gender} who weighs #{current_weight}kg. They are #{height}cm tall and their dietary requirements are: #{dietary_requirements}.
        They want to lose #{current_weight - weight_goal}kg.
        Suggest a 7-day diet plan and a 7-day exercise plan for them. Do not include any introductory text.
        For the diet plan, start your response with Day 1. After you have finished day 7, give a brief explanation of the diet plan, explaining why this diet plan suits your client.
        For the exercise plan, start your response with Day 1. For each day, list 5 distinct exercises that the client can do. After you have finished day 7, give a brief explanation of the exercise plan, explaining why this exercise plan suits your client.
        Give the entire response in JSON format. The response should be enclosed in curly braces and each key should be enclosed in double quotes.
        For the diet plan, use the "diet_plan" key and include nested keys inside it with each day as a key and the value as each meal (breakfast, lunch, dinner, and snack) separated into separate keys. The value of each meal key should be a list of the different foods each meal contains, and a "total_calories" key with the value being the total amount of calories in the meal. The foods should be keys themselves with the value being the calories that each food contains.
        For the exercise plan, use the "exercise_plan" key and include nested keys inside it with each day as a key and the value as each exercise separated into separate keys. The value of each exercise key should be a brief description of the exercise.
        The final explanation for both the diet plan and the exercise plan should be a key with the value being the explanation.
        Every key should be lowercase and separated by underscores. Do not include line breaks or whitespace in the response. The response should be able to be converted from JSON to a ruby hash when passed to the JSON.parse method. The response must be not greater than 7500 tokens.
      PROMPT

      diet_prompt = <<~PROMPT
        You are a personal trainer.
        Your client is a #{age} year old #{gender} who weighs #{current_weight}kg.
        They want to lose #{current_weight - weight_goal}kg.
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
        Do not include line breaks. The response must be no greater than 1500 tokens.
      PROMPT

      exercise_prompt = <<~PROMPT
        You are a personal trainer.
        Your client is a #{age} year old #{gender} who weighs #{current_weight}kg.
        They want to lose #{current_weight - weight_goal}kg.
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
        Do not include line breaks. The response must be no greater than 1500 tokens.
      PROMPT

      # response = client.chat(
      #   parameters: {
      #     model: "text-davinci-003", # Required.
      #     messages: [{ role: "user", content: prompt }], # Required.
      #     temperature: 0.7
      #   }
      # )

      diet_response = client.completions(
        parameters: {
          model: "text-davinci-002",
          prompt: diet_prompt,
          max_tokens: 1500
        }
      )

      exercise_response = client.completions(
        parameters: {
          model: "text-davinci-002",
          prompt: exercise_prompt,
          max_tokens: 1500
        }
      )
      puts diet_response
      puts exercise_response
      # puts response["choices"][0]["message"]["content"]
      # response_parsed = JSON.parse(response["choices"][0]["message"]["content"])
      # puts response_parsed["exercise_plan"]["explanation"]
      # puts JSON.parse(response["choices"][0]["message"]["content"])
    end
  end
end
