=begin 
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Bullet class: Creates primary player weapon.

=end

class Bullet

attr_accessor :x,:y

	#================================================================================================
	# initialize Method definition: Creating object
	#================================================================================================

	def initialize(window, x, y)
		@sprite = Image.new(window, "Graphics/Sprites/Shot.png", false)
		@x = x
		@y = y
	end
	
	#================================================================================================
	# update Method definition: Every frame bullet moves by a factor of 5
	#================================================================================================
	
	def update
		@y -= 5
	end
	
	#================================================================================================
	# collide Method definition: Method that check whether enemy was hit by a bullet
	#================================================================================================
  
	def collide(enemy,bullet)
		if collideE(enemy)
			bullet.delete(self)
		end
	end

	def collideE(enemy)
	enemy.each{|e|
		@dist = distance(@x, @y, e.x + 11, e.y + 11)
		if @dist < 22 then       
			e.armor -= 5
			@a = true
			if e.armor <= 0
				enemy.delete(e)
				$enemy_killed = true
				$score += 100
				$score2 += 100
			end
				return true
					
			end
		}
		return false
	end
  
	#================================================================================================
	# draw Method definition: Creating a bullet graphic
	#================================================================================================
	
	def draw
		@sprite.draw(@x,@y, ZOrder::Bullet)
	end
  
end