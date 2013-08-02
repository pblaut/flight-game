=begin 
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Enemy class: Creates enemy instances.

=end

class Enemy

attr_accessor :x,:y,:vel_x,:vel_y,:armor
	
	def initialize(window)
		@sprite = Image.new(window, "Graphics/Sprites/Enemy_Fighter.gif", false)
		@hud = Image.new(window, "Graphics/Sprites/EHUD.png",false)
		@x = rand(300)+100
		@y = -60 
		@x_total = 0
		@y_total = 0
		@armor = 25
	end
  
	#================================================================================================
	# move Method definition: Enemy movement patterns
	#================================================================================================
	
	def move
		unless @y >= 0 then
			@y += 1
		end
		if @x_total <= 150 and @y_total <= 150 then
			@x += 1
			@y += 1
			@x_total +=1
			@y_total += 1
		end
		if @x_total > 150 and @y_total > 150 and @x_total < 300 and @y_total < 300 then
			@y -= 1
			@x_total += 1
			@y_total += 1
		end
		if @x_total > 298 and @y_total > 298 and @x_total < 450 and @y_total < 450 then
			@y +=1
			@x -= 1
			@x_total += 1
			@y_total += 1
		end
		if @x_total > 448 and @y_total > 448 and @x_total < 600 and @y_total < 600 then
			@y -= 1
			@x_total += 1
			@y_total += 1
		end
		if @x_total == 599 and @y_total == 599 then
			@x_total = @y_total = 0
		end
	end
    
	#================================================================================================
	# draw Method definition: Creating a bullet graphic
	#================================================================================================
	
	def draw
		@sprite.draw(@x, @y, ZOrder::Enemy)
	end
	
	def hud
		for i in 0..@armor
			hud_const_x = (x - @armor/2) + 11
			@hud.draw(hud_const_x + i, @y-5, ZOrder::Enemy)
		end
	end	
	
end