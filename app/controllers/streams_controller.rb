require 'open-uri'
require 'json'


class StreamsController < ApplicationController

  @@divs = Nokogiri::HTML(open('http://www.teamliquid.net/')).css('div#streams_content')

  def show
    hash = {featured: [], non_featured: []}
    titles = @@divs.css('b').collect{|b| b.content}.uniq
    divs = @@divs.css('div[style="margin-left:12px"]')

    featured_streams = Hash[titles.zip divs]
    featured_streams.each{|game, stream|
      if !stream.nil?
        urls = stream.css('a').collect{|url| 'http://www.teamliquid.net/' + url.attribute('href').value}
        streamers = stream.css('a').collect{|streamer| streamer.content}
        pair = Hash[streamers.zip urls]
        pair.each{|streamer, url|
          hash[:featured].push({streamer: streamer, game: game, url: url})
        }
      end
    }

    divs = @@divs.css('div#non-featured div[style="margin-left:12px"]')
    non_featured_streams = Hash[titles.zip divs]
    non_featured_streams.each{|game, stream|
      if !stream.nil?
        urls = stream.css('a').collect{|url| 'http://www.teamliquid.net/' + url.attribute('href').value}
        streamers = stream.css('a').collect{|streamer| streamer.content}
        pair = Hash[streamers.zip urls]
        pair.each{|streamer, url|
          hash[:non_featured].push({streamer: streamer, game: game, url: url})
        }
      end
    }

    render json: JSON.generate(hash), status: 200
  end

end
