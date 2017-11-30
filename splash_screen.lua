-----------------------------------------------------------------------------------------
-- intro_screen.lua
-- Created by: Ms Raffin
-- Date: Nov. 22nd, 2014
-- Description: This is the splash screen of the game. It displays the 
-- company logo with some sort of animation...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local companyLogo = display.newImageRect("Images/CompanyLogo.png", 1100, 800)
local star = display.newImageRect("Images/PNGPIX-COM-Star-Vector-PNG-Transparent-Image.png", 200, 200)
local star2 = display.newImageRect("Images/PNGPIX-COM-Star-Vector-PNG-Transparent-Image.png", 400, 400)
--local beetleship
local scrollSpeed = 10
local starSound = audio.loadSound("Sounds/starSound.mp3")
local starSoundsChannel

-- set the initial x and y position of companyLogo
companyLogo.x = 540
companyLogo.y = 400

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------



-- set the image 2 to be visable
star.alpha = 1

-- set image to look right
star:scale (1, 1) 

-- set the image 2 to be visable
star2.alpha = 1

-- set image to look right
star2:scale (1, 1)

-- set the initial x and y position of star 
star.x = 0
star.y = display.contentHeight/3

-- set the initial x and y position of star 2
star2.x = 200
star2.y = display.contentHeight/1



-- Function: MoveShip
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
-- The function that moves the beetleship across the screen
local function moveBeetleship()

    -- add the scroll speed to the x-value of the ship
    star.x = star.x + scrollSpeed
    
    -- change the transparency of the ship every time it moves so that it fades out
    star.alpha = star.alpha + 0.01
    
    -- Make star move diagonaly

    star.y = star.x + scrollSpeed

    --grow the star
    star.height = star.height + 2.5
    star.width = star.width + 2.5
    
    --Rotation of star

    star.rotation = star.rotation + 3

        -- add the scroll speed to the x-value of the ship
    star2.x = star2.x + scrollSpeed
    
    -- change the transparency of the ship every time it moves so that it fades out
    star2.alpha = star2.alpha - 0.013
    star.alpha = star.alpha - 0.013
    
    -- Make star move diagonaly

    star2.y = star2.x + scrollSpeed - 1
    
    --Rotation of star

    star2.rotation = star2.rotation + 2
    
    --shrink star2
    star2.height = star2.height - 2
    star2.width = star2.width - 2
    
end





-- The function that will go to the main menu 
local function gotoMainMenu()
    companyLogo.isVisible = false
    star.isVisible = false
    star2.isVisible = false
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the beetleship image
    beetleship = display.newImageRect("Images/beetleship.png", 200, 200)

    -- set the initial x and y position of the beetleship
    beetleship.x = 100
    beetleship.y = display.contentHeight/2

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( beetleship )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        starSoundsChannel = audio.play(starSound )

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveBeetleship)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(starSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene