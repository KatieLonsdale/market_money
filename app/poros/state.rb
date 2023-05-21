class State
  attr_reader :state, :number_of_vendors

  def initialize(name, count)
    @state = name
    @number_of_vendors = count
  end
end