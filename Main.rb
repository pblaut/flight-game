=begin
	Game title: Flight
	Date: March/April 2012
	Authors:	Piotr Blaut
			Ciara Kennedy
	
	This game is a Software Engineering project.
	
	Main class: Imports all values and files.

=end

$: << File.dirname(__FILE__)
# Check for required libraries
require 'gosu'
include Gosu
require 'rubygems'
require 'Scripts/GameWindow.rb'
require 'Scripts/Scene_Game.rb'
require 'Scripts/Player.rb'
require 'Scripts/Player2.rb'
require 'Scripts/Enemy.rb'
require 'Scripts/EnemyBullet.rb'
require 'Scripts/Bullet.rb'
require 'Scripts/ZOrder.rb'
require 'Scripts/Scene_Title.rb'
require 'Scripts/Scene_Players.rb'
require 'Scripts/Scene_Highscore.rb'
require 'Scripts/Scene_Menu.rb'
require 'Scripts/Scene_Confirm.rb'
require 'Scripts/Scene_HighscoreEntry1.rb'
require 'Scripts/Scene_HighscoreEntry2.rb'
require 'Scripts/ScoreGenerator.rb'
require 'Scripts/Powerup.rb'
# Import all classes


#Creating a controls variables
$key_up = KbUp
$key_down = KbDown
$key_left = KbLeft
$key_right = KbRight
$key_fire = KbSpace
$p2_up = KbW
$p2_down = KbS
$p2_left = KbA
$p2_right = KbD
$p2_shot = KbTab
# Creating a zero-valued score variable
$score = 0
$score2 = 0
# Creating options values for audio
$SE_vol = 0.8
$BGM_vol = 1.0
# Creating sound effect files variables
$SE_Cursor = "Audio/SE/Cursor.wav"
$SE_Cancel = "Audio/SE/Cancel.wav"
$SE_Confirm = "Audio/SE/Confirm.wav"
# Creating a shoot beep sound control
$beep = false
# Creating an option variable: 2 players?
$twoplayers = false
# Creating character map table for naming.
$charmap = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
		 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		 '0','1','2','3','4','5','6','7','8','9','!','@','#','$','%','^','&','*','(',')','-','+',':','|','>','<','?']
# Player armors:
$p1_armor = 50
$p2_armor = 50
# Player ammunition amount
$p1_ammo = 100
$p2_ammo = 100
# High Score variable:
$Highscore = []
# Prepopulating High Score variable with previous entries
dir = "_HS_SF.dat"
f = File.open(dir, 'rb')
$Highscore = Marshal.load(f)
f.close

$enemy_killed = false
$update = 0

# Debug variable: Test if debug option should be on or off
if File.exist?("_DEBUG") then
	$DEBUG = true
else
	$DEBUG = false
end


# Import game window:
@window = GameWindow.new
@window.show