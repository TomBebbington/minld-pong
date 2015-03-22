local play = require 'play'
local title = {}
function title.load()
    love.graphics.setBackgroundColor(125, 125, 125)
    function scene.joystickpressed(joystick, button)
        switch_scene(play)
        play.player.joystick = play
    end
end

function title.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(font)
    local text = "Tom's Pong"
    love.graphics.print(text, (love.graphics.getWidth() - font:getWidth(text)) / 2, 20)
    love.graphics.setFont(small_font)
    local text = "Press Space or Any Button to Play"
    love.graphics.print(text, (love.graphics.getWidth() - small_font:getWidth(text)) / 2, 100)
end

function title.keypressed(key, rep)
    if key == ' ' and not rep then
        switch_scene(play)
    end
end


return title
