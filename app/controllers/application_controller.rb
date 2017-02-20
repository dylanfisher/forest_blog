# TODO: inherit from Forest::ApplicationController automatically
class ApplicationController < Forest::ApplicationController
  protect_from_forgery with: :exception
end
