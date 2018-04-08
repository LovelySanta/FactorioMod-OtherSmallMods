This mod adds forcefields to the game: electric powered, self healing walls. Make no mistakes, the force fields are powerful but power hungry - don't let them run out of energy or it all comes crumbling down.
Mod original from [RSeding91](https://mods.factorio.com/user/Rseding91), but discontinued afther 0.14, taken over by me.

![Example forcefield](https://raw.githubusercontent.com/LovelySanta/FactorioMods/master/ForceFields2/graphics/screenshots/preview.png)

# Features
+ Different types of energy powered 'walls' (AKA forcefields)
+ The fields will auto-heal if there's energy to do so.
+ If the emitter runs out of energy to do needed work, all of the fields for that emitter collapse
+ Different types of fields (unlocked with research), fully customizable, have different effects/tradeoffs
    + Blue: normal health, normal re-spawn, normal power usage
    + Green: higher health, very slow re-spawn, below-normal power usage
    + Red: normal health, slow re-spawn, very high power usage. Damages living things that directly attack them
    + Purple: low health, very slow re-spawn, high power usage. On death, heavily damages living things near-by
+ Heavily optimized - you can go crazy with the force fields and they shouldn't impact your game's performance much/at all

# Explanation
## 1 Emitter configuration
Afther placing down an emitter you can click on it to open the configuration GUI (just like opening an assembler to set the recipe). In the GUI you can select the direction of the forcefield in relation to the emitter. You can choose the type of forcefield (it will prompt a message if you don't have it researched).

For ease of use you can set the distance and the width of the forcefield. These can be upgraded by inserting respectivly advanced and/or processing units. (Left click the inventory with an upgrade will insert one and right clicking will remove one. At the bottom is a button to remove them all at once.

When pressing apply, the emitter will draw more energy and will start build the forcefield you requested.
*NOTE*: When building an emitter for the first time, it won't build a wall until you configure it.

![Emitter configuration](https://raw.githubusercontent.com/LovelySanta/FactorioMods/master/ForceFields2/graphics/screenshots/emitter_configuration_gui.png)

## 2 Forcefield configuration
At the bottom of the GUI is another button with some gears (next to the apply button). When pressing that, it will open a new configuration window that will let you select the configuration of the forcefield. The amount of buttons will depend on the number you've set as the width of the emitter.

In this window you can select for each individual wall section if you want there to be a wall build, a gate or leave it empty. This ensures the full customability of your wall. For the ease of use there are some extra buttons at the left to configure the whole forcefield all at once.
*NOTE*: afther saving the configuration, don't forget to press apply in the emiter GUI to make your settings active.

![Forcefield configuration](https://raw.githubusercontent.com/LovelySanta/FactorioMods/master/ForceFields2/graphics/screenshots/forcefield_configuration_gui.png)

## 3 Quick configuring
If you have long walls, I wouldn't want you to have to do tremendous amounts of repetitive work. You can copy paste settings from one emitter to the other (just like you can copy paste the recipe on assemblers). This will also insert the necessary amount of upgrades into it, if you have them in your inventory.

When an emitter gets destroyed, the forcefield will degrade and it will leave a ghosting mark (if robots are researched) just like any other item. When a bot comes and place a new emitter, or you manualy replace the emitter, it will take over the old settings it had before and will start building the forcefield again.
*NOTE*: You don't have to be in time to replace the emitter to restore the old settings. Even afther that the ghost disappeared you will still get the older settings.Nonetheless you can change these at any time.
*NOTE*: There is no blueprint support (yet). When blueprinting emitters it will act the same as placing a new emitter (or replacing one that is destroyed).

# Changelog
### Future
+ Tooltips when hovering over the buttons
+ New help '?' screen
### Latest release
+ See ingame changelog or find it [here on github](https://github.com/LovelySanta/FactorioMods/blob/master/ForceFields2/changelog.txt).
