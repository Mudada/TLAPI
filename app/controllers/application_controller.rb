class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def useless
    render json: JSON.generate({categories: [{id: 1, name: 'streams'}, {id: 2, name: 'levents'}, {id: 3, name: 'uevents'}]  }), status: 200
  end

  def tl_html
    Nokogiri::HTML(open('http://www.teamliquid.net/'))
  end

  def clean_tl_link(link)
    link.gsub('\\', '').gsub(/^"|"$/, '')
  end

  def games
    @games ||= %w(??? sc2 scbw csgo hots ssb ow)
  end

end
