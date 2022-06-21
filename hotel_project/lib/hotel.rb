require_relative "room"

class Hotel
    attr_reader :rooms
 def initialize(name, capacities)
    @name = name
    @rooms = {}
    capacities.each do |k,v|
        @rooms[k] = Room.new(v)
    end
 end

 def name
   @name.split.map {|part| part.capitalize}.join(" ")
 end

 def room_exists?(room_name)
    @rooms.has_key?(room_name)
 end

 def check_in(person, room_name)
    if !self.room_exists?(room_name)
        puts "sorry, room does not exist"
    else
        added = @rooms[room_name].add_occupant(person)
    end

    if added
        puts "check in successful"
    else
        puts "sorry, room is full"
    end
 end

 def has_vacancy?
    room_names = @rooms.keys.select{|room_name| room_exists?(room_name)}
    room_names.any?{|room_name| !@rooms[room_name].full?}
 end

 def list_rooms
    room_names = @rooms.keys.select{|room_name| room_exists?(room_name)}
    room_names.each do |room_name|
        room = @rooms[room_name]
        puts room_name + " " + room.available_space.to_s
    end

 end


end
