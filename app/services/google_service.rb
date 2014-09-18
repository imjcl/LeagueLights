require "google/api_client"
module GoogleService
  def self.authorize
    # Setup private key, since rbenv-vars doesn't work with multiline well
    pk = ENV['GOOGLE_PK'].gsub /\\n/, "\n"
    key = OpenSSL::PKey::RSA.new pk, 'notasecret'
    Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/youtube.readonly',
      issuer: ENV['GOOGLE_PK_CEMAIL'],
      signing_key: key
    )

  end

  def self.get_highlights champion
    client = Google::APIClient.new(application_name: 'LeagueLights', application_version: '0.0.1')
    client.authorization = authorize()
    client.authorization.fetch_access_token!
    youtube = client.discovered_api('youtube', 'v3')
    opts = {}
    opts[:part] = 'id,snippet'
    opts[:q] = "league of legends season 4 #{champion} commentary"
    opts[:maxResults] = 25
    #opts[:publishedAfter] = six_months_ago
    #opts[:order] = 'viewCount'
    unless REDIS.exists "#{champion}-reel"
      videos = []
      result = client.execute(api_method: youtube.search.list, parameters: opts)
      result.data.items.each do |sr|
        case sr.id.kind
          when 'youtube#video'  
            videos.push([sr.snippet.title, sr.id.videoId])
        end
      end
      REDIS.set "#{champion}-reel", videos.to_json
      REDIS.expire "#{champion}-reel", 432000
    end
    videos = JSON.parse REDIS.get "#{champion}-reel"
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