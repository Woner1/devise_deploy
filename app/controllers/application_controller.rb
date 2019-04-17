class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :access_control
  before_action :authenticate_user!


  def access_control
    # if Rails.env.development?
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, PATCH, DELETE'
    # end
  end

  def current_user
    @current_user
  end

  def current_user?(user)
    user == current_user
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    unauthenticated! if token.blank?
    if token
      if token.expired?
        expired_token!
      else
        @current_user = token.user
      end
    else
      unauthenticated!
    end
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    raise AuthenticationFailed
  end

  def expired_token!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    raise TokenExpired
  end

  def unauthorized!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    raise Unauthorized
  end

end
