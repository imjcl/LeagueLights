module RiotServices
  def self.match_champion_to_id champion_name
    champion_info = (RiotAPI::StaticData.get_champion_static_data)["data"]
    match = champion_info.select do |k, v| 
      k.downcase == champion_name
    end

    id = match[match.keys[0]]["id"]

    RiotAPI::StaticData.get_champion_abilities id
  end
end