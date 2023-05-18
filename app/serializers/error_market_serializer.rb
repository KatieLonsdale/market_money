class ErrorMarketSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def message
    {
      errors: [
        {detail: @error_object.error_message}
      ]
    }
  end

  def format_message
    @error_object.error_message.join(', ')
  end
end
