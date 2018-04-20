
-- categories
require "prototypes/categories/science-subgroup"

-- fluids
fluidPath = "prototypes/fluid/"
require(fluidPath .. "science-fluid")

-- items
itemPath = "prototypes/item/"
require(itemPath .. "empty-bottle")
require(itemPath .. "regular-science-pack")
require(itemPath .. "infused-science-pack")

-- recipes
recipePath = "prototypes/recipe/"
require(recipePath .. "empty-bottle")
require(recipePath .. "science-fluid")
require(recipePath .. "regular-science-pack")
require(recipePath .. "infused-science-pack")

-- technology
technologyPath = "prototypes/technology/"
require(technologyPath .. "science")
require(technologyPath .. "military")
require(technologyPath .. "automation")
require(technologyPath .. "power")
require(technologyPath .. "logistics")
