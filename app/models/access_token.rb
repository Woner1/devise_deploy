class AccessToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  has_secure_token :refresh_token

  def expires_at
    created_at + expires_in.seconds
  end

  def expired?
    Time.now.utc > expires_at
  end

  def as_json(options = {})
    super(options.merge(only: %i[token refresh_token expires_in]))
  end

end
