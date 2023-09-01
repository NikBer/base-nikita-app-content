require 'net/http'
require 'uri'
require 'json'

class ChatGPTApiService
  API_ENDPOINT = 'https://api.openai.com/v1/engines/davinci-codex/completions'

  def initialize(api_key: ENV['OPENAI_API_KEY'])
    @api_key = api_key
  end

  def generate_prompt_response(prompt)
    uri = URI(API_ENDPOINT)
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{@api_key}"
    request['Content-Type'] = 'application/json'
    request.body = JSON.dump({
      'prompt' => prompt,
      'max_tokens' => 60
    })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    JSON.parse(response.body)['choices'].first['text'].strip
  rescue => e
    Rails.logger.error("Error generating prompt with ChatGPT API: #{e.message}")
    nil
  end
end
