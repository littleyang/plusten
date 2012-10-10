class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!,:message=>"you should login or register first"
end
