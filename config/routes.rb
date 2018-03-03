Rails.application.routes.draw do
  # Public
  root to: 'pages#show'
  get '/home', to: redirect('/')

  mount Forest::Engine, at: '/'
end
