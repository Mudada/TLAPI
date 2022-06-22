class EventsController < ApplicationController

  def details
    post = {action: 'view-event-popup', event_id: params[:id]}
    q = Net::HTTP.post_form(URI.parse('http://www.tl.net/calendar/manage'), post)
    json = JSON.parse(q.body)
    html = Nokogiri::HTML(json["html"])
    lp = html.css('a[href*="liquipedia"]')
    render json: {
      id: params[:id],
      lp: lp.length ? clean_tl_link(lp.first['href']) : '',
      subtext: html.css('h2').first.content
    }
  end

  def index
    lives = tl_html.css('div.ev-live')
    levents = lives.map{|id|
      get_info(id)
    }
    render json: JSON.generate(levents: levents), status: 200
  end

private
  def get_info(elem)
    span = elem.css('span[data-event-id]').first
    id = span['data-event-id']
    title = span.content
    a = elem.css('div.ev-stream').first.css('a').first
    game = games[/\d+(?=\.png)/.match(elem.css('span.ev').first.attribute('style'))[0].to_i]
    if a
      stream = 'http://www.teamliquid.net/' + a.attribute('href')
    end

    return {id: id, name: title, game: game, url: stream}
  end

end
