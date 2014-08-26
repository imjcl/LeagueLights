module RiotAPI
  BASE_URI = "https://na.api.pvp.net/api/lol"
  def self.riot_get endpoint
    JSON.parse RestClient.get "#{BASE_URI}/#{endpoint}"
  end

  module Champion
    VERSION = 'v1.2'
    def self.get_free_champions
      endpoint = "na/#{VERSION}/champion?freeToPlay=true&api_key=#{ENV['RIOT_KEY']}"
      RiotAPI::riot_get endpoint
    end
  end

  module StaticData
    VERSION = 'v1.2'
    def self.get_champion_static_data
      endpoint = "static-data/na/v1.2/champion?champData=info&api_key=#{ENV['RIOT_KEY']}"
      RiotAPI::riot_get endpoint
    end

    def self.get_champion_abilities id
      endpoint ="static-data/na/v1.2/champion/#{id}?champData=spells&api_key=#{ENV['RIOT_KEY']}"
      RiotAPI::riot_get endpoint
    end
  end
end