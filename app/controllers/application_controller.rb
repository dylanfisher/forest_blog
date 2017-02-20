# TODO: inherit from Forest::ApplicationController automatically
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
