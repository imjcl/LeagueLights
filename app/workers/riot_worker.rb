class RiotWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    unless REDIS.exists 'free_ids'
      REDIS.set 'free_ids', RiotAPI::Champion.get_free_champions
      REDIS.expire 'free_ids', 432000
    end

    unless REDIS.exists 'static_data'
      REDIS.set 'static_data', RiotAPI::StaticData.get_champion_static_data
      REDIS.expire 'static_data', 432000
    end
  end
end