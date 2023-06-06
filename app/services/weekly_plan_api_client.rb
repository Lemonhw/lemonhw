require "openai"
require "yaml"

class WeeklyPlanAPIClient

  def fetch_plans(user_info, criteria)
    # Access the API key based on the current environment
    # development:
    config_file = File.join(File.dirname(__FILE__), '..', '..', 'config', 'api_keys.yml')
    config = YAML.load_file(config_file)
    api_key = config['development']['api_key']
    # production:
    # config_file = Rails.root.join('config', 'api_keys.yml')
    # api_key = config[Rails.env]['api_key']
    client = OpenAI::Client.new(access_token: api_key)

    # Retrieve a list of models
    # models = client.models.list["data"]
    # models.each do |model|
    #   puts model["id"]
    # end
    age, gender, height = user_info.values_at(:age, :gender, :height)
    current_weight, weight_goal, fitness_goal = criteria.values_at(:current_weight, :weight_goal, :fitness_goal)

    model = "text-davinci-003"

    if fitness_goal.downcase == "weight loss"
      prompt_for_fitness_goal = "They want to get down to #{weight_goal}"
    else
      prompt_for_fitness_goal = "They want to get up to #{weight_goal}"
    end

    diet_prompt = <<~PROMPT
      My client is a #{age} year old #{gender} who weighs #{current_weight}kg.
      #{prompt_for_fitness_goal}
      Suggest me a 7 day diet plan for them. Do not include any introductory text.
      Start your response with Day 1.
      For each meal, list the calories that each food contains and the overall calories for the meal.
      After you have finished day 7 give a bief explanation of the diet plan, referencing the client's information I have given you and why this diet plan suits the client.
      Give the explanation as though you are addressing the client theirself.
    PROMPT

    exercise_prompt = <<~PROMPT
      My client is a #{age} year old #{gender} who weighs #{current_weight}kg.
      #{prompt_for_fitness_goal}
      Suggest me a 7 day exercise plan for them. Do not include any introductory text.
      Start your response with Day 1.
      For each day, list 5 distinct exercises that the client can do, giving brief instructions for each exercise.
      After you have finished day 7 give a bief explanation of the exercise plan, referencing the client's information I have given you and why this exercise plan suits the client.
      Give the explanation as though you are addressing the client theirself.
    PROMPT

  #  prompt = "My client is a #{age} year old #{gender} who weighs #{current_weight}kg. They want to #{fitness_goal} #{criteria[:weight_goal]}kg. Suggest me a 7 day diet plan for them. Do not include any introductory text. Start your response with Day 1 and end after you have finished Day 7. For each meal, list the calories that each food contains and the overall calories for the meal."

    diet_plan = make_request(diet_prompt)
    exercise_plan = make_request(exercise_prompt)

    return {diet_plan: diet_plan, exercise_plan: exercise_plan}
  end

  private

  def make_request(prompt_type)
    client.completions(
      parameters:{
        model: model,
        prompt: prompt_type,
        max_tokens: 2000
      }
    ).["choices"][0]["text"]
  end
end
