function love.conf(t)
    t.identity = "toms-pong"
    t.window.title = "Tom's Pong"
    t.window.minwidth = 800
    t.window.minheight = 600
    t.window.resizable = true
    t.modules.physics = false
    t.modules.thread = false
end
