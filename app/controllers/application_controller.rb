class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def useless
    render json: JSON.generate({categories: [{id: 1, name: 'streams'}, {id: 2, name: 'levents'}, {id: 3, name: 'uevents'}]  }), status: 200
  end

  def tl_html
    Nokogiri::HTML(open('https://www.teamliquid.net/'))
  end

  def clean_tl_link(link)
    link.gsub('\\', '').gsub(/^"|"$/, '')
  end

  def games
    @games ||= %w(other sc2 scbw csgo hots ssb ow)
  end

  def game_full_names
    # not sure for HotS/SSB/OW
    @game_full_names ||= ["Other Games", "StarCraft 2", "StarCraft: Brood War", "Counter-Strike: Global Offensive", "Heroes of the Storm", "Super Smash Bros", "OverWatch"]
  end

end
