module HighlightsHelper
  def champion_name champion
    champion.keys[0]
  end

  def champion_title champion
    champion[champion.keys[0]]["title"]
  end

  def champion_splash champion
    "#{champion.keys[0].downcase}.jpg"
  end
end