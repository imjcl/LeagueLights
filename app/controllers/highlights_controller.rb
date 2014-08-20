class HighlightsController < ApplicationController
  def index
    @test = LeagueLights.match_free_champions
  end
end