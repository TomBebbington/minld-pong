Player = {
    score_sound = love.audio.newSource("sounds/enemy_die.wav")
}
setmetatable(Player, {__index = Paddle})
function Player.new(world)
    local self = Paddle.new(world, 'left')
    setmetatable(self, {__index = Player})
    function scene.keypressed(key, rep)
        if key == 'r' and not rep then
            scene.restart()
        elseif key == 'p' and not rep then
            paused = not paused
        end
    end

    function scene.joystickadded(joystick)
        self.joystick = joystick
    end
    function scene.joystickremoved(joystick)
        self.joystick = nil
    end
    return self
end

local isDown = love.keyboard.isDown;
function Player:get_direction()
    if self.joystick ~= nil then
        local hat = self.joystick:getHat(1)
        if hat == 'u' then
            return -1
        elseif hat == 'd' then
            return 1
        else
            return 0
        end
    elseif isDown('up') or isDown('w') then
        return -1
    elseif isDown('down') or isDown('s') then
        return 1
    else
        return 0
    end
end

function Player:update(dt)
    if self.joystick ~= nil then
        local p = self.joystick:isDown(1)
        if self.last_p ~= nil and p ~= self.last_p then
            paused = not paused
        end
        self.last_p = p
    end
    Paddle.update(self, dt)
end

function Player:gain_point()
    scene.add_score(1)
end

return Player
