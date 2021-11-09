class Event
  attr_reader :name, :crafts, :attendees

  def initialize(name, crafts, attendees)
    @name = name
    @crafts = crafts
    @attendees = attendees
  end

  def attendee_names
    @attendees.map do |person|
      person.name
    end
  end

  def craft_with_most_supplies
    craft = @crafts.max_by do |craft|
      craft.num_supplies
    end
    craft.name
  end

  def supply_list
    supplies = @crafts.map do |craft|
      craft.supplies_required.keys
    end
    supplies.flatten.uniq.map do |supply|
      supply.to_s
    end
  end
end
