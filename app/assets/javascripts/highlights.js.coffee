$ ->
  videos = []
  $('div.player').each ->
    videos.push $(this).attr('id')

  params = { allowScriptAccess: "always" }
  for id in videos
    swfobject.embedSWF("http://www.youtube.com/v/#{id}?enablejsapi=1&playerapiid=ytplayer&version=3", id, "425", "356", "8", null, null, params, id)
