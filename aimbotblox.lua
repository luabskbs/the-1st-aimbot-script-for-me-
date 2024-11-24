-- Get the necessary services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera

-- Function to find the closest enemy
local function getClosestEnemy()
    local closestPlayer = nil
    local shortestDistance = math.huge -- Start with an infinitely large distance

    -- Loop through all players in the game
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            -- Calculate the distance from the local player to this player's head
            local distance = (player.Character.Head.Position - Camera.CFrame.Position).Magnitude
            
            -- Check if this player is the closest one so far
            if distance < shortestDistance then
                closestPlayer = player
                shortestDistance = distance
            end
        end
    end

    return closestPlayer
end

-- Function to lock camera on the closest enemy's head
local function lockOnEnemyHead()
    while true do
        local closestEnemy = getClosestEnemy()

        -- If there is a closest enemy, lock the camera towards their head
        if closestEnemy and closestEnemy.Character and closestEnemy.Character:FindFirstChild("Head") then
            local enemyHeadPos = closestEnemy.Character.Head.Position
            local lookAt = (enemyHeadPos - Camera.CFrame.Position).unit

            -- Adjust the camera's CFrame to face the enemy's head
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, enemyHeadPos)

            -- Small delay to update the camera orientation
            wait(0.1)
        end
        wait(0.1) -- Wait before checking for the next closest enemy
    end
end

-- Start the lock-on function
lockOnEnemyHead()