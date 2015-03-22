Ball = {
    radius = 6,
    speed = 400,
    hit = love.audio.newSource("sounds/hit.wav")
}
function Ball.new(world, paddle)
    local self = {
        world = world
    }
    setmetatable(self, {__index = Ball})
    world:add(self, 0, 0, self.radius * 2, self.radius * 2)
    self:respawn()
    return self
end

function Ball.filter(item, other)
    return 'bounce'
end

function Ball:respawn()
    if self.last_hit ~= nil then
        love.audio.play(self.last_hit.score_sound:clone())
        self.last_hit:gain_point()
    end
    local player = scene.player
    local dir = player.align
    self.speed = Ball.speed * scene.difficulty
    self.vx, self.vy = normalise(2 * math.random(), math.random(), self.speed)
    if player.align == -1 then
        self.x = player.x + player.width
    elseif player.align == 1 then
        self.x = player.x - self.radius * 2
    end
    self.y = player.y + player.height / 2 - self.radius
    self.last_hit = player
    self.world:update(self, self.x, self.y, self.radius * 2, self.radius * 2)
end

function Ball:update(dt)
    if self.x < 0 or self.x + self.radius * 2 > love.graphics.getWidth() then
        self:respawn()
    end
    local ny = self.y + dt * self.vy
    if ny < 0 then
        ny = 0
        self.vy = math.abs(self.vy) + 2
    elseif ny + self.radius * 2 > love.graphics.getHeight() then
        ny = love.graphics.getHeight() - self.radius * 2 - 2
        self.vy = -math.abs(self.vy)
    end
    local cols, len
    self.x, self.y, cols, len = self.world:move(self, self.x + self.vx * dt, self.y + self.vy * dt, Ball.filter)
    for i = 1, len do
        local other = cols[i].other
        if other.isPaddle and other ~= self.last_hit and other.align == self.vx / math.abs(self.vx) then
            love.audio.play(Ball.hit:clone())
            self.last_hit = other
            self.vy = (self.vy + self.last_hit:get_vy()) / 2
            self.vx, self.vy = normalise(-self.vx, self.vy, self.speed)
            self.x = self.x + self.vx * dt
        end
    end
end

local setColor = love.graphics.setColor
local circle = love.graphics.circle
function Ball:draw()
    setColor(255, 255, 255)
    circle("fill", self.x + self.radius, self.y + self.radius, self.radius, 32)
end

return Ball
