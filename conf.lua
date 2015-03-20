function love.conf(t)
    t.identity = "toms-pong"
    t.window.title = "Tom's Pong"
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = false
    t.window.fullscreen = false
    t.modules.math = false
    t.modules.physics = false
    t.modules.timer = false
    t.modules.thread = false
end
