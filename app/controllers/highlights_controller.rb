class HighlightsController < ApplicationController
  def index
    @test = RiotAPI::Champion.get_free_champions
  end
end