class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    # skip_forgery_protection # this also works, is just a wrapper for literally the command above as per
    # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html#method-i-skip_forgery_protection
end
