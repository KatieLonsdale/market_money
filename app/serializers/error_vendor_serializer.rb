class ErrorVendorSerializer
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

  def create_failed
    {
      errors: [
        {detail: "Validation failed: #{format_message}"}
      ]
    }
  end

  def format_message
    @error_object.error_message.join(', ')
  end
end
