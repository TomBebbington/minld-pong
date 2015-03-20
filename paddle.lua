Paddle = {
    width = 64,
    height = 16,
    color = {1.0, 1.0, 1.0}
}
local setColor = love.graphics.setColor;
local rect = love.graphics.rectangle;

function Paddle.new()
    local this = {
        x = (love.graphics.getWidth() - Paddle.width) / 2,
        y = love.graphics.getHeight() - Paddle.height * 2
    };
    setmetatable(this, {__index = Paddle})
    return this;
end

function Paddle:draw()
    love.graphics.setColor(self.color)
    rect("fill", self.x, self.y, self.width, self.height)
end

local isDown = love.keyboard.isDown;
function Paddle:update(dt)
    local dir = 0;
    if isDown('left') or isDown('a') then
        dir = -1
    elseif isDown('right') or isDown('d') then
        dir = 1
    end
    print(dt, self.x, self.y, self.width, self.height)
    self.x = self.x + dt * dir * 1000
end

return Paddle
