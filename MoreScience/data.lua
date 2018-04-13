
-- categories
require "prototypes/categories/science-subgroups"

-- fluids
fluidPath = "prototypes/fluid/"
require(fluidPath .. "regular-science-fluid")
require(fluidPath .. "extra-science-fluid")

-- items
itemPath = "prototypes/item/"
require(itemPath .. "empty-bottle")
require(itemPath .. "regular-science-pack")
require(itemPath .. "extra-science-pack")

-- recipes
recipePath = "prototypes/recipe/"
require(recipePath .. "empty-bottle")
require(recipePath .. "science-fluid")
require(recipePath .. "science-pack")

-- technology
technologyPath = "prototypes/technology/"
require(technologyPath .. "science")
require(technologyPath .. "automation")
require(technologyPath .. "logistics")
require(technologyPath .. "military")
