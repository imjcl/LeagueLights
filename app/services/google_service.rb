require "google/api_client"
module GoogleService
  def self.get_highlights champion
    client = Google::APIClient.new(key: ENV['GOOGLE_API_KEY'], authorization: nil, application_name: 'LeagueLights', application_version: '0.0.1')
    youtube = client.discovered_api('youtube', 'v3')
    opts = {}
    opts[:part] = 'id,snippet'
    opts[:q] = "league of legends #{champion} highlights"
    opts[:maxResults] = 25
    opts[:publishedAfter] = six_months_ago
    opts[:order] = 'viewCount'

    videos = []
    result = client.execute(api_method: youtube.search.list, parameters: opts)
    result.data.items.each do |sr|
      case sr.id.kind
        when 'youtube#video'  
          videos.push([sr.snippet.title, sr.id.videoId])
      end
    end

    videos
  end

  def self.six_months_ago
    now = DateTime.now
    n_month = DateTime.now.mon
    n_year  = DateTime.now.year

    month = (n_month - 6) <= 0 ? 12 + n_month : n_month
    year  = (n_month - 6) <= 0 ? n_year - 1 : n_year

    DateTime.new(year, month).rfc3339
  end
end