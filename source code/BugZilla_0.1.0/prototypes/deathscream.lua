data:extend({
    {
        type = "explosion",
        name = "deathscream",
        flags = {"not-on-map"},
        animations =
        {
          {
            filename = "__core__/graphics/empty.png",
            priority = "extra-high",
            width = 1,
            height = 1,
            frame_count = 1,
            line_length = 1,
            animation_speed = 1
          },
        },
        light = {intensity = 0, size = 0},
        sound =
        {
            aggregation =
            {
                max_count = 1,
                remove = true
            },
            variations =
            {
                {
                    filename = '__BugZilla__/sounds/deathscream.ogg',
                    volume = 1
                }
            }
        }
    }
})
