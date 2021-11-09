require './lib/event'
require './lib/person'
require './lib/craft'
require 'pry'

RSpec.describe Event do
  before :each do
    @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
    @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
    @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    @event = Event.new("Carla's Craft Connection", [@sewing, @knitting], [@hector, @toni])
  end

  it 'exists' do
    expect(@event).to be_an_instance_of(Event)
  end

  it 'has attributes' do
    expect(@event.name).to eq("Carla's Craft Connection")
    expect(@event.crafts).to eq([@sewing, @knitting])
    expect(@event.attendees).to eq([@hector, @toni])
  end

  it 'can list attendee names' do
    expect(@event.attendee_names).to eq(["Hector", "Toni"])
  end

  it 'can return the craft with the most supplies' do
    expect(@event.craft_with_most_supplies).to eq('sewing')
  end

  it 'can return the supply list' do
    expect(@event.supply_list).to eq(["fabric", "scissors", "thread", "sewing_needles", "yarn", "knitting_needles"])
  end
end
