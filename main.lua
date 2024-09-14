--alt + l

WIDTH = 840
HEIGHT = 640

require("rectangle")
require("color")


function love.load()
    love.window.setMode(WIDTH, HEIGHT)
    love.window.setTitle("Memory game")

    column = 4
    row = 3

    RED = Color(255/255, 0/255, 0/255)
    GREEN = Color(0/255, 255/255, 0/255)
    ORANGE = Color(255/255, 165/255, 0/255)
    YELLOW = Color(255/255, 255/255, 0/255)
    PURPLE = Color(128/255, 0/255, 128/255)
    CYAN = Color(0/255, 255/255, 255/255)

    colors = {RED, GREEN, ORANGE, YELLOW, PURPLE, CYAN, RED, GREEN, ORANGE, YELLOW, PURPLE, CYAN}
    rectangles= {}

    for i = 1, column do
        rectangles[i] = {}
        for j = 1, row do
            math.randomseed(os.time())
            local color = table.remove(colors, math.random(#colors))
            --bakalan ngerandom warna yang ada di array color pakai math.random untuk mendapat warna random dari list colors
            rectangles[i][j] = Rectangle(100, 100, i * 190 - 100, j * 180 - 100, color)
        end
    end

    nextRectangle = nil
    prevRectangle = nil
    countdown = 2
    overCount = 0
    gameOver = false
end

function love.update(dt)
    if prevRectangle and nextRectangle then
        countdown = countdown - dt
    end

    if prevRectangle and nextRectangle then
        if prevRectangle.color == nextRectangle.color then
            if math.floor(countdown) == 0 then
                prevRectangle.clear = true
                nextRectangle.clear = true
                prevRectangle = nil
                nextRectangle = nil
                countdown = 2
                overCount = overCount + 1
            end

        elseif prevRectangle.colar ~= nextRectangle.color then
            if math.floor(countdown) == 0 then
                prevRectangle.open = false
                nextRectangle.open = false
                prevRectangle = nil
                nextRectangle = nil
                countdown = 2
            end
            
        end
    end

    if overCount == 6 then
        gameOver = true
    end
end

function love.draw()
    for _, row in pairs(rectangles) do
        for _, rectangle in pairs(row) do
            if not rectangle.clear then
                rectangle:draw()
            end
        end
    end

    if gameOver then
        love.graphics.setFont(love.graphics.newFont(50))
        love.graphics.setColor(1,0,0)
        love.graphics.printf("GAMEOVER", 0, 220, love.graphics.getWidth(), "center")
        love.graphics.setColor(1,0,0)
        love.graphics.setFont(love.graphics.newFont())

        love.graphics.setFont(love.graphics.newFont(35))
        love.graphics.setColor(1,1,1)
        love.graphics.printf("PRESS \"R\" FOR RESTART !", 0, 350, love.graphics.getWidth(), "center")
        love.graphics.setColor(1,1,1)
        love.graphics.setFont(love.graphics.newFont())
    end

    love.graphics.setColor(1,1,1)
    love.graphics.print("Countdown = " .. math.floor(countdown), 10,10)
    love.graphics.setColor(1,1,1)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Press \"esc\" to leave game", 10,40)
    love.graphics.setColor(1,1,1)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "r" then
        colors = {RED, GREEN, ORANGE, YELLOW, PURPLE, CYAN, RED, GREEN, ORANGE, YELLOW, PURPLE, CYAN}
        rectangles= {}
        for i = 1, column do
            rectangles[i] = {}
            for j = 1, row do
                math.randomseed(os.time())
                local color = table.remove(colors, math.random(#colors))
                --bakalan ngerandom warna yang ada di array color pakai math.random untuk mendapat warna random dari list colors
                rectangles[i][j] = Rectangle(100, 100, i * 190 - 100, j * 180 - 100, color)
            end
        end
        overCount = 0
        gameOver = false
    end
end

function love.mousepressed(x,y,button,istouch,presses)
    for _, row in pairs(rectangles) do
        for _, val in pairs (row) do
            if pointRectCollision(x,y, val.x, val.y, val.width, val.height) then
                if prevRectangle == nil then
                    prevRectangle = val
                    val.open = true
                elseif nextRectangle == nil and prevRectangle ~= val then
                    nextRectangle = val
                    val.open = true
                end
            end
        end
    end
end

function pointRectCollision(mouseX, mouseY, rectX, rectY, rectWidth, rectHeight)
    if mouseX >= rectX and mouseX <= rectX + rectWidth and mouseY >= rectY and mouseY <= rectY + rectHeight then
        return true
    else
        return false
    end
end