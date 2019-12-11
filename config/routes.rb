require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Api::Base => '/api'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'admin'
  end
  mount Sidekiq::Web => '/sidekiq'

  match '*path', to: 'pages#index', via: :all
end
