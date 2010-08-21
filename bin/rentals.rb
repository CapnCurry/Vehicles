#All vehicles ordered by fuel efficiency
#All vehicles ordered by the distance they can be driven with their
#current amount of gas (Zombie Invasion mode)
#The amount of gas I need to purchase to refuel my entire fleet
#Summary of how many of each Make
#Summary of how many of each Model
#Summary of how many of each Color
require 'csv'
require 'lib/vehicle'
require 'rubygems'
require 'highline/import'


def fill_inventory inventory
  #Pull all cars from data file
  CSV.foreach("./data/cars.csv", {:headers => true}) do |row|
    inventory << Car.new(row['Color'], row['Make'], row['Model'], row['Gas Current'], row['Gas Capacity'], row['Gas Mileage'])
  end
  
  #Pull all trucks from data file
  CSV.foreach("./data/trucks.csv", {:headers => true}) do |row|
    inventory << Truck.new(row['Color'], row['Make'], row['Model'], row['Gas Current'], row['Gas Capacity'], row['Gas Mileage'])     
    
  end
end


def fuel_efficiency_report inventory
  report_results = " "
  inventory.sort!{|a,b| b.mileage <=> a.mileage}
  inventory.each do |vehicle|
    report_results << "#{vehicle.mileage} MPG on a #{vehicle.make} #{vehicle.model}\n "
  end
  return report_results
end

def refueling_report inventory
  gas_required = 0
  inventory.each do |vehicle|
    gas_required += vehicle.gas_capacity - vehicle.gas_current
  end
  
  return "#{gas_required} gallons of fuel are required to replenish the fleet."

end

def make_model_report inventory
  modelcounter={}
  inventory.sort!{|a,b| (a.model <=> b.model)}
  inventory.each do |vehicle|
    make_and_model = vehicle.make + " " + vehicle.model
    if modelcounter[make_and_model]
      modelcounter[make_and_model] += 1
    else
      modelcounter[make_and_model] = 1 
    end
  end
  report_results = "Inventory contains "
  modelcounter.each {|key, value| report_results << "#{value} #{key}(s), " }
  return report_results.chop.chop. << "."

end

def color_report inventory
  colorcounter={}
  inventory.sort!{|a,b| (a.color <=> b.color)}
  inventory.each do |vehicle|
    if colorcounter[vehicle.color]
      colorcounter[vehicle.color] += 1
    else
      colorcounter[vehicle.color] = 1 
    end
  end
  report_results = "Inventory contains "
  colorcounter.each {|key, value| report_results << "#{value} #{key} car(s), " }
  return report_results.chop.chop. << "."

end

def zombie_report inventory
  report_results=""
  inventory.sort!{|a,b| (b.mileage * b.gas_current) <=> (a.mileage * a.gas_current)}
  inventory.each do |vehicle|
    range = vehicle.mileage * vehicle.gas_current
    report_results << "#{range} miles of range on a #{vehicle.make} #{vehicle.model}\n"
  end
return report_results
end

highline=HighLine.new

ft = HighLine::ColorScheme.new do |cs|
        cs[:headline]        = [ :bold, :yellow, :on_black ]
        cs[:horizontal_line] = [ :bold, :white, :on_blue]
        cs[:even_row]        = [ :red ]
        cs[:odd_row]         = [ :red ]
     end


HighLine.color_scheme = ft




inventory = []
fill_inventory inventory

done=false
until done == true do
  choose do |menu|
    menu.header = highline.color('Inventory management menu', :headline)
    menu.prompt = "Selection?"
    menu.choice('Color Report') { puts color_report inventory }
    menu.choice('Make / Model Report') { puts make_model_report inventory }
    menu.choice('Refuel Report') { puts refueling_report inventory }
    menu.choice('Efficiency Report') { puts fuel_efficiency_report inventory }
    menu.choice('Zombie Alert') { puts zombie_report inventory }
    menu.choice('Exit') { done = true }
  end
end


#inventory.each do |vehicle|
#  p vehicle
#end


#loop do 
#  puts "Menu:\n\n"
#  puts '1. Fuel-efficiency report'
#  puts '2. Refueling report'
#  puts '3. Make / Model report'
#  puts '4. Color report'
#  puts 'Z. Zombie Invasion Mode'
#  puts "\n"
#  puts 'X to Quit'
#  selection = gets
#  case selection[0].upcase
#  when '1' then puts fuel_efficiency_report inventory
#  when '2' then puts refueling_report inventory
#  when '3' then puts make_model_report inventory
#  when '4' then puts color_report inventory
#  when 'Z' then puts zombie_report inventory
#  when 'X' then break
#  end
#end


