class HighlightsController < ApplicationController
  def index
    @champions = LeagueLights.match_free_champions
  end
end