local bump = require 'bump';
local Ball = require 'ball';
local Paddle = require 'paddle';
local Player = require 'player';
local Enemy = require 'enemy';

local play = {}

function play.load()
    play.paused = false
    play.difficulty = 1
    play.elapsed = 0
    play.score = 0
    play.world = bump.newWorld()
    play.font = love.graphics.newFont("font/PressStart2P.ttf", 42)
    love.graphics.setBackgroundColor(125, 125, 125)
    play.enemies = { Enemy.new(play.world, 1) }
    play.player = Player.new(play.world)
    play.ball = Ball.new(play.world, player)
end

function play.draw()
    play.ball:draw()
    play.player:draw()
    for i = 1, #play.enemies do
        play.enemies[i]:draw()
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(play.font)
    local text = "Score: "..play.score
    love.graphics.print(text, (love.graphics.getWidth() - scene.font:getWidth(text)) / 2, 10)
    if play.paused then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(255, 255, 255)
        local text = "Paused"
        love.graphics.print(text, (love.graphics.getWidth() - font:getWidth(text)) / 2, (love.graphics.getHeight() - font:getHeight(text)) / 2)
    end
end

function play.restart()
    ball:respawn()
    ball.last_hit = nil
    score = 0
end

function play.update(dt)
    if not paused then
        play.ball:update(dt)
        play.player:update(dt)
        for i = 1, #play.enemies do
            play.enemies[i]:update(dt)
        end
    end
end

function play.add_score(p)
    play.score = play.score + p
    if play.score < 0 then
        play.difficulty = 0.5/-play.score
    elseif play.score == 0 then
        play.difficulty = 1 / 2
    elseif play.score > 2 then
        play.difficulty = math.log(play.score)
    end
end

return play
