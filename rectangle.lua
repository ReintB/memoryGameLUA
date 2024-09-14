function Rectangle(width, height, x, y, color)
    return{
        width = width,
        height = height,
        x = x,
        y = y,
        color = color,
        open = false, --representasi saat kotak di klik
        clear = false,

        draw = function (self)
            if self.open then
                love.graphics.setColor(color.r, color.g, color.b)
                love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
                love.graphics.setColor(color.r, color.g, color.b)
            else
                love.graphics.setColor(128/255, 128/255, 128/255)
                love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
                love.graphics.setColor(128/255, 128/255, 128/255)
            end

        end
    }
end

return Rectangle