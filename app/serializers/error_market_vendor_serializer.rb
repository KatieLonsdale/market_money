class ErrorMarketVendorSerializer
  def initialize(error_object)
    @error_object = error_object
  end
  
  def message
    {
      errors: [
        {detail: "Validation failed: #{format_message(@error_object)}"}
      ]
    }
  end

  def format_message(error_object)
    error_object.errors.full_messages.join(', ')
  end
end