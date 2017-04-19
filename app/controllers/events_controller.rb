class EventsController < ApplicationController

  @@document = Nokogiri::HTML(open('http://www.teamliquid.net/'))

  def show
    lives = @@document.css('div.ev-live')
    ids = lives.css('span[data-event-id]').collect{|a| a.attribute('data-event-id')}
    render json: JSON.generate(ids: ids)
  end

  def get_info
    ups = @@document.css('div.ev-live')
    uevent = ups.select{|upc|
      upc.css('span[data-event-id]').first.attribute('data-event-id').to_s == params['id']
    }
    title = uevent.first.css('span[data-event-id]').first.content
    stream = 'http://www.teamliquid.net/' + uevent.first.css('div.ev-stream').first.css('a').first.attribute('href')
    game = %w(??? sc2 scbw csgo hots ssb)[/\d(?=\.png)/.match(uevent.first.css('span.ev').first.attribute('style'))[0].to_i]

    render json: JSON.generate({uevent: {name: title, game: game, stream: stream}})
  end

end
