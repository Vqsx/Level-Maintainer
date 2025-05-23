local ae2 = require("AE2")
local serialization = require("serialization")
 
local cfg = {}
local sleepInterval = 300 --Seconds

local function load()
    local file = io.open("/home/MaintainerList", "r")
    if file then
        cfg["items"] = serialization.unserialize(file:read("*a")) or {}
        file:close()
    end
end

load()

while true do
  local itemsCrafting = ae2.checkIfCrafting()
  for item, config in pairs(cfg.items) do
    if itemsCrafting[item] == nil then
      ae2.requestItem(item, config[1], config[2])
    end 
  end
  os.sleep(sleepInterval)
end