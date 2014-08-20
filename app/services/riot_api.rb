module RiotAPI
  BASE_URI = "https://na.api.pvp.net/api/lol/na"
  def self.riot_get endpoint
    JSON.parse RestClient.get "#{BASE_URI}/#{endpoint}"
  end

  def self.get_free_champions
    VERSION = 'v1.2'
    endpoint = "/#{VERSION}/champion?api_key=#{RIOT_KEY}"
    riot_get endpoint
  end
end