require 'lib/utilities/util'

function oneToFourWay(oneWay)
  return deepcopy({
    ["north"] = oneWay,
    ["east"] = oneWay,
    ["south"] = oneWay,
    ["west"] = oneWay,
  })
end

function pictureToRotatedAnimation(picture)
  return deepcopy({
    ["filename"] = picture.filename,
    ["priority"] = picture.priority,
    ["width"] = picture.width,
    ["height"] = picture.height,
    ["frame_count"] = 1,
    ["direction_count"] = 1,
    ["shift"] = picture.shift,
    ["animation_speed"] = 1/(60*60*60*24), -- one update each day
  })
end
