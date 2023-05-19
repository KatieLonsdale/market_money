class ErrorSerializer
  def self.error_message(message)
    {"errors": [{ detail: message }]}
  end
end