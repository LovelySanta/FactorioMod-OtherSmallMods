require("prototypes.sfx-input")

for _,sound in pairs{
  "fart1.ogg",
  "fart2.ogg",
  "fart3.ogg",
  "fart4.ogg",
  "fart5.ogg",
  "fart6.ogg",
} do
  data:extend{
      {
          type = "sound",
          name = sound,
          filename = '__ShredNation_MustHaveMods__/sounds/'..sound,
          volume = 1
      }
  }
end
