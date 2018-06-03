require 'src/settings'

Debug = {}

Debug.enabled = true
Debug.version = 1

-- on load game for first time
function Debug:onInit()
  if self.enabled then
    log("Debug version "..self.version.." loaded.")
  end
end


function Debug:onPlayerCreated(playerIndex)
  if self.enabled then
    -- all research
    game.players[playerIndex].force.research_all_technologies()

    -- eternal day
    game.players[playerIndex].surface.always_day = true

    -- debug items
    local quickbar = game.players[playerIndex].get_quickbar()
    if quickbar and quickbar.valid then
      log("Debug items (part 1) given.")

      -- remove spawn items
      quickbar.remove("burner-mining-drill")
      quickbar.remove("stone-furnace")

      -- add chests
      quickbar.insert(Settings.storageItemName)
      quickbar.insert("steel-chest")

      -- add inserters
      quickbar.insert("burner-inserter")
      quickbar.insert("fast-inserter")
      quickbar.insert("stack-inserter")

      -- add wires
      quickbar.insert("red-wire")
      quickbar.insert("green-wire")

      -- inserting power items
      quickbar.insert("coal")
      quickbar.insert("substation")
      quickbar.insert("solar-panel")

    else
      log("Debug items (part 1) not given. Could not find the quickbar of player "..playerIndex..".")
    end

    local inventory = game.players[playerIndex].get_main_inventory()
    if inventory and inventory.valid then
      log("Debug items (part 2) given.")

      -- inserting power items
      inventory.insert("coal")

      -- power armor stuff
      inventory.insert("construction-robot")

    else
      log("Debug items (part 2) not given. Could not find the quickbar of player "..playerIndex..".")
    end

    local toolbar = game.players[playerIndex].get_inventory(defines.inventory.player_tools)
    if toolbar and toolbar.valid then
      log("Debug tools given.")

      -- axe
      toolbar.insert("steel-axe")

    else
      log("Debug tools not given. Could not find the toolbar of player "..playerIndex..".")
    end

    local armor = game.players[playerIndex].get_inventory(defines.inventory.player_armor)
    if armor and armor.valid then
      log("Debug armor given.")

      -- power armor
      armor.insert("power-armor-mk2")

      -- insert modules TODO
      local powerArmor = armor.equipment_owner
      if powerArmor and powerArmor.valid then
        log("now its working!")
      end


    else
      log("Debug armor not given. Could not find the armor inventory of the player")
    end
  end
end
