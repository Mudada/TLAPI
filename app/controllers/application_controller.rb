class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def useless
    render json: JSON.generate({categories: [{id: 1, name: 'streams'}, {id: 2, name: 'events'}]})
  end
end
