########################################################
# Step 0: Understand the data we need to organize

# 1. What things (objects, nouns) are represented or described in this file? We can think of at least six different things.
    # • Driver id
    # • Date
    #      • Day
    #      • Month
    #      • Year
    # • Cost of ride
    # • Rider id
    # • Rating
    # • Ride

# 2. From the things you listed in the previous question, all of those things have relationships to each other. (an ID belongs to a person, for instance. As an abstract, unrelated example a VIN belongs to a vehicle, and a vehicle has a VIN.) Consider the relationships between the pieces of data.
    # Each row of data is representative of an individual ride
    # Driver id belongs to a person
    # Date belongs to the ride
    # Cost belongs to the ride
    # Rider id belongs to the driver
    # Rating belongs to the ride?  This is unclear and not specified

# 3. Lastly, in this assignment, we will rearrange all of the data into one data structure (with a lot of nested layers), that can be held in one variable. List some ideas: considering all of the relationships listed in the last question, what piece of data can contain the others at the top-most level? (Compared to the json example before, think about what the top-most layer of the hash and what that represented.) There is more than one correct answer, so just list out the options at this moment.
    # An array should store all of the data.  The array should contain hashes for each ride (row of data)
    # An array of hashes by driver.  Each driver hash contains an array of rides. The ride array is an array of hashes that contains all of the data pertaining to that ride

########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
    # drivers
    # rides
    # ride_data (date, cost, rider_id, rating)

# Which layers are nested in each other?
    # drivers > rides > ride_data  (date, cost, rider_id, rating)

# Which layers of data "have" within it a different layer?
    # drivers, and rides, and ride_data all have an additional data structure within them
      # drivers has rides, which is an array
      # ride has ride data, which is a hash
      # rides has data with the structure of key => value

# Which layers are "next" to each other?
    # The data within ride_data has data next to one another -  date, cost, rider_id, rating are all next to one another in the same hash
    # The drivers are next to one another within a hash
    # The rides are next to one another within an array

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have
    # drivers [hash] > rides [array] > ride_data [hash]

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

drivers =
{
  DR0001:
  [
      {
        date: "3rd Feb 2016",
        cost: 30,
        rider_id: "RD0015",
        rating: 4
      },

      {
        date: "3rd Feb 2016",
        cost: 10,
        rider_id: "RD0003",
        rating: 3
      },

      {
        date: "5th Feb 2016",
        cost: 45,
        rider_id: "RD0003",
        rating: 2
      },
  ],

  DR0002:
  [
    {
      date: "3rd Feb 2016",
      cost: 25,
      rider_id: "RD0073",
      rating: 5
    },

    {
      date: "4th Feb 2016",
      cost: 15,
      rider_id: "RD0013",
      rating: 1
    },

    {
      date: "5th Feb 2016",
      cost: 35,
      rider_id: "RD0066",
      rating: 3
    },

  ],

  DR0003:
  [
    {
      date: "4th Feb 2016",
      cost: 5,
      rider_id: "RD0066",
      rating: 5
    },

    {
      date: "5th Feb 2016",
      cost: 50,
      rider_id: "RD0003",
      rating: 2
    },

  ],

  DR0004:
  [
    {
      date: "3rd Feb 2016",
      cost: 5,
      rider_id: "RD0022",
      rating: 5
    },

    {
      date: "4th Feb 2016",
      cost: 10,
      rider_id: "RD0022",
      rating: 4
    },

    {
      date: "5th Feb 2016",
      cost: 20,
      rider_id: "RD0073",
      rating: 5
    },

  ],

}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:

# 1
puts "Number of rides each driver has given: "
drivers.each do |key, value|
  puts "   #{key} has given #{value.length} rides"
end

puts

# 2
puts "Total amount of money each driver has made: "
driver_money = {}

drivers.each do |key, value|
  total = 0
  value.each_with_index do |(driver), index|
    cost = value[index][:cost]
    total += cost
  end
  puts "   Total made for #{key} is #{total}"
  driver_money[key] = total
end

puts

# 3
puts "The average rating of each driver: "
driver_ratings = {}

drivers.each do |key, value|
  id = key
  total_rating = 0
  count = 0.0
  value.each_with_index do |(driver), index|
    rating = value[index][:rating]
    total_rating += rating
    count += 1
  end
  puts "   Average rating for #{key} is #{(total_rating/count).round(1)}"
  driver_ratings[id] = (total_rating/count).round(1)
end

puts

# 4
puts "Which driver made the most money? "
puts "   #{driver_money.key(driver_money.values.max)} made the most money, they made $#{driver_money.values.max}."

puts

# 5
puts "Which driver has the highest average rating?"
puts  "   #{driver_ratings.key(driver_ratings.values.max)} had the highest rating, their rating is #{driver_ratings.values.max}."

puts

# Optional
puts "For each driver, on which day did they make the most money?"

by_day = {}
drivers.each do |key, value|
  id = key
  key = {}
  value.each do |driver|
    if key.has_key?(driver[:date]) == true
      current = key[driver[:date]]
      if driver[:cost] > current
        key[driver[:date]] = driver[:cost]
      end
    else
      key[driver[:date]] = driver[:cost]
    end
  end
  by_day[id.to_sym] = key
end

by_day.each do |key, value|
  money = value.values
  date = value.keys
  max_date = money.each_with_index.max[1]

  puts "   #{key} made the most on #{date[max_date]}, they made #{money.max}."
  end
