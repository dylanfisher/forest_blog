Rails.application.routes.draw do
  scope :admin do
    resources :artists
    resources :artworks
    resources :exhibitions
  end

  # TODO: polymorphic path for versions to live in engine?
  get 'exhibitions/:id/versions', to: 'exhibitions#versions', as: 'exhibition_versions'
  get 'exhibitions/:id/versions/:version_id', to: 'exhibitions#version', as: 'exhibition_version'
  get 'exhibitions/:id/versions/:version_id/restore', to: 'exhibitions#restore', as: 'restore_exhibition_version'

  # Show
  get 'artists/:id', to: 'artists#show', as: 'show_artist'
  get 'artworks/:id', to: 'artworks#show', as: 'show_artwork'
  get 'exhibitions/:id', to: 'exhibitions#show', as: 'show_exhibition'

  mount Forest::Engine, at: '/'
end
