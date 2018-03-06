class UeventsController < ApplicationController

  def document
    Nokogiri::HTML(open('http://www.teamliquid.net/'))
  end

  def show
    lives = document.css('div.ev-upc')
    ids = lives.css('span[data-event-id]').collect{|a| a.attribute('data-event-id')}
    uevents = ids.collect{|id|
      get_info(id)
    }
    render json: JSON.generate({uevents: uevents}), status: 200
  end

  private

  def get_info(id)
    ups = document.css('div.ev-upc')
    uevent = ups.select{|upc|
      upc.css('span[data-event-id]').first.attribute('data-event-id') == id
    }
    if uevent
      title = uevent.first.css('span[data-event-id]').first.content
      timer = uevent.first.css('span.ev-timer').first.content
      date = uevent.first.css('span.ev-timer').first.attribute('title')
      game = %w(??? sc2 scbw csgo hots ssb)[/\d(?=\.png)/.match(uevent.first.css('span.ev').first.attribute('style'))[0].to_i]
    end

    return {id: id, name: title, date:  date, timer: timer, game: game}
  end

end
