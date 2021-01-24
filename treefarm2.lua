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
local bonemeal_slot = 3
local dirt = 'minecraft:dirt'
local wood = 'minecraft:log'

function refuel()
  local last_selected = turtle.getSelectedSlot()
  if turtle.getItemCount(fuel_slot) == 0 then
    turtle.select(fuel_slot)
    turtle.refuel(5)
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


function find_dirt_down()
  local success, data = turtle.inspectDown()

  if success and data.name == dirt then
    return true
  end

  return false
end

function find_wood()
  local success, data = turtle.inspect()

  if success and data.name == wood then
    return true
  end

  return false
end

function find_wood_up()
  local success, data = turtle.inspectUp()

  if success and data.name == wood then
    return true
  end

  return false
end

function find_left_edge()
  print("finding left edge")

  while find_dirt() do
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
  end

  turtle.turnRight()
  turtle.forward()
  turtle.turnLeft()
end

function plant_seed()
  local last_selected = turtle.getSelectedSlot()

  turtle.up()

  if not turtle.compareTo(sapling_slot) and not find_wood() then
    turtle.select(sapling_slot)
    turtle.place()
  end

  while find_wood() == false do
    if turtle.getItemCount(bonemeal_slot) > 0 then
      turtle.select(bonemeal_slot)
      turtle.place()
    else
      break
    end
  end

  if find_wood() then
    turtle.dig()
    turtle.forward()

    while find_wood_up() == true do
      turtle.digUp()
    end

    while find_dirt_down() == false do
      turtle.down()
    end

    turtle.back()

    turtle.suck()

    turtle.down()
  end

  turtle.select(last_selected)

  turtle.down()
end

while turtle.getItemCount(sapling_slot) > 0 do
  print("looping")
  refuel()
  find_left_edge()

  while find_dirt() do

    plant_seed()

    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
  end

  os.sleep(3)
end