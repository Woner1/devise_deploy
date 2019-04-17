class Unauthorized < StandardError
  def http_status
    :forbidden
  end
  def code
    'no_authorized'
  end

  def message
    'no authorized'
  end

  def to_hash
    {
        message: message,
        code: code
    }
  end
end