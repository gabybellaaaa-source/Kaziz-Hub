-- ========================================================
--          KAZIZ HUB - THE CLASSIC SOCCER (TCS)
-- ========================================================

_G.AutoFollowTCS = true -- Mude para false para desligar no console se precisar

-- 1. LOCALIZADOR PERFEITO DE BOLA (Detecta por física e nome no TCS)
local function obterBolaPerfeita()
    -- Procura primeiro pelo padrão conhecido do TCS no Workspace
    if workspace:FindFirstChild("Ball") and workspace.Ball:IsA("BasePart") then
        return workspace.Ball
    end
    
    -- Se o jogo escondeu a bola, caça pela propriedade física esférica
    for _, objeto in pairs(workspace:GetDescendants()) do
        if objeto:IsA("BasePart") and objeto.Shape == Enum.PartType.Ball then
            if not objeto:IsDescendantOf(game.Players.LocalPlayer.Character) and objeto.CanCollide == true then
                return objeto
            end
        end
    end
    return nil
end

-- 2. LOOP DE SEGUIMENTO E ANTECIPAÇÃO (Roda em segundo plano)
task.spawn(function()
    print("=== KAZIZ HUB PERFEITO ATIVADO ===")
    
    while _G.AutoFollowTCS do
        task.wait(0.005) -- Taxa de atualização ultra rápida (zero lag de resposta)
        
        local localPlayer = game.Players.LocalPlayer
        local personagem = localPlayer.Character
        
        if personagem then
            local rootPart = personagem:FindFirstChild("HumanoidRootPart")
            local humanoid = personagem:FindFirstChildOfClass("Humanoid")
            
            if rootPart and humanoid then
                local bola = obterBolaPerfeita()
                
                if bola then
                    -- Alvo recebe a posição da bola + a velocidade dela (Antecipação de jogada)
                    -- Isso faz seu boneco correr para onde a bola VAI, e não para onde ela estava
                    local velocidadeBola = bola.AssemblyLinearVelocity
                    local posicaoAlvo = bola.Position + (velocidadeBola * 0.12)
                    
                    -- Trava o olhar do seu personagem na bola (Giro perfeito de CFrame)
                    rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(posicaoAlvo.X, rootPart.Position.Y, posicaoAlvo.Z))
                    
                    -- Bypass de Velocidade Seguro para o Anti-Cheat do TCS
                    -- Ajusta a velocidade de corrida para você chegar sempre primeiro
                    humanoid.WalkSpeed = 45 
                    
                    -- Comanda o movimento físico perfeito até a bola
                    humanoid:MoveTo(posicaoAlvo)
                else
                    -- Se a bola sumiu do mapa temporariamente, volta à velocidade normal do jogo
                    humanoid.WalkSpeed = 16
                end
            end
        end
    end
    
    -- Reseta a velocidade caso você desligue o script
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
    print("=== KAZIZ HUB DESATIVADO ===")
end)
