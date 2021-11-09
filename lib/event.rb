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

  def attendees_by_craft_interest
    niche = {}
    @crafts.each do |craft|
      niche[craft.name] = []
      @attendees.each do |person|
        if person.interests.include?(craft.name)
          interested_people = niche[craft.name]
          interested_people << person
        end
      end
    end
    niche
  end

  def crafts_that_use(supply)
    @crafts.find_all do |craft|
      craft.supplies_required.include?(supply.to_sym)
    end
  end

  def assign_attendees_to_crafts
    return_value = {}
    @crafts.each do |craft|
      return_value[craft] = []
    end
    @attendees.each do |person|
      assigned_craft = possible_crafts(person).sample
      return_value[assigned_craft] << person
    end
    return_value
  end

  def possible_crafts(person)
    @crafts.find_all do |craft|
      person.can_build?(craft) && person.interests.include?(craft.name)
    end
  end
end
