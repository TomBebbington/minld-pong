Paddle = {
    width = 16,
    height = 64,
    color = {1.0, 1.0, 1.0},
    speed = 300,
    isPaddle = true
}
local setColor = love.graphics.setColor;
local rect = love.graphics.rectangle;

function Paddle.new(world, align)
    local x;
    if align == "left"  then
        align = -1
    elseif align == "right" then
        align = 1
    end
    local this = {
        world = world,
        align = align
    };
    setmetatable(this, {__index = Paddle})
    this:respawn()
    world:add(this, this.x, this.y, this.width, this.height)
    return this;
end

function Paddle:respawn()
    if self.align == -1 then
        self.x = Paddle.width / 2
    elseif self.align == 1 then
        self.x = love.graphics.getWidth() - Paddle.width * 1.5
    else
        print("invalid align")
    end
    self.y = (love.graphics.getHeight() - 2 * Paddle.height) / 2
end

function Paddle:draw()
    setColor(self.color)
    rect("fill", self.x, self.y, self.width, self.height)
end

function Paddle.filter(item, other)
    return 'slide'
end

function Paddle:get_vy()
    return self:get_direction() * self.speed
end

function Paddle:update(dt)
    local ny = self.y + dt * self:get_vy()
    if ny < 0 then
        ny = 0
    elseif ny + self.height > love.graphics.getHeight() then
        ny = love.graphics.getHeight() - self.height
    end
    local ax, ay = self.world:move(self, self.x, ny, Paddle.filter)
    self.x = ax
    self.y = ay
end

return Paddle
