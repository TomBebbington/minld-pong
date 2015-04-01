local play = require 'play'
local title = require 'title'

function normalise(vx, vy, speed)
    local length = math.sqrt(vx * vx + vy * vy)
    local speed_len = speed / length
    return vx * speed_len, vy * speed_len
end

function switch_scene(c_scene)
    scene = c_scene
    c_scene.load()
    for i, v in pairs(c_scene) do
        if i ~= "load" then
            love[i] = v
        end
    end
end

function love.load()
    font = love.graphics.newFont("font/PressStart2P.ttf", 42)
    small_font = love.graphics.newFont("font/PressStart2P.ttf", 21)

    switch_scene(title)
end
