local ChatListener = {}
local Listener = {}

function ChatListener:Listen(player, callback)
    callback = callback or nil

    if ChatListener:CheckListen(player) == false then
        Listener[player.Name] = true 

        local Connection = nil
        Connection = player.Chatted:Connect(function(msg)
            if Listener[player.Name] then
                if callback ~= nil then
                    pcall(callback, msg, player) 
                end
            else
                if Connection ~= nil then
                    Connection:Disconnect()
                    Connection = nil
                end
            end
        end)
    end
end

function ChatListener:StopListening(player)
    if ChatListener:CheckListen(player) == true then
        Listener[player.Name] = nil
    end
end

function ChatListener:CheckListen(player)
    if Listener[player.Name] then
        return true
    end

    return false
end

return ChatListener
