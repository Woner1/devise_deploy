class AuthenticationFailed < StandardError

  def http_status
    :unauthorized
  end

  def code
    'not_authenticated'
  end

  def message
    'Not authenticated'
  end

  def to_hash
    {
        message: message,
        code: code
    }
  end


end