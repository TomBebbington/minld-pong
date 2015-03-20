local bump = require 'bump';
local Paddle = require 'paddle';
local world;
local paddles;

function love.load()
    world = bump.newWorld()
    paddles = { Paddle.new() }
end

function love.draw()
    for i = 1, #paddles do
        paddles[i]:draw()
    end
end

function love.update(dt)
    print("delta", dt);
    for i = 1, #paddles do
        local paddle = paddles[i]
        paddle:update(dt)
    end
end
