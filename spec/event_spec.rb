require './lib/event'
require './lib/person'
require './lib/craft'
require 'pry'

RSpec.describe Event do
  before :each do
    @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
    @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    @tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting']})
    @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
    @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    @painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
    @event = Event.new("Carla's Craft Connection", [@sewing, @knitting, @painting], [@hector, @toni, @tony])
  end

  it 'exists' do
    expect(@event).to be_an_instance_of(Event)
  end

  it 'has attributes' do
    expect(@event.name).to eq("Carla's Craft Connection")
    expect(@event.crafts).to eq([@sewing, @knitting, @painting])
    expect(@event.attendees).to eq([@hector, @toni, @tony])
  end

  it 'can list attendee names' do
    expect(@event.attendee_names).to eq(["Hector", "Toni", "Tony"])
  end

  it 'can return the craft with the most supplies' do
    expect(@event.craft_with_most_supplies).to eq('sewing')
  end

  it 'can return the supply list' do
    expect(@event.supply_list).to eq(["fabric", "scissors", "thread", "sewing_needles", "yarn", "knitting_needles", "canvas", "paint_brush", "paints"])
  end

  it 'can return attendees by craft interest' do
    expected = {
      "knitting" => [@toni, @tony],
      "painting" => [],
      "sewing" => [@hector, @toni]
    }
    expect(@event.attendees_by_craft_interest).to eq(expected)
  end

  it 'can return crafts that use a certain supply' do
    expect(@event.crafts_that_use('scissors')).to eq([@sewing, @knitting])
    expect(@event.crafts_that_use('fire')).to eq([])
  end

  it 'can randomly assign attendees to events that they can build and are interested in' do
    hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
    toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})
    knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
    toni.add_supply('yarn', 30)
    toni.add_supply('scissors', 2)
    toni.add_supply('knitting_needles', 5)
    toni.add_supply('fabric', 10)
    toni.add_supply('scissors', 1)
    toni.add_supply('thread', 2)
    toni.add_supply('paint_brush', 10)
    toni.add_supply('paints', 20)
    tony.add_supply('yarn', 20)
    tony.add_supply('scissors', 2)
    tony.add_supply('knitting_needles', 2)
    hector.add_supply('fabric', 5)
    hector.add_supply('scissors', 1)
    hector.add_supply('thread', 1)
    hector.add_supply('canvas', 5)
    hector.add_supply('paint_brush', 10)
    hector.add_supply('paints', 20)
    event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])
    #hector can build painting and sewing
    #toni can build knitting and sewing
    #tony can build knitting
    assigned_attendees = event.assign_attendees_to_crafts
    expect(assigned_attendees[knitting]).to be_an(Array)
    expect(assigned_attendees[sewing]).to be_an(Array)
    expect(assigned_attendees[painting]).to be_an(Array)
    expect(assigned_attendees.count).to eq(3)
    expect(assigned_attendees[knitting]).to include(tony)
  end

  it 'makes sure that the person is interested the craft' do
    hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
    toni = Person.new({name: 'Toni', interests: ['sewing']})
    tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})
    knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
    toni.add_supply('yarn', 30)
    toni.add_supply('scissors', 2)
    toni.add_supply('knitting_needles', 5)
    toni.add_supply('fabric', 10)
    toni.add_supply('scissors', 1)
    toni.add_supply('thread', 2)
    toni.add_supply('paint_brush', 10)
    toni.add_supply('paints', 20)
    tony.add_supply('yarn', 20)
    tony.add_supply('scissors', 2)
    tony.add_supply('knitting_needles', 2)
    hector.add_supply('fabric', 5)
    hector.add_supply('scissors', 1)
    hector.add_supply('thread', 1)
    hector.add_supply('canvas', 5)
    hector.add_supply('paint_brush', 10)
    hector.add_supply('paints', 20)
    event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])
    #hector can build painting and sewing
    #toni can build knitting and sewing
    #tony can build knitting
    assigned_attendees = event.assign_attendees_to_crafts
    expect(assigned_attendees[sewing]).to include(toni)
  end

  it 'uses mocks and stubs' do
    hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
    toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})
    knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})
    toni.add_supply('yarn', 30)
    toni.add_supply('scissors', 2)
    toni.add_supply('knitting_needles', 5)
    toni.add_supply('fabric', 10)
    toni.add_supply('scissors', 1)
    toni.add_supply('thread', 2)
    toni.add_supply('paint_brush', 10)
    toni.add_supply('paints', 20)
    tony.add_supply('yarn', 20)
    tony.add_supply('scissors', 2)
    tony.add_supply('knitting_needles', 2)
    hector.add_supply('fabric', 5)
    hector.add_supply('scissors', 1)
    hector.add_supply('thread', 1)
    hector.add_supply('canvas', 5)
    hector.add_supply('paint_brush', 10)
    hector.add_supply('paints', 20)
    event = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])
    #hector can build painting and sewing
    #toni can build knitting and sewing
    #tony can build knitting
    allow(event).to receive(:possible_crafts).with("bob").and_return([painting])
    allow(event).to receive(:possible_crafts).with(toni).and_return([sewing])
    allow(event).to receive(:possible_crafts).with(tony).and_return([knitting])
    assigned_attendees = event.assign_attendees_to_crafts
    expected = {
        sewing => [toni],
        painting => ["bob"],
        knitting => [tony]
    }
    expect(assigned_attendees).to eq(expected)
  end
end
