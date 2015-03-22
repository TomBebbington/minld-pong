Enemy = {
    score_sound = love.audio.newSource("sounds/player_die.wav")
}
setmetatable(Enemy, {__index = Paddle})
function Enemy.new(world, align)
    if align == nil then
        align = 'right'
    end
    local self = Paddle.new(world, align)
    setmetatable(self, {__index = Enemy})
    self.speed = self.speed * scene.difficulty
    return self
end

function Enemy:update(dt)
    self.speed = scene.difficulty * Paddle.speed
    math.randomseed(scene.score)
    self.color = {math.random(0, 255), math.random(0, 255), math.random(0, 255)}
    Paddle.update(self, dt)
end

function Enemy:get_direction()
    local cy = self.y + self.height / 2
    local by = scene.ball.y + scene.ball.radius
    local diff = by - cy
    return diff / math.abs(diff)
end

function Enemy:gain_point()
    scene.score = scene.score - 1
end

return Enemy
