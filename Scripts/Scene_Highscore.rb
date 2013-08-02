=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Scene_Highscore: Displays current High Score board.

=end

class Scene_Highscore
	
	def initialize(window)
		@window = window
		@background = Image.new(@window, "Graphics/Backgrounds/Highscore.gif", false)
		@cursor = Image.new(@window, "Graphics/Sprites/Cursor.gif", false)
		@cursor_x = 240
		@cursor_y = 500
		@cursor_index = 0
		@cursor_se = Sample.new(@window, $SE_Cursor)
		@confirm_se = Sample.new(@window, $SE_Confirm)
		# Retreiving high score from a file
		dir = "_HS_SF.dat"
		f = File.open(dir, 'rb')
			$Highscore = Marshal.load(f)
		f.close
	end
	
	def update
		
	end
	
	def draw
		@background.draw(20,20,ZOrder::Background)
		@cursor.draw(@cursor_x, @cursor_y, ZOrder::Background+1)
		# Displaying high score
		$font.draw_rel("#{$Highscore[0][:name]}: #{$Highscore[0][:score]}", 320, 185, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[1][:name]}: #{$Highscore[1][:score]}", 320, 210, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[2][:name]}: #{$Highscore[2][:score]}", 320, 235, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[3][:name]}: #{$Highscore[3][:score]}", 320, 260, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[4][:name]}: #{$Highscore[4][:score]}", 320, 285, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[5][:name]}: #{$Highscore[5][:score]}", 320, 310, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[6][:name]}: #{$Highscore[6][:score]}", 320, 335, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[7][:name]}: #{$Highscore[7][:score]}", 320, 360, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[8][:name]}: #{$Highscore[8][:score]}", 320, 385, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
		$font.draw_rel("#{$Highscore[9][:name]}: #{$Highscore[9][:score]}", 320, 410, 5, 0.5, 0.0, 1.0, 1.0, 0xffffff00)		
	end

	def button_pressed(id)
		if id == KbReturn or id == $key_fire or id == KbEscape then
			@confirm_se.play
			$scene = Scene_Title.new($window)
		end
	end	
	

	
end
