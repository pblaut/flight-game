=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Scene_HighscoreEntry2: Player 2 high score record

=end

class Scene_HighscoreEntry2
	
	def initialize(window)
		@window = window
		@background = Image.new(@window, "Graphics/Backgrounds/HSName_P2.gif", false)
		@cursor = Image.new(@window, "Graphics/Sprites/Cursor2.gif", false)
		@cursor_x = 165
		@cursor_y = 300
		@cursor_index = 0
		@cursor_se = Sample.new(@window, $SE_Cursor)
		@confirm_se = Sample.new(@window, $SE_Confirm)
		@generate = ScoreGenerator.new
		@i1 = 0
		@i2 = 0
		@i3 = 0
		@iname = 0
	end
	
	def update
		@name = [$charmap[@i1].to_s,$charmap[@i2].to_s,$charmap[@i3].to_s]
		if @iname == 0
			@cursor_x = 165
		elsif @iname == 1
			@cursor_x = 186
		elsif @iname == 2
			@cursor_x = 207
		elsif @iname == 3
			@cursor_x = 282
		end
		if @iname < 0
			@iname = 2
		end
		if @iname > 3
			@iname = 0
		end
		if @iname == 3
			@cursor = Image.new(@window, "Graphics/Sprites/Cursor.gif", false)
		else
			@cursor = Image.new(@window, "Graphics/Sprites/Cursor2.gif", false)
		end
	end
		
	def draw
		@background.draw(20,20,ZOrder::Background)
		@cursor.draw(@cursor_x, @cursor_y, ZOrder::Background+1)
		$font.draw("#{$score2.to_s}", 223, 215, 5, 1.0, 1.0, 0xffffff00)
		$font.draw("#{@name[0]}", 173, 310, 5, 1.0, 1.0, 0xffffff00)
		$font.draw("#{@name[1]}", 194, 310, 5, 1.0, 1.0, 0xffffff00)
		$font.draw("#{@name[2]}", 215, 310, 5, 1.0, 1.0, 0xffffff00)
	end

	def button_pressed(id)
		if id == KbLeft then
			@iname -= 1
			@cursor_se.play
		end
		if id == KbRight then
			@iname += 1
			@cursor_se.play
		end
		if id == KbUp then
			if @iname == 0
				@i1 -= 1
			end
			if @iname == 1
				@i2 -= 1
			end
			if @iname == 2
				@i3 -= 1
			end
			@cursor_se.play
		end
		if id == KbDown then
			if @iname == 0
				@i1 += 1
			end
			if @iname == 1
				@i2 += 1
			end
			if @iname == 2
				@i3 += 1
			end
			@cursor_se.play
		end
		if id == KbReturn or id == $key_fire and @iname == 3 then
			confirm
			@confirm_se.play
		end
	end	
	
	def confirm
		text = ""
		text += @name[0]
		text += @name[1]
		text += @name[2]
		# Just one player: generate high score and go to Scene_HighScore
		# Generate high score
		@generate.generate_score(text,$score2)
		$scene = Scene_Highscore.new($window)
	end
	
end
