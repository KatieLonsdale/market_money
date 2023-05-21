class StateSerializer
  def initialize(state)
    @state = state
  end

  def self.popular_states(states)
    {data: 
    states.each do |state|
      {state: state.state, number_of_vendors: state.number_of_vendors}
    end
    }
  end
end