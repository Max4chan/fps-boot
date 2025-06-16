--[[
FPS Boost Script Roblox
Atualizado para máxima compatibilidade e desempenho.
--]]

-- FPS Unlocker universal
pcall(function()
    if setfpscap then
        setfpscap(666)
    elseif set_fps_cap then
        set_fps_cap(666)
    elseif setfps then
        setfps(666)
    end
end)

-- Remove Skybox
pcall(function()
    local lighting = game:GetService("Lighting")
    for _, v in ipairs(lighting:GetChildren()) do
        if v:IsA("Sky") then
            v:Destroy()
        end
    end
end)

-- Remove efeitos visuais do Lighting e ajusta configurações para mais leveza
pcall(function()
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.Brightness = 1
    lighting.ExposureCompensation = 0
    for _, v in ipairs(lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") or v:IsA("BlurEffect") then
            v.Enabled = false
        end
    end
end)

-- Remove partículas, trilhas, fogo, fumaça, folhas e grama do Terrain
pcall(function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        elseif obj:IsA("Explosion") then
            obj:Destroy()
        end
    end
    -- Remove folhas e grama do Terrain
    if workspace:FindFirstChildOfClass("Terrain") then
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        pcall(function() terrain.Decorations = false end)
        pcall(function() terrain.WaterWaveSize = 0 end)
        pcall(function() terrain.WaterWaveSpeed = 0 end)
        pcall(function() terrain.WaterReflectance = 0 end)
        pcall(function() terrain.WaterTransparency = 1 end)
    end
end)

-- Otimiza materiais, desativa reflexos, remove texturas e decals
pcall(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("MeshPart") then
            v.TextureID = ""
        end
    end
end)

-- Remove sons desnecessários (mantém só sons de personagem e música ambiente)
pcall(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") and not v.Name:lower():find("music") and not v.Parent:IsA("Player") then
            v:Stop()
            v.Volume = 0
        end
    end
end)

-- Remove efeitos de partículas de StarterGui e outros serviços comuns
local services = {"StarterGui", "StarterPack", "ReplicatedStorage"}
for _, service in ipairs(services) do
    pcall(function()
        local s = game:GetService(service)
        for _, v in ipairs(s:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
    end)
end

-- FPS Counter pequeno,: 0"
        fpsCounter.AutoButtonColor = false
        fpsCounter.Parent = gui
        fpsCounter.Active = true
        fpsCounter.Draggable = true

        -- Atualização do FPS
        local RunService = game:GetService("RunService")
        local lastUpdate = tick()
        local frames = 0
        local fps = 0

        RunService.RenderStepped:Connect(function()
            frames = frames + 1
            if tick() - lastUpdate >= 1 then
                fps = frames
                frames = 0
                lastUpdate = tick()
                fpsCounter.Text = "FPS: " .. tostring(fps)
            end
        end)

        fpsCounter.MouseEnter:Connect(function()
            fpsCounter.BackgroundColor3 = Color3.fromRGB(0,70,0)
        end)
        fpsCounter.MouseLeave:Connect(function()
            fpsCounter.BackgroundColor3 = Color3.fromRGB(20,20,20)
        end)
    end
end)

print("Otimização de FPS aplicada! Skybox, partículas, efeitos visuais, sons, folhas e grama foram removidos ou desativados. Unlocker setado para 666 FPS.")
