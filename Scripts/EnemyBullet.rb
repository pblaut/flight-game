=begin 
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	EnemyBullet class: Creates primary enemy weapon.

=end

class EnemyBullet

attr_accessor :x,:y

	#================================================================================================
	# initialize Method definition: Creating object
	#================================================================================================

	def initialize(window, x, y)
		@sprite = Image.new(window, "Graphics/Sprites/EShot.png", false)
		@x = x
		@y = y
	end
	
	#================================================================================================
	# update Method definition: Every frame bullet moves by a factor of 5
	#================================================================================================
	
	def update
		@y += 5
	end
	
	#================================================================================================
	# collide Method definition: Method that check whether enemy was hit by a bullet
	#================================================================================================
  
	def collide(px,py,ebullet)
		ebullet.reject! do |ebullet|
			@edist = distance(ebullet.x, ebullet.y, px + 17, py)
			if @edist < 22 then       
				$p1_armor -= 2
			end
		end
	end
  
	def collide2(px,py,ebullet)
		ebullet.reject! do |ebullet|
			@edist = distance(ebullet.x, ebullet.y, px + 17, py)
			if @edist < 22 then       
				$p2_armor -= 2
			end
		end
	end
	
	#================================================================================================
	# draw Method definition: Creating a bullet graphic
	#================================================================================================
	
	def draw
		@sprite.draw(@x,@y, ZOrder::Bullet)
	end
  
end