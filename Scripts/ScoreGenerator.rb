=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	ScoreGenerator: Adds and sorts score in file. 

=end

class ScoreGenerator
	
	def initialize
		
	end
	
	def generate_score(name, score)
		@name = name
		@score = score
		$Highscore <<	{ :name => @name, :score => @score}
		$Highscore = $Highscore.sort { |a,b| b[:score] <=> a[:score] }[0,10] 
		dir = "_HS_SF.dat"
		f = File.open(dir,  'wb')
			Marshal.dump($Highscore, f)
		f.close
	end

end