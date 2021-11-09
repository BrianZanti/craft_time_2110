class Person
  attr_reader :name, :interests, :supplies
  def initialize(attributes)
    @name = attributes[:name]
    @interests = attributes[:interests]
    @supplies = Hash.new(0)
  end

  def add_supply(supply, quantity)
    @supplies[supply] += quantity
  end

  def can_build?(craft)
    craft.supplies_required.all? do |supply, quantity|
      @supplies[supply.to_s] >= quantity
    end
  end
end
