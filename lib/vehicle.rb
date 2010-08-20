class Vehicle
  attr_accessor :color, :make, :model
  
  def initialize(color, make, model)
    @color = color
    @make = make
    @model = model
  end
  
end


class Automobile < Vehicle
  
  DEGREES = {'N' => 0, 'E' => 90, 'S' => 180,'W' => 270}
  TURNS = {'R' => 90, 'L' => -90}
  
  def initialize(*args)
    @gas_current = 11
    @gas_capacity = 11
    @mileage = 22
    @heading = 0 
    @position = [0, 0]
    super(*args)
  end

  def to_s
    "I am a #{@color} #{@make} #{model}. I am at #{@position}. I have #{@gas_current} gallons of fuel remaining."
  end
  
  def drive(distance)
    drive_cap = @gas_current * @mileage
    if drive_cap < distance
      @gas_current=0
      update_position(drive_cap)
      "I did my best! We went #{drive_cap} miles before the tank was emptied."
    else
      @gas_current -= distance/@mileage.to_f
      update_position(distance)
      "You have #{@gas_current} gallons of gas left."
    end
  end

  def update_position(distance)
    case @heading
    when 0
      @position[1] += distance
    when 90
      @position[0] += distance
    when 180
      @position[1] -= distance
    when 270
      @position[0] -= distance
    end
  end
  
  def set_heading(direction)
    if degree?(direction)
      @heading = DEGREES[direction[0].upcase]
    elsif turn?(direction)
      turn(direction)
    else
      raise "Wrong way, Goldfarb!"
    end
  end

  def degree?(direction)
    DEGREES[direction[0].upcase]
  end

  def turn?(direction)
    TURNS[direction[0].upcase]
  end

  def turn(direction)
    @heading += TURNS[direction[0].upcase]
    normalize_heading!
  end

  def normalize_heading!
    if @heading > 359
      @heading = @heading - 360
    elsif @heading <= 0
      @heading = @heading + 360
    end
  end

end #class


class Car < Automobile
end

class Truck < Automobile
end

