class ErrorMarketSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def not_found
    {
      errors: [
        {detail: @error_object.error_message}
      ]
    }
  end
end
