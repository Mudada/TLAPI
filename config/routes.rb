Rails.application.routes.draw do

  get '/' => 'application#useless'

  scope '/streams' do
    get '/' => 'streams#show'
  end

  scope '/uevents' do
    get '/' => 'uevents#show'
    get '/:id' => 'uevents#get_info'
  end

  scope '/levents' do
    get '/' => 'events#show'
    get '/:id' => 'events#get_info'
  end
end
