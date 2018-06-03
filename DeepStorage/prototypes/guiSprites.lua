
-- For each item, make a sprite that has an alpha value of 50
for _,itemData in pairs(data.raw["item"]) do

  local sprite =
  {
    type = "sprite",
    name = "deepStorage-" .. itemData.name .. "-alphaSprite",
  }

  if itemData.icon then
    sprite.filename = itemData.icon
    sprite.width = itemData.icon_size
    sprite.height = itemData.icon_size
    sprite.tint = {r = .5, g = .5, b = .5, a = .5,}

  elseif itemData.icons then
    sprite.layers = {}
    for i,icon in pairs(itemData.icons) do
      sprite.layers[i] =
      {
        filename = icon.icon,
        width = icon.icon_size or itemData.icon_size,
        height = icon.icon_size or itemData.icon_size,
        scale = icon.scale,
        shift = icon.shift,
        tint =
        {
          r = (icon.tint and icon.tint.r or 1) * .5,
          g = (icon.tint and icon.tint.g or 1) * .5,
          b = (icon.tint and icon.tint.b or 1) * .5,
          a = (icon.tint and icon.tint.a or 1) * .5,
        }
      }

      if icon.tint then
        log("--- before ---")
        log(serpent.block(icon.tint))
      end
      log("--- afther ---")
      log(serpent.block(sprite.layers[i].tint))
      
    end
  end

  data:extend({
    sprite
  })

end
