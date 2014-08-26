class HighlightsController < ApplicationController
  def index
    @champions = LeagueLights.match_free_champions
  end

  def champion_reel
    @champion = params[:champion] || ""
    @reel = GoogleService::get_highlights @champion
    @abilities = RiotServices::match_champion_to_id @champion
  end
end