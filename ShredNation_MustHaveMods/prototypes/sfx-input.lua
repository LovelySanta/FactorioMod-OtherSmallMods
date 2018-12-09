
data:extend{
  {
    type = "custom-input",
    name = "SN-sfx-fart-key",
    key_sequence = "f"
  },
}

for _,nbr in pairs{
  "1","2","3","4","5","6","7","8","9","0"
} do
  data:extend{
    {
      type = "custom-input",
      name = "SN-sfx-"..nbr,
      key_sequence = "PAD "..nbr
    },
  }
end
