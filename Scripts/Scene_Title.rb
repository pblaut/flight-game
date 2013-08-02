=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Scene_Title: Opening screen and menu for a game.

=end

class Scene_Title
	
	def initialize(window)
		@window = window
		@background = Image.new(@window, "Graphics/Backgrounds/Title.gif", false)
		@cursor = Image.new(@window, "Graphics/Sprites/Cursor.gif", false)
		@cursor_x = 240
		@cursor_y = 370
		@cursor_index = 0
		@bgm = Song.new(window, "Audio/BGM/Title.ogg")
		@bgm.play(true)
		@cursor_se = Sample.new(@window, $SE_Cursor)
		@confirm_se = Sample.new(@window, $SE_Confirm)
	end
	
	def update
		if @cursor_index > 2 then
			@cursor_index = 0
		end
		if @cursor_index < 0 then
			@cursor_index = 2
		end
		if @cursor_index == 0 then
			@cursor_x = 240
			@cursor_y = 370
		elsif @cursor_index == 1 then
			@cursor_x = 240
			@cursor_y = 402
		elsif @cursor_index == 2 then
			@cursor_x = 240
			@cursor_y = 434
		end
	end
	
	def draw
		@background.draw(20,20,ZOrder::Background)
		@cursor.draw(@cursor_x, @cursor_y, ZOrder::Background+1)
	end

	def button_pressed(id)
		if id == $key_up then
			@cursor_index -= 1
			@cursor_se.play
		end
		if id == $key_down then
			@cursor_index += 1
			@cursor_se.play
		end
		if id == KbReturn or id == $key_fire then
			confirm
			@confirm_se.play
		end
	end	
	
	def button_released(id)
		
	end
	
	def confirm
		if @cursor_index == 0 then
			$scene = Scene_Players.new($window)
		elsif @cursor_index == 1 then
			$scene = Scene_Highscore.new($window)
		elsif @cursor_index == 2 then
			$window.close
		end
	end
	
end
