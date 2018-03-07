Rails.application.routes.draw do

  get '/' => 'application#useless'
  get '/streams' => 'streams#show'
  get '/uevents' => 'uevents#index'
  get '/levents' => 'events#index'
  get '/event/:id' => 'events#details'
end
