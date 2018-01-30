require 'src/utilities'
local loaded

Settings = {}


Settings.modName = "__ForceFields2__"



-- gui settings
Settings.configWallIconName = "forcefield-config-tool"

Settings.guiSelectButtonStyle = "selectbuttons"
Settings.guiSelectButtonSelectedStyle = "selectbuttonsselected"
Settings.guiSmallSelectButtonStyle = "smallselectbuttons"
Settings.guiSmallSelectButtonSelectedStyle = "smallselectbuttonsselected"


-- builder settings
Settings.forcefieldBuildDamageName = "forcefield-build-damage"
Settings.forcefieldDeathDamageName = "forcefield-death-damage"



-- emitter settings
Settings.emitterName = "forcefield-emitter"
Settings.tickRate = 20

Settings.emitterDefaultDistance = 10
Settings.maxRangeUpgrades = 23
Settings.emitterMaxDistance = Settings.emitterDefaultDistance + Settings.maxRangeUpgrades

Settings.emitterDefaultWidth = 25
Settings.maxWidthUpgrades = 10
Settings.widthUpgradeMultiplier = 4
Settings.emitterMaxWidth = Settings.emitterDefaultWidth + (Settings.maxWidthUpgrades * Settings.widthUpgradeMultiplier)

Settings.maxFieldDistance = math.max(Settings.emitterMaxDistance, Settings.emitterMaxWidth)



-- forcefields settings
Settings.fieldSuffix = "-forcefield"
Settings.fieldGateSuffix = "-forcefield-gate"
Settings.fieldEmptySuffix = "-forcefield-empty"
Settings.defaultFieldSuffix = Settings.fieldSuffix

Settings.defaultFieldType = "blue"
Settings.forcefieldTypes =
{
  ["blue" .. Settings.fieldSuffix] =
  {
    chargeRate = 0.2036111111111111,
    degradeRate = 2.777777777777778,
    respawnRate = 15,
    energyPerCharge = 4200,
    energyPerRespawn = 5000,
    energyPerHealthLost = 17000,
    damageWhenMined = 20,
    maxHealth = 300
  },
  ["green" .. Settings.fieldSuffix] =
  {
    chargeRate = 0.175,
    degradeRate = 2,
    respawnRate = 50,
    energyPerCharge = 4000,
    energyPerRespawn = 20000,
    energyPerHealthLost = 16000,
    damageWhenMined = 30,
    maxHealth = 700
  },
  ["purple" .. Settings.fieldSuffix] =
  {
    chargeRate = 0.2083333333333334,
    degradeRate = 3.333333333333333,
    respawnRate = 100,
    energyPerCharge = 7000,
    energyPerRespawn = 10000,
    energyPerHealthLost = 25000,
    damageWhenMined = 15,
    deathEntity = Settings.forcefieldDeathDamageName,
    maxHealth = 150
  },
  ["red" .. Settings.fieldSuffix] =
  {
    chargeRate = 0.175,
    degradeRate = 4.333333333333333,
    respawnRate = 30,
    energyPerCharge = 10000,
    energyPerRespawn = 50000,
    energyPerHealthLost = 40000,
    damageWhenMined = 99,
    maxHealth = 300
  }
}
Settings.forcefieldTypes["blue" .. Settings.fieldGateSuffix] = Settings.forcefieldTypes["blue" .. Settings.fieldSuffix]
Settings.forcefieldTypes["green" .. Settings.fieldGateSuffix] = Settings.forcefieldTypes["green" .. Settings.fieldSuffix]
Settings.forcefieldTypes["purple" .. Settings.fieldGateSuffix] = Settings.forcefieldTypes["purple" .. Settings.fieldSuffix]
Settings.forcefieldTypes["red" .. Settings.fieldGateSuffix] = Settings.forcefieldTypes["red" .. Settings.fieldSuffix]

--Settings.fieldEmptySetting = 0
--Settings.fieldWallSetting = 1
--Settings.fieldGateSetting = 2



function Settings:verifySettings()
  if self.tickRate < 0 then
    self.tickRate = 0
    throwError("Tick rate must be >= 0.")
  end

  if self.emitterDefaultDistance < 1 then
    self.emitterDefaultDistance = 1
    self.emitterMaxDistance = self.emitterDefaultDistance + self.maxRangeUpgrades
    self.maxFieldDistance = math.max(self.emitterMaxDistance, self.emitterMaxWidth)
    throwError("Emitter default distance must be >= 1.")
  end

  if self.emitterDefaultWidth < 1 then
    self.emitterDefaultWidth = 1
    throwError("Emitter default width must be >= 1.")
    self.emitterMaxWidth = self.emitterDefaultWidth + (self.maxWidthUpgrades * self.widthUpgradeMultiplier)
    self.maxFieldDistance = math.max(self.emitterMaxDistance, self.emitterMaxWidth)
  elseif (math.floor((self.emitterDefaultWidth - 1) / 2) * 2) + 1 ~= self.emitterDefaultWidth then
    self.emitterDefaultWidth = 25
    throwError("Emitter default width must be an odd number (or one).")
    self.emitterMaxWidth = self.emitterDefaultWidth + (self.maxWidthUpgrades * self.widthUpgradeMultiplier)
    self.maxFieldDistance = math.max(self.emitterMaxDistance, self.emitterMaxWidth)
  end

  if not self.forcefieldTypes[self.defaultFieldType .. self.defaultFieldSuffix] then
    self.defaultFieldType = "blue"
    self.defaultFieldSuffix = self.fieldSuffix
    throwError("Emitter default field type isn't known.")
  end
end
