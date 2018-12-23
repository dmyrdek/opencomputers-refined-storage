local component = require("component")
local shell = require("shell")
local sides = require("sides")

local rs = component.block_refinedstorage_interface
local chestside = sides.up
local noMatch = true
 
local args, opts = shell.parse(...)

local shell = require("shell")
local args, opts = shell.parse(...)

local searchedFor
local amount

function split(s, sep)
    local fields = {}

    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

    return fields
end

t = split(table.concat(args," "),"-")
for i,j in pairs(t) do
    if i == 1 then
        searchedFor = j
        searchedFor = searchedFor:sub(1,-2)
    end
    if i == 2 then
        amount = j
        amount = amount:gsub("%s+", "")
    end
end

if args[1] then

    if args[2] then
        
        for i,stack in ipairs(rs.getItems()) do
            if string.lower(stack.label) == string.lower(searchedFor) then
                rs.extractItem(stack, tonumber(amount), chestside)
                noMatch = false
                break
            end
        end

        if noMatch then
            print(searchedFor .. " was not found.")
        end

    else
        print("Please specify the exact amount of " .. searchedFor .. " you want.")
    end
else
    print("Please specify the item you want followed by the amount.")
end
