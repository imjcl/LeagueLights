module LeagueLights
  def self.match_free_champions
    unless REDIS.exists 'free_ids'
      REDIS.set 'free_ids', RiotAPI::Champion.get_free_champions
      REDIS.expire 'free_ids', 432000
    end

    unless REDIS.exists 'static_data'
      REDIS.set 'static_data', RiotAPI::StaticData.get_champion_static_data
      REDIS.expire 'static_data', 432000
    end

    free_ids = JSON.parse REDIS.get 'free_ids'
    static_data = JSON.parse REDIS.get 'static_data'
    champion_data = []

    free_ids["champions"].each do |champion|
      champion_data << static_data["data"].select { |name, value| value["id"] == champion["id"] }
    end
    
    champion_data
  end

  def self.match_champion_to_id champion_name
    # Adding this just in the event, that we get a direct link with weird casing.
    champion_name.downcase!

    unless REDIS.exists 'static_data'
      REDIS.set 'static_data', RiotAPI::StaticData.get_champion_static_data
    end
    champion_info = (JSON.parse REDIS.get 'static_data')['data']

    match = champion_info.select do |k, v| 
      k.downcase == champion_name
    end

    id = match[match.keys[0]]["id"]

    unless REDIS.exists "#{id}_ability"
      REDIS.set "#{id}_ability", (RiotAPI::StaticData.get_champion_abilities id)
      REDIS.expire "#{id}_ability", 432000
    end

    abilities = JSON.parse REDIS.get "#{id}_ability"
  end  
end