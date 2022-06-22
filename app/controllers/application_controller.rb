require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def useless
    render json: JSON.generate({categories: [{id: 1, name: 'streams'}, {id: 2, name: 'levents'}, {id: 3, name: 'uevents'}]  }), status: 200
  end

  def tl_html
    Nokogiri::HTML(open('https://tl.net/'))
  end

  def clean_tl_link(link)
    link.gsub('\\', '').gsub(/^"|"$/, '')
  end

  def games
    @games ||= %w(other sc2 scbw csgo hots ssb ow ? dota2 LoL)
  end

  def game_full_names
    # not sure for HotS/SSB/OW
    @game_full_names ||= ["Other Games", "StarCraft 2", "StarCraft: Brood War", "Counter-Strike: Global Offensive", "Heroes of the Storm", "Super Smash Bros", "Overwatch", "(unknown)", "Dota 2", "League of Legends"]
  end

end
