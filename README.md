# fps-boot
Um script para a plataforma roblox. Ele irá deixar os jogos mais leve, para players que tem celular/pc fraco.

--[[ 
    Script de Otimização de FPS para Roblox
    - FPS Unlocker até 666 FPS (detecta função disponível)
    - Remove skybox, partículas e efeitos visuais supérfluos
    - Adiciona contador de FPS pequeno e móvel no canto inferior esquerdo
    - Seguro: não remove GUI, mapas ou partes essenciais do jogo
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

-- Remove skybox de Lighting
pcall(function()
    local Lighting = game:GetService("Lighting")
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then
            v:Destroy()
        end
    end
end)

-- Remove efeitos visuais do Lighting
pcall(function()
    local Lighting = game:GetService("Lighting")
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") or v:IsA("BlurEffect") then
            v.Enabled = false
        end
    end
end)

-- Remove partículas desnecessárias do workspace
pcall(function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        end
    end
end)

-- Otimiza materiais e texturas (não remove partes importantes)
pcall(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("MeshPart") then
            v.TextureID = ""
        end
    end
end)

-- FPS Counter pequeno, móvel e estilizado
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FPSCounterGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local fpsCounter = Instance.new("TextButton")
fpsCounter.Name = "FPSCounter"
fpsCounter.Size = UDim2.new(0, 70, 0, 24)
fpsCounter.Position = UDim2.new(0, 8, 1, -32) -- canto inferior esquerdo
fpsCounter.AnchorPoint = Vector2.new(0, 1)
fpsCounter.BackgroundTransparency = 0.3
fpsCounter.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
fpsCounter.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsCounter.TextStrokeTransparency = 0.5
fpsCounter.TextSize = 15
fpsCounter.Font = Enum.Font.SourceSansBold
fpsCounter.Text = "FPS: 0"
fpsCounter.AutoButtonColor = false
fpsCounter.Parent = gui
fpsCounter.Active = true
fpsCounter.Draggable = true -- permite arrastar

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

-- Deixa o contador menos intrusivo ao passar o mouse
fpsCounter.MouseEnter:Connect(function()
    fpsCounter.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
end)
fpsCounter.MouseLeave:Connect(function()
    fpsCounter.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
end)

print("Otimização de FPS aplicada! Skybox, partículas e efeitos visuais foram removidos. Unlocker setado para 666 FPS.")
