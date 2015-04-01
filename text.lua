Text = {
}
function Text.new(paddle, text)
    local self = {}
    self.paddle = paddle
    self.text = text
    setmetatable(self, {__index = Text})
    return self
end

function Text:draw()
    local font = small_font
    love.graphics.setFont(font)
    love.graphics.setColor(255, 255, 255)
    local w, h = font:getWidth(self.text), font:getHeight()
    local align = self.paddle.align
    local x
    if align == -1 then
        x = self.paddle.x + self.paddle.width + 10
    elseif align == 1 then
        x = self.paddle.x - self.paddle.width * 0.5 - w - 10
    end
    local y = self.paddle.y - h * 1.5
    love.graphics.print(self.text, x, y)
end

return Text
