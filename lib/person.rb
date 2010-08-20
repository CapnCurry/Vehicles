class Person
  attr_accessor :name
  attr_reader :vehicles
  def initialize(name)
    @name = name
    @vehicles = []
  end

  def add_vehicle(vehicle)
    @vehicles << vehicle
  end

end
