module RiotServices
  def self.match_champion_to_id champion_name
    champion_info = (RiotAPI::StaticData.get_champion_static_data)["data"]
    match = champion_info.select { |k, v| k == champion_name.capitalize }
    id = match[champion_name.capitalize]["id"]

    RiotAPI::StaticData.get_champion_abilities id
  end
end