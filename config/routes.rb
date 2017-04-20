Rails.application.routes.draw do

  get '/' => 'application#useless'

  scope '/streams' do
    get '/' => 'streams#show'
  end

  scope '/uevents' do
    get '/' => 'uevents#show'
  end

  scope '/levents' do
    get '/' => 'events#show'
  end
end
