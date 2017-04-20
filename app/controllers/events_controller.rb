class EventsController < ApplicationController

  @@document = Nokogiri::HTML(open('http://www.teamliquid.net/'))

  def show
    lives = @@document.css('div.ev-live')
    ids = lives.css('span[data-event-id]').collect{|a| a.attribute('data-event-id')}
    levents = ids.collect{|id|
      get_info(id)
    }
    render json: JSON.generate(levents: levents), status: 200
  end

  private

  def get_info(id)
    ups = @@document.css('div.ev-live')
    levent = ups.select{|upc|
      upc.css('span[data-event-id]').first.attribute('data-event-id') == id
    }
    if levent
      title = levent.first.css('span[data-event-id]').first.content
      a = levent.first.css('div.ev-stream').first.css('a').first
      game = %w(??? sc2 scbw csgo hots ssb)[/\d(?=\.png)/.match(levent.first.css('span.ev').first.attribute('style'))[0].to_i]
      if a
        stream = 'http://www.teamliquid.net/' + a.attribute('href')
      end
    end

    return {id: id, name: title, game: game, url: stream}
  end

end
