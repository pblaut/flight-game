=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Powerup class: Creates Powerups that can be collected by the players.

=end

class Powerup 
	
	attr_accessor :x, :y
		
	def initialize(window, kind, x, y)
		@kind = kind
		@sprite = "Graphics/Sprites/Powerup_Ammo.gif"
		if @kind == 0 then
			@sprite = "Graphics/Sprites/Powerup_Ammo.gif"
		elsif @kind == 1 then
			@sprite = "Graphics/Sprites/Powerup_Weapon.gif"
		elsif @kind == 2 then
			@sprite = "Graphics/Sprites/Powerup_Points.gif"
		elsif @kind == 3 then
			@sprite = "Graphics/Sprites/Powerup_Armor.gif"
		end
		@graphic = Image.new(window, @sprite, false)
		@x = x
		@y = y
	end
	
	def update
		# Slowly moving in random direction
		@dir = rand(4)
		if @dir == 1 then
			self.x += 0.5
		end
		if @dir == 2 then
			self.y -= 0.1
		end
		if @dir == 3 then
			self.x -= 0.5
		end
		if @dir == 4 then
			self.y += 1 
		end
	end
	
	def collide(px,py, powerup)
		powerup.reject! do |powerup|
			@dist = distance(powerup.x, powerup.y, px + 17, py)
			if @dist < 22 then       
				collect
			end
		end
	end
	
	# Limit movement to window size
	def x=(v)
		@x = [[590,v].min,0].max
	end
	def y=(v)
		@y = [[430,v].min,0].max
	end
	
	def collect
		# Giving effect depending on kind
		if @kind == 0 then
			# Collected Ammunition
			$p1_ammo += 30
			$p2_ammo += 30
		elsif @kind == 1 then
			# Collected Weapon Update
			$update = 1
		elsif @kind == 2 then
			# Collected additional ponts
			am = rand(3)
			if am == 1 then
				$score += 500
				$score2 += 500
			elsif am == 2
				$score += 800
				$score2 += 800
			else
				$score += 1300
				$score2 += 1300
			end
		elsif @kind == 3 then
			# Collected armor update
			$p1_armor += 3
			$p2_armor += 3
			if $p1_armor > 50 then
				$p1_armor = 50
			end
			if $p2_armor > 50 then
				$p2_armor = 50
			end
		end
	end
	
	def draw
		@graphic.draw(self.x, self.y, ZOrder::Player)
	end
	
end