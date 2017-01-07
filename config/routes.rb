Rails.application.routes.draw do
  mount Forest::Engine, at: '/admin'
end
