require "openai"
require "faraday"
require "json"

class WeeklyPlanAPIClient

  def fetch_plans(user_info, criteria)

    api_key = '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'
    # production:
    # config_file = Rails.root.join('config', 'api_keys.yml')
    # api_key = config[Rails.env]['api_key']
    client = OpenAI::Client.new(access_token: api_key) do |config|
      config.http_client = Faraday.new do |faraday|
        faraday.options.timeout = 360 # Set the timeout to 60 seconds
      end
    end

    prompt = <<~PROMPT
    You are a personal trainer.
    Your client is a 55 year old male who weighs 150 kg.
    They want to get down to 100 kg.
    Suggest a 7 day diet plan for them. Do not include any introductory text.
    Start your response with Day 1.
    For each meal, list the calories that each food contains and the overall calories for the meal.
    After you have finished day 7 give a bief explanation of the diet plan, explaining why this diet plan suits your client.
    Give the explanation as though you are addressing your client.
    Give the response in JSON format. With each day as a key and the value as each meal separated into separate keys. Do not include line breaks. The response must be under 4000 tokens.
  PROMPT

    response = client.completions(
      parameters:{
        model: "text-davinci-003",
        prompt: prompt,
        max_tokens: 3800
      }
    )
    puts response
    puts response["choices"][0]["text"]
    puts JSON.parse(response["choices"][0]["text"])



  end
end
