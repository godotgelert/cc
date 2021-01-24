-- Tree Farmer 1.0


-- 1.0 - Refueling

-- 2.0 - Finding the edge of the farm

-- 3.0 - Detecting Seedlings

-- 4.0 - Planting Seedling

-- 4.5 - Using bonemeal

-- 5.0 - Detecting Tree

-- 6.0 - Mining Tree

local fuel_slot = 1
local sapling_slot = 2
local dirt = 'minecraft:dirt'
local wood = 'minecraft:wood'

function refuel()
  local last_selected = turtle.getSelectedSlot()
  if turtle.getItemCount(fuel_slot) == 0 then
    turtle.select(fuel_slot)
    turtle.refuel()
    turtle.select(last_selected)
  end
end

function find_dirt()
  local success, data = turtle.inspect()

  if success and data.name == dirt then
    return true
  end

  return false
end

function find_edge()
  -- am I looking at dirt?

  local found_dirt = false

  if find_dirt() then
    
  end
end