local bump = require 'bump';
local Ball = require 'ball';
local Paddle = require 'paddle';
local Player = require 'player';
local Enemy = require 'enemy';
local Text = require 'text';
local converse = require 'converse';

local play = {}

function play.load()
    play.paused = false
    play.difficulty = 1
    play.elapsed = 0
    play.score = 0
    play.world = bump.newWorld()
    love.graphics.setBackgroundColor(125, 125, 125)
    play.enemy = Enemy.new(play.world, 1)
    play.player = Player.new(play.world)
    play.ball = Ball.new(play.world, player)
    play.talk_turn = 1
    play.text = Text.new(play.player, converse[play.talk_turn])
    play.add_score(0)
    play.talk_timer = 0
end

function play.draw()
    play.ball:draw()
    play.player:draw()
    play.enemy:draw()
    play.text:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(font)
    local text = "Score: "..play.score
    love.graphics.print(text, (love.graphics.getWidth() - font:getWidth(text)) / 2, 12)
    if play.paused then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(255, 255, 255)
        local text = "Paused"
        love.graphics.print(text, (love.graphics.getWidth() - font:getWidth(text)) / 2, (love.graphics.getHeight() - font:getHeight(text)) / 2)
    end
end

function play.restart()
    play.ball.last_hit = nil
    play.score = 0
    play.player:respawn()
    play.enemy:respawn()
    play.ball:respawn()
end

function play.update(dt)
    if not paused then
        play.talk_timer = play.talk_timer + dt
        if play.talk_timer >= 3 then
            play.talk_timer = 0
            play.talk_turn = play.talk_turn + 1
            if play.talk_turn >= #converse then
                play.talk_turn = 1
            end
            if play.talk_turn % 2 == 1 then
                play.text.paddle = play.player
            else
                play.text.paddle = play.enemy
            end
            play.text.text = converse[play.talk_turn]
        end
        play.ball:update(dt)
        play.player:update(dt)
        play.enemy:update(dt)
    end
end

function play.add_score(p)
    play.score = play.score + p
    if play.score < 0 then
        play.difficulty = 0.7/-play.score
    elseif play.score == 0 then
        play.difficulty = 0.8
    elseif play.score > 2 then
        play.difficulty = math.log(play.score)
    end
    math.randomseed(play.score)
    play.enemy.color = {math.random(0, 255), math.random(0, 255), math.random(0, 255)}
    play.enemy.speed = scene.difficulty * Paddle.speed
    play.enemy:respawn()
    play.player:respawn()
end

return play
