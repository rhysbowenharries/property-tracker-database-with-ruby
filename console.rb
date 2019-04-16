require('pry-byebug')
require_relative('models/property_tracker.rb')

PropertyTracker.delete_all()

property1 = PropertyTracker.new('address'=>'Park Lane','value'=>'450','number_of_bedrooms'=>'5', 'year_built'=>'1912')
property2 = PropertyTracker.new('address'=>'Old Kent Rd','value'=>'50','number_of_bedrooms'=>'4', 'year_built'=>'1242')
property3 = PropertyTracker.new('address'=>'Mayfaire','value'=>'500','number_of_bedrooms'=>'3', 'year_built'=>'2008')
property4 = PropertyTracker.new('address'=>'Whitehall','value'=>'60','number_of_bedrooms'=>'2', 'year_built'=>'1998')

property1.save()
property2.save()
property3.save()
property4.save()

property4.value = 166
property4.update()
property2.value = 180
property2.update()

# p PropertyTracker.find(53)

p PropertyTracker.find_by_address('dog')
