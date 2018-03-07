class UeventsController < ApplicationController

  def index
    lives = tl_html.css('div.ev-upc')
    uevents = lives.map{|id|
      get_info(id)
    }
    render json: JSON.generate({uevents: uevents}), status: 200
  end

private
def get_info(elem)
    span = elem.css('span[data-event-id]').first
    id = span['data-event-id']
    title = span.content
    timer = elem.css('span.ev-timer').first.content
    date = elem.css('span.ev-timer').first.attribute('title')
    game = %w(??? sc2 scbw csgo hots ssb)[/\d(?=\.png)/.match(elem.css('span.ev').first.attribute('style'))[0].to_i]
    return {id: id, name: title, date:  date, timer: timer, game: game}
  end

end
