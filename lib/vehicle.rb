


class Vehicle
   attr_accessor :color, :make, :model

   def initialize(color, make, model)
     @color = color
     @make = make
     @model = model
   end

end


class Automobile < Vehicle
  DEGREES = {'N' => 0, 'E' =>90, 'S' =>180,'W' => 270}
  def initialize(*args)
     @gas_current = 11
     @gas_capacity = 11
     @mileage = 22
     @heading = 0 
     @position = [0,0]
     super(*args)
   end

   def to_s
     "I am a #{@color} #{@make} #{model}. I am at #{@position}. I have #{@gas_current} gallons of fuel remaining."
   end
 
   
   def drive(distance)
        drive_cap = @gas_current * @mileage
     if drive_cap < distance
       return "I did my best! We went #{drive_cap} miles before the tank was emptied."
       @gas_current=0
       iwent(drive_cap)
     else
       @gas_current -= (distance/@mileage.to_f)
       iwent(distance)
       return "You have #{@gas_current} gallons of gas left."
     end
     
   end

   def iwent(distance)
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
     c = DEGREES[direction[0].upcase]
     if c
       @heading = c
     elsif direction[0].upcase == 'R'
       @heading = @heading + 90
       @heading = @heading - 360 if @heading > 359
     elsif direction[0].upcase == 'L'
         @heading = @heading - 90
         @heading = @heading + 360 if @heading <= 0
     else
         return "Wrong way, Goldfarb!"
     end
     
   end

 end #class


 class Car < Automobile
 end

 class Truck < Automobile
 end

