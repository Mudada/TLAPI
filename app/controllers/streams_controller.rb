require 'open-uri'
require 'json'


class StreamsController < ApplicationController

  def show
    divs = tl_html.css('div#streams_content')
    titles = divs.css('b').collect{|b| b.content}.uniq

    featured_streams = Hash[titles.zip divs.css('div[style="margin-left:12px"]')]
    non_featured_streams = Hash[titles.zip divs.css('div#non-featured div[style="margin-left:12px"]')]

    # We could return [k, format...], into a Hash[], and merge
    #    but the rest of the code of the bot uses a flat structure,
    #    not a [game => [streams...]] structure
    streams = featured_streams.flat_map{|k,v| format_streams(k, v, true) } \
	    + non_featured_streams.flat_map{|k,v| format_streams(k, v, false) }

    render json: streams, status: 200
  end

private
  def format_streams(game, stream, featured)
      if !stream.nil?
        urls = stream.css('a').collect{|url| 'http://www.teamliquid.net/' + url.attribute('href').value}
        streamers = stream.css('a').collect{|streamer| streamer.content}
	viewers = stream.css('span.viewers').collect &:content
	pair = Hash[streamers.zip urls.zip(viewers)]
        pair.map{|streamer, data|
          url, viewers = data
	  {streamer: streamer, game: game, url: url, viewers: viewers.to_i, featured: featured}
        }
      else
        []
      end
  end

end
