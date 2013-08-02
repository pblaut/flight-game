=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Scene_Game: Main game controls, processes every main module for gameplay.

=end

class Scene_Game 
	
	def initialize(window)
		@window = window
		@background = Image.new(window, "Graphics/Backgrounds/Space.png", true)
		@gui = Image.new(window, "Graphics/Backgrounds/Map_Gui.bmp", false)
		# Beep sound
		@beep = Sample.new(window, "Audio/SE/Shot.wav")
		@explosion = Sample.new(window, "Audio/SE/Explosion.wav")
		# Background music
		@bgm = Song.new(window, "Audio/BGM/Game.ogg")
		@bgm.play(true)
		@bgm.volume = $BGM_vol
		# Creating a player instance
		@player = Player.new(window)
		# Setting a initial position of a player
		@player.x = 320
		@player.y = 320 
		@player.index = 1
		# If 2 players enabled
		if $twoplayers == true then
			# Create second plaer instance
			@player2 = Player2.new(window)
			# Move player 2 to given position
			@player2.x = 400
			@player2.y = 320
			# Change position of player 1
			@player.x = 240
			@player.y = 320
			@player2.index = 1
		end
		# Creating array variables: Bullets, Enemy, EnemyBullets
		@bullets = []
		@enemy = []
		@ebullets = []
		@powerups = []
		@game_frame = 0
		@player1_dead = false
		@player2_dead = false
	end
	
	#================================================================================================
	# update Method definition: Method is called every frame (approx. 60 times per second)
	#================================================================================================
	
	def update
		@player.x += 0.5
		# Player 1 movement controls
		if @player1_dead == false then
			if @window.button_down? $key_left then
				@player.move_left
			elsif @window.button_down? $key_right then
				@player.move_right
			elsif @window.button_down? $key_down then
				@player.move_down
			elsif @window.button_down? $key_up then 
				@player.move_up
			else
				@player.index = 1
			end
			#if @window.button_down? $key_fire then
				#i
			#end
		end
		shoot if @lock_fire
		# Player 2 movement controls
		# Used only if 2 player game is ran
		if $twoplayers == true and @player2_dead == false then
			if @window.button_down? $p2_left then
				@player2.move_left
			end
			if @window.button_down? $p2_right then
				@player2.move_right
			end
			if @window.button_down? $p2_down then
				@player2.move_down
			end
			if @window.button_down? $p2_up then 
				@player2.move_up
			else
				@player2.index = 1
			end
		end
		# Spawning new enemies
		if rand(100) < 4 and @enemy.size <= 15 then
			@enemy.push(Enemy.new(@window))
		end
		# Forcing player to move
		if @player1_dead == false then
			@player.move
		end
		# If 2 players enabled, forcing player 2 to move
		if $twoplayers == true and @player2_dead == false then
			@player2.move
		end
		# Calling methods for every present enemy and bullet
		@enemy.each {|e| e.move}
		@bullets.each {|b| b.update}
		@bullets.clone.each {|b| b.collide(@enemy,@bullets)}
		@bullets.delete_if {|b| b.y < -8} # Delete bullet if out of screen
		@ebullets.each {|eb| eb.update}
		@powerups.each {|pu| pu.update}
		if @player1_dead == false and @player != nil then
			@powerups.each {|pu| pu.collide(@player.x, @player.y, @powerups)}
		end
		if $twoplayers == true and @player2_dead == false and @player2 != nil then
			@powerups.each {|pu| pu.collide(@player2.x, @player2.y, @powerups)}
		end
		if @player != nil
			@ebullets.each {|eb| eb.collide(@player.x, @player.y, @ebullets)}
		end
		# Collision with 2nd player
		if $twoplayers == true and @player2 != nil then
			@ebullets.each {|eb| eb.collide2(@player2.x, @player2.y, @ebullets)}
		end
		@ebullets.delete_if {|eb| eb.y > 460}
		# Playing explosion sound if necessary
		if $beep == true then
			@explosion.play
			$beep = false
		end
		# Random shot by enemy
		if rand(100) < 4 and @enemy.size != 0 then 
			# Enemy shoots: picking random enemy
			i = random(0, @enemy.size-1).to_i
			@ebullets.push EnemyBullet.new(@window, @enemy[i].x+11, @enemy[i].y+25)
		end
		# Checking if player(s) are dead
		if $p1_armor <= 0 then
			@player = nil
			@player1_dead = true
		end
		if $p2_armor <= 0 then
			@player2 = nil
			@player2_dead = true
		end
		# If no players alive
		if $twoplayers == true then
			if @player1_dead == true and @player2_dead == true then
				$scene = Scene_HighscoreEntry1.new($window)
			end
		elsif $twoplayers == false then
			if @player1_dead == true then
				$scene = Scene_HighscoreEntry1.new($window)
			end
		end
		# Power-uping weapons
		if $update == 1 then
			if @player != nil and @player.weapon_level < 4 then
				@player.weapon_level += 1
			end
			if $twoplayers == true and @player2 != nil and @player2.weapon_level < 4 then
				@player2.weapon_level += 1
			end
			$update = 0
		end
	
		# Randomly spawning Powerups if enemy killed
		if $enemy_killed == true then
			@up = rand(100)
			# 30% chance of releasing power up
			if @up <= 30 then
				# Random power up
				# 50% for ammo, 25% for points, 10% for armor, 3% for weapon update, 11% for no powerup
				@ef = rand(100)
				if @ef <= 50 then
					#Ammo
					@powerups.push(Powerup.new($window, 0, rand(400)+50, rand(200)+25))
					p "Ammo up"
				end
				if @ef > 50 and @ef <= 75 then
					# Points
					@powerups.push(Powerup.new($window, 2, rand(400)+50, rand(200)+25))
					p "Points up"
				end
				if @ef > 75 and @ef <= 85 then
					# Armor
					@powerups.push(Powerup.new($window, 3, rand(400)+50, rand(200)+25))
					p "Armor up"
				end
				if @ef > 86 and @ef <= 89 then 
					# Weapon update
					@powerups.push(Powerup.new($window, 1, rand(400)+50, rand(200)+25))
					p "Weapon up"
				end
			end
			$enemy_killed = false
		end
	end
	
	#================================================================================================
	# shoot Method definition: Shooting behavior for player 1
	#================================================================================================
  
	def shoot
		if $p1_ammo > 0  and @player1_dead == false then
			if $window.frame == 10 then
				@beep.play($SE_vol)
				@bullets.push Bullet.new(@window, @player.x+15, @player.y+10)
				$window.reset_frames
			end
		end
	end
	
	#================================================================================================
	# shoot2 Method definition: Shooting behavior for player 2
	#================================================================================================
  
	def shoot2
		#Checking weapons level
		if @player2.weapon_level == 1 then
			# Adding bullet
			@bullets.push Bullet.new(@window, @player2.x+15, @player2.y + 10)
		elsif @player2.weapon_level == 2 then
			# Adding bullets
			@bullets.push Bullet.new(@window, @player2.x+10, @player2.y + 10)
			@bullets.push Bullet.new(@window, @player2.x+20, @player2.y + 10)
		elsif @player2.weapon_level == 3 then
			# Adding bullets
			@bullets.push Bullet.new(@window, @player2.x+10, @player2.y + 10)
			@bullets.push Bullet.new(@window, @player2.x+15, @player2.y + 10)
			@bullets.push Bullet.new(@window, @player2.x+20, @player2.y + 10)
		end
		# Playing shoot sound
		@beep.play($SE_vol)
	end
	  
	#================================================================================================
	# draw Method definition: Creating a graphic representation of all objects on the screen
	#================================================================================================
	
	def draw
		# Drawing a player 1
		if @player1_dead == false then
			@player.draw
		end
		# If 2 players enabled, drawing player 2
		if $twoplayers == true and @player2_dead == false then
			@player2.draw
		end
		# Drawing a shots
		@bullets.each {|b| b.draw}
		@ebullets.each {|eb| eb.draw}
		@powerups.each {|pu| pu.draw}
		# Drawing a background in window
		@background.draw(0,0,ZOrder::Background)
		@gui.draw(0,480,0)
		# Drawing every enemy
		@enemy.each {|e| e.draw}
		@enemy.each {|e| e.hud}
		# Drawing text display
		if $DEBUG == true then
			# Display data for DEBUG
			if $twoplayers == true
				# When there are two players
				if @player != nil then
					$font.draw("Player 1 Score: #{$score}", 10, 510, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Player 1 Ammunition: #{$p1_ammo}", 10, 530, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player 1 armor structure: #{($p1_armor*2).to_s}%", 10, 550, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
				if @player2 != nil then
					$font.draw("Player 2 Score: #{$score2}", 10, 580, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Player 2 Ammunition: #{$p2_ammo}", 10, 600, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player armor structure: #{($p2_armor*2).to_s}%", 10, 620, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
			else
				# When only one player is playing
				if @player != nil then
					$font.draw("Score: #{$score}", 10, 510, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Ammunition: #{$p1_ammo}", 10, 530, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player armor structure: #{($p1_armor*2).to_s}%", 10, 550, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
			end
			$font.draw("Enemies: #{@enemy.size}", 350, 510, 5, 1.0, 1.0, 0xffffff00) # DEBUG: Amount of enemies
			$font.draw("Bullets: #{@bullets.size + @ebullets.size}", 350, 530, 5, 1.0, 1.0, 0xffffff00) # DEBUG: Amount of bullets
		else
			# Display data when NO DEBUG
			if $twoplayers == true
				# When there are two players
				if @player != nil then
					$font.draw("Player 1 Score: #{$score}", 10, 510, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Player 1 Ammunition: #{$p1_ammo}", 10, 530, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player 1 armor structure: #{($p1_armor*2).to_s}%", 10, 550, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
				if @player2 != nil then
					$font.draw("Player 2 Score: #{$score2}", 10, 580, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Player 2 Ammunition: #{$p2_ammo}", 10, 600, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player armor structure: #{($p2_armor*2).to_s}%", 10, 620, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
			else
				# When only one player is playing
				if @player != nil then
					$font.draw("Score: #{$score}", 10, 510, 5, 1.0, 1.0, 0xffffff00) # Player score
					$font.draw("Ammunition: #{$p1_ammo}", 10, 530, 5, 1.0, 1.0, 0xffffff00) # Player ammunition
					$font.draw("Player armor structure: #{($p1_armor*2).to_s}%", 10, 550, 5, 1.0, 1.0, 0xffffff00) # Player armor
				end
			end
		end
	end
	
	#================================================================================================
	# button_down Method definition: No-frame repeat method for single button press
	#================================================================================================
	
	def button_pressed(id)
		# If player 1 fire button is pressed
		if id == $key_fire then
			$window.frame_shoting
			@lock_fire = true
		end
		# if player 2 fire button is pressed
		if id == $p2_shot
			if $p2_ammo > 0 and @player2_dead == false then
				$p2_ammo -= 1
				shoot2
			end
		end
		if id == KbEscape then
			$scene_temp = $scene.clone
			$scene = Scene_Menu.new($window)
		end
	end
	
	def button_released(id)
		if id == $key_fire then
			@lock_fire = false
		end
	end
	
end