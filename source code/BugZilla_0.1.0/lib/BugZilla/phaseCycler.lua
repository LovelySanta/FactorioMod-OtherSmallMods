require 'Libs/Utilities/math'

-- Class that controls the behavior of the surface:
  -- control the darkness
PhaseCycler = {}

-- PHASES:
-- 1. Initial Day phase (inital long phase)
-- 2. Nightfall phase
-- 3. Night phase (BugZilla spawned)
-- 4. Dawn phase
-- 5. Day phase
-- 6. back to 2
PhaseCycler.initPhaseIndex = 0
PhaseCycler.dayPhaseIndex = 1
phaseCycler.nightfallPhaseIndex = 2
phaseCycler.nightPhaseIndex = 3
phaseCycler.sunsetPhaseIndex = 4
-- next phase
PhaseCycler.getNextPhaseIndex = {
  [PhaseCycler.initPhaseIndex] = PhaseCycler.nightfallPhaseIndex,
  [PhaseCycler.dayPhaseIndex] = phaseCycler.nightfallPhaseIndex,
  [phaseCycler.nightfallPhaseIndex] = phaseCycler.nightPhaseIndex,
  [phaseCycler.nightPhaseIndex] = phaseCycler.sunsetPhaseIndex,
  [phaseCycler.sunsetPhaseIndex] = PhaseCycler.dayPhaseIndex
}
-- brightness config
PhaseCycler.dayBrightness = 1
PhaseCycler.nightBrightness = 0



function PhaseCycler.Init(self)
  -- Init the world
  game.map_settings.pollution.enabled = false
  game.map_settings.enemy_evolution = false
  game.map_settings.enemy_expansion = false
  -- TODO: kill all spawned biters & spawners
  game.surfaces[1].freeze_daytime = true

  -- Init data if not existing
  if global.BZ_data == nil then
    global.BZ_data = self:InitGlobalData()
  else
    game.print("BugZilla.lib.phaseCycler.lua: Cannot init global.BZ_data")
  end
end



function PhaseCycler.InitGlobalData(_)
  local data = {
    -- meta data
    Name = 'BZ_data',
    Version = '1',
    -- Time count
    time = {
      ticksThisSecond = 0,
      totalTicks = 0
    },
    -- State
    previousState = nil,
    currentState = nil,
    initState = {
      phaseIndex = PhaseCycler.initPhaseIndex,
      phaseDuration = 0, -- seconds we are in this phase
      phaseTotalDuration = settings.global["BZ-initial-day-length"].value * 60, -- how long this phase lasts
      currentBrightness = PhaseCycler.dayBrightness,
      startBrightness = PhaseCycler.dayBrightness,
      endBrightness = PhaseCycler.dayBrightness,
      nextPhaseIndex = PhaseCycler.dayPhaseIndex
    }
  }
  data.currentState = DeepCopy(data.initState)
  return data
end



function PhaseCycler.OnTick(self)
  global.BZ_data.time.totalTicks = global.BZ_data.time.totalTicks + 1

  if global.BZ_data.time.ticksThisSecond >= 59 then -- each second
    global.BZ_data.time.ticksThisSecond = 0
    self:OnSecond()
  else
    global.BZ_data.time.ticksThisSecond = global.BZ_data.time.ticksThisSecond + 1
  end
end



function PhaseCycler.OnSecond(self)
  global.BZ_data.previousState = DeepCopy(global.BZ_data.currentState)
  global.BZ_data.currentState.phaseDuration = global.BZ_data.currentState.phaseDuration + 1

  -- Check if we are finished with the current phase
  if global.BZ_data.currentState.phaseDuration >= global.BZ_data.currentState.totalPhaseDuration then
    self:GoToNextPhase()
  end

  -- Check if we need to change the brightness
  if global.BZ_data.currentBrightness ~= global.BZ_data.endBrightness then
    global.BZ_data.currentBrightness = Math.Lerp(global.BZ_data.startBrightness, global.BZ_data.endBrightness, global.BZ_data.phaseTotalDuration - 1)
    SetBrightness(global.BZ_data.currentBrightness)
  end
end



function PhaseCycler.GoToNextPhase(self)
  -- reset phase timer
  global.BZ_data.currentState.phaseDuration = 0

  -- update phase itself
  global.BZ_data.phaseIndex = global.BZ_data.nextPhaseIndex
  global.BZ_data.nextPhaseIndex = self.getNextPhaseIndex[global.BZ_data.phaseIndex]

  -- update phaseData
     -- phaseTotalDuration
     -- startBrightness, endBrightness
  global.BZ_data.startBrightness = global.BZ_data.currentBrightness

  if global.BZ_data.phaseIndex == PhaseCycler.dayPhaseIndex then
    global.BZ_data.phaseTotalDuration = 60 * settings.global["BZ-day-length"].value
    global.BZ_data.endBrightness = PhaseCycler.dayBrightness

  elseif global.BZ_data.phaseIndex == phaseCycler.nightfallPhaseIndex then
    global.BZ_data.phaseTotalDuration = 10
    global.BZ_data.endBrightness = PhaseCycler.nightBrightness

  elseif global.BZ_data.phaseIndex == phaseCycler.nightPhaseIndex then
    global.BZ_data.phaseTotalDuration = 60 * settings.global["BZ-night-length"].value
    global.BZ_data.endBrightness = PhaseCycler.nightBrightness

  elseif global.BZ_data.phaseIndex == phaseCycler.sunsetPhaseIndex then
    global.BZ_data.phaseTotalDuration = 10
    global.BZ_data.endBrightness = PhaseCycler.dayBrightness

  else
    game.print("BugZilla.lib.phaseCycler.lua: Unknown phase")
  end
end



function PhaseCycler.SetBrightness(_, brightness)
  --Lerp between day (0.5 = noon) and night (0.0 = midnight)
  -- game.surfaces.nauvis.daytime = Math.Lerp(0.42, 0.25, scalar)
  game.surfaces.nauvis.daytime = Math.Lerp(0.25, 0.42, brightness)
end
