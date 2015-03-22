local play = require 'play'
local title = {}
function title.load()
    title.font = love.graphics.newFont("font/PressStart2P.ttf", 42)
    love.graphics.setBackgroundColor(125, 125, 125)
end

function title.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(title.font)
    local text = "Play Pong"
    love.graphics.print(text, (love.graphics.getWidth() - scene.font:getWidth(text)) / 2, 10)
end

function title.keypressed(key, rep)
    if key == ' ' and not rep then
        switch_scene(play)
    end
end


return title
