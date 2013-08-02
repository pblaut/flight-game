=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	GameWindow class: Creates a window for a game.

=end

class GameWindow < Window
	
	attr_reader :frame
	
	def initialize
		super(640,640,false)
		self.caption = "Flight"
		# Scene
		$scene = Scene_Title.new(self) 
		$window = self
		@frame = 0
		# Creating font instance
		$font = Font.new(self, default_font_name, 20)
		# Generating custom, image-based font
		$font.[]=('A','Graphics/Font/A.gif')
		$font.[]=('a','Graphics/Font/Aa.gif')
		$font.[]=('B','Graphics/Font/B.gif')
		$font.[]=('b','Graphics/Font/Bb.gif')
		$font.[]=('C','Graphics/Font/C.gif')
		$font.[]=('c','Graphics/Font/Cc.gif')
		$font.[]=('D','Graphics/Font/D.gif')
		$font.[]=('d','Graphics/Font/Dd.gif')
		$font.[]=('E','Graphics/Font/E.gif')
		$font.[]=('e','Graphics/Font/Ee.gif')
		$font.[]=('F','Graphics/Font/F.gif')
		$font.[]=('f','Graphics/Font/Ff.gif')
		$font.[]=('G','Graphics/Font/G.gif')
		$font.[]=('g','Graphics/Font/Gg.gif')
		$font.[]=('H','Graphics/Font/H.gif')
		$font.[]=('h','Graphics/Font/Hh.gif')
		$font.[]=('I','Graphics/Font/I.gif')
		$font.[]=('i','Graphics/Font/Ii.gif')
		$font.[]=('J','Graphics/Font/J.gif')
		$font.[]=('j','Graphics/Font/Jj.gif')
		$font.[]=('K','Graphics/Font/K.gif')
		$font.[]=('k','Graphics/Font/Kk.gif')
		$font.[]=('L','Graphics/Font/L.gif')
		$font.[]=('l','Graphics/Font/Ll.gif')
		$font.[]=('M','Graphics/Font/M.gif')
		$font.[]=('m','Graphics/Font/Mm.gif')
		$font.[]=('N','Graphics/Font/N.gif')
		$font.[]=('n','Graphics/Font/Nn.gif')
		$font.[]=('O','Graphics/Font/O.gif')
		$font.[]=('o','Graphics/Font/Oo.gif')
		$font.[]=('P','Graphics/Font/P.gif')
		$font.[]=('p','Graphics/Font/Pp.gif')
		$font.[]=('Q','Graphics/Font/Q.gif')
		$font.[]=('q','Graphics/Font/Qq.gif')
		$font.[]=('R','Graphics/Font/R.gif')
		$font.[]=('r','Graphics/Font/Rr.gif')
		$font.[]=('S','Graphics/Font/S.gif')
		$font.[]=('s','Graphics/Font/Ss.gif')
		$font.[]=('T','Graphics/Font/T.gif')
		$font.[]=('t','Graphics/Font/Tt.gif')
		$font.[]=('U','Graphics/Font/U.gif')
		$font.[]=('u','Graphics/Font/Uu.gif')
		$font.[]=('V','Graphics/Font/V.gif')
		$font.[]=('v','Graphics/Font/Vv.gif')
		$font.[]=('W','Graphics/Font/W.gif')
		$font.[]=('w','Graphics/Font/Ww.gif')
		$font.[]=('X','Graphics/Font/X.gif')
		$font.[]=('x','Graphics/Font/Xx.gif')
		$font.[]=('Y','Graphics/Font/Y.gif')
		$font.[]=('y','Graphics/Font/Yy.gif')
		$font.[]=('Z','Graphics/Font/Z.gif')
		$font.[]=('z','Graphics/Font/Zz.gif')
		$font.[]=('0','Graphics/Font/0.gif')
		$font.[]=('1','Graphics/Font/1.gif')
		$font.[]=('2','Graphics/Font/2.gif')
		$font.[]=('3','Graphics/Font/3.gif')
		$font.[]=('4','Graphics/Font/4.gif')
		$font.[]=('5','Graphics/Font/5.gif')
		$font.[]=('6','Graphics/Font/6.gif')
		$font.[]=('7','Graphics/Font/7.gif')
		$font.[]=('8','Graphics/Font/8.gif')
		$font.[]=('9','Graphics/Font/9.gif')
		$font.[]=('$','Graphics/Font/$.gif')
		$font.[]=('%','Graphics/Font/%.gif')
		$font.[]=('^','Graphics/Font/^.gif')
		$font.[]=('&','Graphics/Font/&.gif')
		$font.[]=('(','Graphics/Font/(.gif')
		$font.[]=(')','Graphics/Font/).gif')
		$font.[]=('@','Graphics/Font/@.gif')
		$font.[]=('-','Graphics/Font/-.gif')
		$font.[]=('+','Graphics/Font/+.gif')
		$font.[]=('!','Graphics/Font/EMark.gif')
		$font.[]=('?','Graphics/Font/QMark.gif')
		$font.[]=('#','Graphics/Font/Hash.gif')
		$font.[]=('<','Graphics/Font/LessThan.gif')
		$font.[]=('>','Graphics/Font/MoreThan.gif')
		$font.[]=(':','Graphics/Font/SemiColon.gif')
		$font.[]=('*','Graphics/Font/Star.gif')
		$font.[]=('|','Graphics/Font/VerLine.gif')
	end
	
	def update
		$scene.update
		update_click
		p @frame if $DEBUG == true
	end
	
	def update_click
		if @frame <= 60 then
			@frame += 1
		end
		if @frame == 60 then
			@frame = 0
		end
	end
	
	def reset_frames
		@frame = 0
	end
	
	def frame_shoting
		@frame = 10
	end
	
	def draw
		$scene.draw
	end
	
	def button_down(id)
		$scene.button_pressed(id)
	end
	
	def button_up(id)
		$scene.button_released(id)
	end
	
end
