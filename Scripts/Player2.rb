=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Player2 class: Creates second player and movement procedures.

=end

class Player2

attr_accessor :x,:y,:vel_x,:vel_y,:index,:ammo,:weapon_level

	def initialize(window)
		@graphic = "Graphics/Sprites/Player2.png"
		@sprite = Image::load_tiles(window, @graphic, 34, 38, false) 
		@x = 0.0
		@y = 0.0
		@vel_x = 0.0
		@vel_y = 0.0
		@index = index
		@ammo = 100
		@weapon_level = 1
	end
  
	# Movement commands
	def move_left
		@vel_x -= 4.5
		@index = 0
	end
	
	def move_right
		@vel_x += 4.5
		@index = 2
	end
	
	def move_up
		@vel_y -= 4.5
	end
	
	def move_down
		@vel_y += 4.5
	end
	
	def move
		self.x += @vel_x 
		self.y += @vel_y
		@vel_x *= 0.50
		@vel_y *= 0.50
	end
	
	# Limit movement to window size
	def x=(v)
		@x = [[590,v].min,0].max
	end
	def y=(v)
		@y = [[430,v].min,0].max
	end
	
	def draw
		@sprite[@index].draw(@x, @y, ZOrder::Player)
	end
	
end
	