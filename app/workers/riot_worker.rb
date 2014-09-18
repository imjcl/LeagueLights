class RiotWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing Riot work!'
  end
end