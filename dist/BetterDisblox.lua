type Disconnectable__DARKLUA_TYPE_a={
Disconnect:(self:Disconnectable__DARKLUA_TYPE_a)->(),
}

type EventEmitter__DARKLUA_TYPE_b={
On:(self:EventEmitter__DARKLUA_TYPE_b,eventName:string,callback:(...any)->())->Disconnectable__DARKLUA_TYPE_a,
Once:(self:EventEmitter__DARKLUA_TYPE_b,eventName:string,callback:(...any)->())->Disconnectable__DARKLUA_TYPE_a,
Emit:(self:EventEmitter__DARKLUA_TYPE_b,eventName:string,...any)->(),
RemoveAllListeners:(self:EventEmitter__DARKLUA_TYPE_b,eventName:string)->(),
}

type Listener__DARKLUA_TYPE_c={
callback:(...any)->(),
once:boolean,
}

type EventEmitterState__DARKLUA_TYPE_d={
listeners:{[string]:{Listener__DARKLUA_TYPE_c}},
}

type Json__DARKLUA_TYPE_e={
Encode:(value:any)->string,
Decode:(value:string)->any,
}

type GatewaySession__DARKLUA_TYPE_f={
sessionId:string?,
sequence:number?,
resumeGatewayUrl:string?,
}

type SessionStore__DARKLUA_TYPE_g={
Load:(self:SessionStore__DARKLUA_TYPE_g)->GatewaySession__DARKLUA_TYPE_f?,
Save:(self:SessionStore__DARKLUA_TYPE_g,session:GatewaySession__DARKLUA_TYPE_f)->(),
Clear:(self:SessionStore__DARKLUA_TYPE_g)->(),
}

type GatewayClientOptions__DARKLUA_TYPE_h={
Token:string,
Intents:number,
Url:string?,
AutoReconnect:boolean?,
ReconnectDelay:number?,
MaxReconnectAttempts:number?,
SessionPersistence:boolean?,
SessionFolder:string?,
SessionFileName:string?,
}

type GatewayClient__DARKLUA_TYPE_i={
On:(self:GatewayClient__DARKLUA_TYPE_i,eventName:string,callback:(...any)->())->any,
Once:(self:GatewayClient__DARKLUA_TYPE_i,eventName:string,callback:(...any)->())->any,
Connect:(self:GatewayClient__DARKLUA_TYPE_i)->(),
Disconnect:(self:GatewayClient__DARKLUA_TYPE_i)->(),
Send:(self:GatewayClient__DARKLUA_TYPE_i,payload:any)->(),
SetPresence:(self:GatewayClient__DARKLUA_TYPE_i,presence:any)->(),
}

type Interaction__DARKLUA_TYPE_j={
Id:string,
Token:string,
ApplicationId:string,
Type:number,
Data:any,
CommandName:string?,
Options:{any},
Raw:any,
Reply:(self:Interaction__DARKLUA_TYPE_j,payload:any)->any,
ReplyEphemeral:(self:Interaction__DARKLUA_TYPE_j,payload:any)->any,
DeferReply:(self:Interaction__DARKLUA_TYPE_j,ephemeral:boolean)->any,
EditReply:(self:Interaction__DARKLUA_TYPE_j,payload:any)->any,
DeleteReply:(self:Interaction__DARKLUA_TYPE_j)->any,
FollowUp:(self:Interaction__DARKLUA_TYPE_j,payload:any)->any,
GetOption:(self:Interaction__DARKLUA_TYPE_j,name:string)->any,
GetString:(self:Interaction__DARKLUA_TYPE_j,name:string)->string?,
GetInteger:(self:Interaction__DARKLUA_TYPE_j,name:string)->number?,
GetBoolean:(self:Interaction__DARKLUA_TYPE_j,name:string)->boolean?,
}

type Message__DARKLUA_TYPE_k={
Id:string,
ChannelId:string,
GuildId:string?,
Content:string,
Author:any,
Raw:any,
Reply:(self:Message__DARKLUA_TYPE_k,payload:any)->any,
Edit:(self:Message__DARKLUA_TYPE_k,payload:any)->any,
Delete:(self:Message__DARKLUA_TYPE_k)->any,
}

type RequestOptions__DARKLUA_TYPE_l={
Url:string,
Method:string,
Headers:{[string]:string},
Body:string?,
}

type HttpResponse__DARKLUA_TYPE_m={
StatusCode:number,
Body:string,
Headers:{[string]:string},
}

type RateLimitState__DARKLUA_TYPE_n={
unlockedAt:number,
}

type RateLimiter__DARKLUA_TYPE_o={
Wait:(self:RateLimiter__DARKLUA_TYPE_o,routeKey:string)->(),
Update:(self:RateLimiter__DARKLUA_TYPE_o,routeKey:string,statusCode:number,headers:{[string]:string},body:string)->(),
}

type RestClientOptions__DARKLUA_TYPE_p={
Token:string,
BaseUrl:string?,
}

type RestClient__DARKLUA_TYPE_q={
Request:(self:RestClient__DARKLUA_TYPE_q,method:string,route:string,body:any)->any,
CreateMessage:(self:RestClient__DARKLUA_TYPE_q,channelId:string,payload:any)->any,
EditMessage:(self:RestClient__DARKLUA_TYPE_q,channelId:string,messageId:string,payload:any)->any,
DeleteMessage:(self:RestClient__DARKLUA_TYPE_q,channelId:string,messageId:string)->any,
CreateGlobalApplicationCommand:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,payload:any)->any,
BulkOverwriteGlobalApplicationCommands:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,payload:{any})->any,
CreateGuildApplicationCommand:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,guildId:string,payload:any)->any,
BulkOverwriteGuildApplicationCommands:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,guildId:string,payload:{any})->any,
CreateInteractionResponse:(self:RestClient__DARKLUA_TYPE_q,interactionId:string,interactionToken:string,payload:any)->any,
EditOriginalInteractionResponse:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,interactionToken:string,payload:any)->any,
DeleteOriginalInteractionResponse:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,interactionToken:string)->any,
CreateFollowupMessage:(self:RestClient__DARKLUA_TYPE_q,applicationId:string,interactionToken:string,payload:any)->any,
}

type ClientOptions__DARKLUA_TYPE_r={
Token:string,
Intents:number,
GatewayUrl:string?,
RestBaseUrl:string?,
AutoReconnect:boolean?,
ReconnectDelay:number?,
MaxReconnectAttempts:number?,
SessionPersistence:boolean?,
SessionFolder:string?,
SessionFileName:string?,
}

type Client__DARKLUA_TYPE_s={
Rest:any,
On:(self:Client__DARKLUA_TYPE_s,eventName:string,callback:(...any)->())->any,
Once:(self:Client__DARKLUA_TYPE_s,eventName:string,callback:(...any)->())->any,
Login:(self:Client__DARKLUA_TYPE_s)->(),
Destroy:(self:Client__DARKLUA_TYPE_s)->(),
SetPresence:(self:Client__DARKLUA_TYPE_s,presence:any)->(),
}

type EmbedBuilder__DARKLUA_TYPE_t={
SetTitle:(self:EmbedBuilder__DARKLUA_TYPE_t,title:string)->EmbedBuilder__DARKLUA_TYPE_t,
SetDescription:(self:EmbedBuilder__DARKLUA_TYPE_t,description:string)->EmbedBuilder__DARKLUA_TYPE_t,
SetColor:(self:EmbedBuilder__DARKLUA_TYPE_t,color:number)->EmbedBuilder__DARKLUA_TYPE_t,
SetUrl:(self:EmbedBuilder__DARKLUA_TYPE_t,url:string)->EmbedBuilder__DARKLUA_TYPE_t,
SetTimestamp:(self:EmbedBuilder__DARKLUA_TYPE_t,timestamp:string)->EmbedBuilder__DARKLUA_TYPE_t,
AddField:(self:EmbedBuilder__DARKLUA_TYPE_t,name:string,value:string,inline:boolean)->EmbedBuilder__DARKLUA_TYPE_t,
Build:(self:EmbedBuilder__DARKLUA_TYPE_t)->{[string]:any},
}

type SlashCommandOption__DARKLUA_TYPE_u={
type:number,
name:string,
description:string,
required:boolean?,
choices:{any}?,
options:{SlashCommandOption__DARKLUA_TYPE_u}?,
}

type SlashCommandBuilder__DARKLUA_TYPE_v={
SetName:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string)->SlashCommandBuilder__DARKLUA_TYPE_v,
SetDescription:(self:SlashCommandBuilder__DARKLUA_TYPE_v,description:string)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddStringOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddIntegerOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddBooleanOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddUserOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddChannelOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
AddRoleOption:(self:SlashCommandBuilder__DARKLUA_TYPE_v,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_v,
Build:(self:SlashCommandBuilder__DARKLUA_TYPE_v)->{[string]:any},
}local __DARKLUA_BUNDLE_MODULES={cache={}::any}do do local function __modImpl()























local EventEmitter={}
EventEmitter.__index=EventEmitter

function EventEmitter.new():EventEmitter__DARKLUA_TYPE_b
local self:EventEmitterState__DARKLUA_TYPE_d={
listeners={},
}

return(setmetatable(self,EventEmitter)::any)::EventEmitter__DARKLUA_TYPE_b
end

function EventEmitter:On(eventName:string,callback:(...any)->()):Disconnectable__DARKLUA_TYPE_a
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

if type(callback)~="function"then
error("callback must be a function",2)
end

local state=self::any
local listener:Listener__DARKLUA_TYPE_c={
callback=callback,
once=false,
}

local eventListeners=state.listeners[eventName]
if eventListeners==nil then
eventListeners={}
state.listeners[eventName]=eventListeners
end

table.insert(eventListeners,listener)

local disconnected=false
local disconnectable={}

function disconnectable:Disconnect()
if disconnected then
return
end

disconnected=true
local currentListeners=state.listeners[eventName]
if currentListeners==nil then
return
end

local nextListeners:{Listener__DARKLUA_TYPE_c}={}
for _,currentListener in ipairs(currentListeners)do
if currentListener~=listener then
table.insert(nextListeners,currentListener)
end
end

state.listeners[eventName]=nextListeners
end

return disconnectable::Disconnectable__DARKLUA_TYPE_a
end

function EventEmitter:Once(eventName:string,callback:(...any)->()):Disconnectable__DARKLUA_TYPE_a
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

if type(callback)~="function"then
error("callback must be a function",2)
end

local state=self::any
local listener:Listener__DARKLUA_TYPE_c={
callback=callback,
once=true,
}

local eventListeners=state.listeners[eventName]
if eventListeners==nil then
eventListeners={}
state.listeners[eventName]=eventListeners
end

table.insert(eventListeners,listener)

local disconnected=false
local disconnectable={}

function disconnectable:Disconnect()
if disconnected then
return
end

disconnected=true
local currentListeners=state.listeners[eventName]
if currentListeners==nil then
return
end

local nextListeners:{Listener__DARKLUA_TYPE_c}={}
for _,currentListener in ipairs(currentListeners)do
if currentListener~=listener then
table.insert(nextListeners,currentListener)
end
end

state.listeners[eventName]=nextListeners
end

return disconnectable::Disconnectable__DARKLUA_TYPE_a
end

function EventEmitter:Emit(eventName:string,...:any):()
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

local state=self::any
local eventListeners=state.listeners[eventName]
if eventListeners==nil then
return
end

local arguments=table.pack(...)
local nextListeners:{Listener__DARKLUA_TYPE_c}={}

for _,listener in ipairs(eventListeners)do
task.spawn(function()
listener.callback(table.unpack(arguments,1,arguments.n))
end)

if not listener.once then
table.insert(nextListeners,listener)
end
end

state.listeners[eventName]=nextListeners
end

function EventEmitter:RemoveAllListeners(eventName:string):()
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

local state=self::any
state.listeners[eventName]={}
end

return EventEmitter end function __DARKLUA_BUNDLE_MODULES.a():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.a if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.a=v end return v.c end end do local function __modImpl()



return{
DISPATCH=0,
HEARTBEAT=1,
IDENTIFY=2,
PRESENCE_UPDATE=3,
VOICE_STATE_UPDATE=4,
RESUME=6,
RECONNECT=7,
REQUEST_GUILD_MEMBERS=8,
INVALID_SESSION=9,
HELLO=10,
HEARTBEAT_ACK=11,
}end function __DARKLUA_BUNDLE_MODULES.b():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.b if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.b=v end return v.c end end do local function __modImpl()








local Json={}

local function getHttpService():HttpService
return game:GetService("HttpService")
end

function Json.Encode(value:any):string
local success,result=pcall(function()
return getHttpService():JSONEncode(value)
end)

if not success then
error("Failed to encode JSON: "..tostring(result),2)
end

return result
end

function Json.Decode(value:string):any
if type(value)~="string"then
error("JSON value must be a string",2)
end

local success,result=pcall(function()
return getHttpService():JSONDecode(value)
end)

if not success then
error("Failed to decode JSON: "..tostring(result),2)
end

return result
end

return Json end function __DARKLUA_BUNDLE_MODULES.c():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end do local function __modImpl()



local Json=__DARKLUA_BUNDLE_MODULES.c()













local SessionStore={}
SessionStore.__index=SessionStore

local DEFAULT_FOLDER="BetterDisblox"
local DEFAULT_FILE_NAME="session.json"

local function getFilePath(folder:string,fileName:string):string
return folder.."/"..fileName
end

local function assertFilesystemAvailable():()
if type(isfile)~="function"then
error("UNC isfile function is unavailable",3)
end

if type(readfile)~="function"then
error("UNC readfile function is unavailable",3)
end

if type(writefile)~="function"then
error("UNC writefile function is unavailable",3)
end

if type(isfolder)~="function"then
error("UNC isfolder function is unavailable",3)
end

if type(makefolder)~="function"then
error("UNC makefolder function is unavailable",3)
end
end

function SessionStore.new(folder:string?,fileName:string?):SessionStore__DARKLUA_TYPE_g
local resolvedFolder=folder
if resolvedFolder==nil then
resolvedFolder=DEFAULT_FOLDER
end

local resolvedFileName=fileName
if resolvedFileName==nil then
resolvedFileName=DEFAULT_FILE_NAME
end

local self={
folder=resolvedFolder,
fileName=resolvedFileName,
filePath=getFilePath(resolvedFolder,resolvedFileName),
}

return(setmetatable(self,SessionStore)::any)::SessionStore__DARKLUA_TYPE_g
end

function SessionStore:Load():GatewaySession__DARKLUA_TYPE_f?
assertFilesystemAvailable()

local state=self::any
if not isfile(state.filePath)then
return nil
end

local decoded=Json.Decode(readfile(state.filePath))
if type(decoded)~="table"then
error("Saved BetterDisblox session file did not contain a JSON object",2)
end

return{
sessionId=decoded.sessionId,
sequence=decoded.sequence,
resumeGatewayUrl=decoded.resumeGatewayUrl,
}
end

function SessionStore:Save(session:GatewaySession__DARKLUA_TYPE_f):()
assertFilesystemAvailable()

local state=self::any
if not isfolder(state.folder)then
makefolder(state.folder)
end

writefile(state.filePath,Json.Encode({
sessionId=session.sessionId,
sequence=session.sequence,
resumeGatewayUrl=session.resumeGatewayUrl,
}))
end

function SessionStore:Clear():()
assertFilesystemAvailable()

local state=self::any
if type(delfile)~="function"then
error("UNC delfile function is unavailable",2)
end

if isfile(state.filePath)then
delfile(state.filePath)
end
end

return SessionStore end function __DARKLUA_BUNDLE_MODULES.d():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function __modImpl()



local EventEmitter=__DARKLUA_BUNDLE_MODULES.a()
local GatewayOpcode=__DARKLUA_BUNDLE_MODULES.b()
local Json=__DARKLUA_BUNDLE_MODULES.c()
local SessionStore=__DARKLUA_BUNDLE_MODULES.d()






















local GatewayClient={}
GatewayClient.__index=GatewayClient

local DEFAULT_GATEWAY_URL="wss://gateway.discord.gg/?v=10&encoding=json"
local DEFAULT_RECONNECT_DELAY=5
local DEFAULT_MAX_RECONNECT_ATTEMPTS=0

local function getWebSocketConnect():(string)->any
local websocketTable=WebSocket or websocket
if type(websocketTable)~="table"or type(websocketTable.connect)~="function"then
error("UNC WebSocket.connect is unavailable. This executor must support WebSocket.connect(url).",2)
end

return websocketTable.connect
end

local function connectSignal(signal:any,callback:(...any)->()):()
if type(signal)=="table"or type(signal)=="userdata"then
if type(signal.Connect)=="function"then
signal:Connect(callback)
return
end
end

if type(signal)=="function"then
signal(callback)
return
end

error("Unsupported WebSocket signal shape",3)
end

function GatewayClient.new(options:GatewayClientOptions__DARKLUA_TYPE_h):GatewayClient__DARKLUA_TYPE_i
if type(options.Token)~="string"or options.Token==""then
error("Discord bot token must be a non-empty string",2)
end

if type(options.Intents)~="number"then
error("Gateway intents must be a number",2)
end

local url=options.Url
if url==nil then
url=DEFAULT_GATEWAY_URL
end

local autoReconnect=options.AutoReconnect
if autoReconnect==nil then
autoReconnect=true
end

local reconnectDelay=options.ReconnectDelay
if reconnectDelay==nil then
reconnectDelay=DEFAULT_RECONNECT_DELAY
end

local maxReconnectAttempts=options.MaxReconnectAttempts
if maxReconnectAttempts==nil then
maxReconnectAttempts=DEFAULT_MAX_RECONNECT_ATTEMPTS
end

local self={
token=options.Token,
intents=options.Intents,
url=url,
socket=nil::any,
sequence=nil::number?,
sessionId=nil::string?,
resumeGatewayUrl=nil::string?,
heartbeatInterval=nil::number?,
heartbeatThread=nil::thread?,
lastHeartbeatAck=true,
emitter=EventEmitter.new(),
closed=false,
autoReconnect=autoReconnect,
reconnectDelay=reconnectDelay,
maxReconnectAttempts=maxReconnectAttempts,
reconnectAttempts=0,
sessionPersistence=options.SessionPersistence==true,
sessionStore=SessionStore.new(options.SessionFolder,options.SessionFileName),
resumeRequested=false,
}

return(setmetatable(self,GatewayClient)::any)::GatewayClient__DARKLUA_TYPE_i
end

function GatewayClient:On(eventName:string,callback:(...any)->()):any
return(self::any).emitter:On(eventName,callback)
end

function GatewayClient:Once(eventName:string,callback:(...any)->()):any
return(self::any).emitter:Once(eventName,callback)
end

function GatewayClient:Send(payload:any):()
local state=self::any
if state.socket==nil then
error("Cannot send Gateway payload before connecting",2)
end

local encoded=Json.Encode(payload)
state.socket:Send(encoded)
end

function GatewayClient:SetPresence(presence:any):()
self:Send({
op=GatewayOpcode.PRESENCE_UPDATE,
d=presence,
})
end

function GatewayClient:Disconnect():()
local state=self::any
state.closed=true

if state.socket~=nil then
state.socket:Close()
end

state.socket=nil
end

local function saveSession(self:any):()
if not self.sessionPersistence then
return
end

if not self.sessionId or not self.resumeGatewayUrl then
return
end

self.sessionStore:Save({
sessionId=self.sessionId,
sequence=self.sequence,
resumeGatewayUrl=self.resumeGatewayUrl,
})
end

local function loadSession(self:any):()
if not self.sessionPersistence then
return
end

local session=self.sessionStore:Load()
if session==nil then
return
end

self.sessionId=session.sessionId
self.sequence=session.sequence
self.resumeGatewayUrl=session.resumeGatewayUrl
end

local function clearSession(self:any):()
self.sessionId=nil
self.sequence=nil
self.resumeGatewayUrl=nil

if self.sessionPersistence then
self.sessionStore:Clear()
end
end

local function startHeartbeat(self:any,intervalMilliseconds:number):()
self.heartbeatInterval=intervalMilliseconds/1000
self.lastHeartbeatAck=true

self.heartbeatThread=task.spawn(function()
while not self.closed and self.socket~=nil do
task.wait(self.heartbeatInterval)

if not self.lastHeartbeatAck then
self.emitter:Emit("ERROR","Discord Gateway heartbeat ACK was not received before the next heartbeat")
self.socket:Close()
return
end

self.lastHeartbeatAck=false
self:Send({
op=GatewayOpcode.HEARTBEAT,
d=self.sequence,
})
end
end)
end

local function identify(self:any):()
self:Send({
op=GatewayOpcode.IDENTIFY,
d={
token=self.token,
intents=self.intents,
properties={
os="roblox",
browser="DiscordExecutorLuau",
device="DiscordExecutorLuau",
},
},
})
end

local function canResume(self:any):boolean
return type(self.sessionId)=="string"and self.sessionId~=""and type(self.sequence)=="number"
end

local function resume(self:any):()
self.resumeRequested=true
self:Send({
op=GatewayOpcode.RESUME,
d={
token=self.token,
session_id=self.sessionId,
seq=self.sequence,
},
})
end

local function handleDispatch(self:any,eventName:string,data:any,sequence:number?):()
self.sequence=sequence

if eventName=="READY"and type(data)=="table"then
self.sessionId=data.session_id
self.resumeGatewayUrl=data.resume_gateway_url
self.reconnectAttempts=0
self.resumeRequested=false
saveSession(self)
end

if eventName=="RESUMED"then
self.reconnectAttempts=0
self.resumeRequested=false
saveSession(self)
end

self.emitter:Emit(eventName,data)
end

local function handlePayload(self:any,payload:any):()
if type(payload.s)=="number"then
self.sequence=payload.s
end

if payload.op==GatewayOpcode.HELLO then
startHeartbeat(self,payload.d.heartbeat_interval)
if canResume(self)then
resume(self)
else
identify(self)
end
return
end

if payload.op==GatewayOpcode.DISPATCH then
handleDispatch(self,payload.t,payload.d,payload.s)
return
end

if payload.op==GatewayOpcode.HEARTBEAT_ACK then
self.lastHeartbeatAck=true
return
end

if payload.op==GatewayOpcode.RECONNECT then
self.emitter:Emit("RECONNECT",payload.d)
self.socket:Close()
return
end

if payload.op==GatewayOpcode.INVALID_SESSION then
clearSession(self)
self.resumeRequested=false
self.emitter:Emit("INVALID_SESSION",payload.d)
task.wait(1)
identify(self)
end
end

local function bindSocket(self:any):()
connectSignal(self.socket.OnMessage,function(message:string)
local decoded=Json.Decode(message)
handlePayload(self,decoded)
end)

connectSignal(self.socket.OnClose,function()
self.socket=nil
self.emitter:Emit("CLOSE")

if self.closed or not self.autoReconnect then
return
end

if self.maxReconnectAttempts>0 and self.reconnectAttempts>=self.maxReconnectAttempts then
self.emitter:Emit("ERROR","Discord Gateway reconnect limit reached")
return
end

self.reconnectAttempts+=1
self.emitter:Emit("RECONNECTING",{
attempt=self.reconnectAttempts,
delay=self.reconnectDelay,
canResume=canResume(self),
})

task.wait(self.reconnectDelay)
self:Connect()
end)
end

function GatewayClient:Connect():()
local state=self::any
if state.socket~=nil then
error("Gateway client is already connected or connecting",2)
end

if state.sessionPersistence and state.sessionId==nil then
loadSession(state)
end

state.closed=false
local gatewayUrl=state.url
if canResume(state)and type(state.resumeGatewayUrl)=="string"and state.resumeGatewayUrl~=""then
gatewayUrl=state.resumeGatewayUrl.."?v=10&encoding=json"
end

state.socket=getWebSocketConnect()(gatewayUrl)
bindSocket(state)
end

return GatewayClient end function __DARKLUA_BUNDLE_MODULES.e():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end do local function __modImpl()



local Payload={}

function Payload.Message(value:any):any
if type(value)=="string"then
return{
content=value,
}
end

if type(value)~="table"then
error("message payload must be a string or table",3)
end

return value
end

function Payload.InteractionResponse(value:any):any
local messagePayload=Payload.Message(value)

return{
type=4,
data=messagePayload,
}
end

function Payload.DeferredInteractionResponse(ephemeral:boolean):any
local data=nil

if ephemeral then
data={
flags=64,
}
end

return{
type=5,
data=data,
}
end

function Payload.EphemeralMessage(value:any):any
local messagePayload=Payload.Message(value)
messagePayload.flags=64
return messagePayload
end

return Payload end function __DARKLUA_BUNDLE_MODULES.f():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end do local function __modImpl()



local Payload=__DARKLUA_BUNDLE_MODULES.f()






















local Interaction={}
Interaction.__index=Interaction

local function getOptions(rawInteraction:any):{any}
if type(rawInteraction.data)~="table"or type(rawInteraction.data.options)~="table"then
return{}
end

return rawInteraction.data.options
end

function Interaction.new(rawInteraction:any,restClient:any):Interaction__DARKLUA_TYPE_j
if type(rawInteraction)~="table"then
error("rawInteraction must be a table",2)
end

if type(restClient)~="table"then
error("restClient must be a table",2)
end

local commandName=nil
if type(rawInteraction.data)=="table"then
commandName=rawInteraction.data.name
end

local self={
Id=rawInteraction.id,
Token=rawInteraction.token,
ApplicationId=rawInteraction.application_id,
Type=rawInteraction.type,
Data=rawInteraction.data,
CommandName=commandName,
Options=getOptions(rawInteraction),
Raw=rawInteraction,
restClient=restClient,
}

return(setmetatable(self,Interaction)::any)::Interaction__DARKLUA_TYPE_j
end

function Interaction:Reply(payload:any):any
local state=self::any
return state.restClient:CreateInteractionResponse(
state.Id,
state.Token,
Payload.InteractionResponse(payload)
)
end

function Interaction:ReplyEphemeral(payload:any):any
local state=self::any
return state.restClient:CreateInteractionResponse(
state.Id,
state.Token,
Payload.InteractionResponse(Payload.EphemeralMessage(payload))
)
end

function Interaction:DeferReply(ephemeral:boolean):any
local state=self::any
return state.restClient:CreateInteractionResponse(
state.Id,
state.Token,
Payload.DeferredInteractionResponse(ephemeral)
)
end

function Interaction:EditReply(payload:any):any
local state=self::any
return state.restClient:EditOriginalInteractionResponse(
state.ApplicationId,
state.Token,
Payload.Message(payload)
)
end

function Interaction:DeleteReply():any
local state=self::any
return state.restClient:DeleteOriginalInteractionResponse(state.ApplicationId,state.Token)
end

function Interaction:FollowUp(payload:any):any
local state=self::any
return state.restClient:CreateFollowupMessage(
state.ApplicationId,
state.Token,
Payload.Message(payload)
)
end

function Interaction:GetOption(name:string):any
if type(name)~="string"or name==""then
error("option name must be a non-empty string",2)
end

for _,option in ipairs((self::any).Options)do
if option.name==name then
return option
end
end

return nil
end

function Interaction:GetString(name:string):string?
local option=self:GetOption(name)
if option==nil then
return nil
end

return option.value
end

function Interaction:GetInteger(name:string):number?
local option=self:GetOption(name)
if option==nil then
return nil
end

return option.value
end

function Interaction:GetBoolean(name:string):boolean?
local option=self:GetOption(name)
if option==nil then
return nil
end

return option.value
end

return Interaction end function __DARKLUA_BUNDLE_MODULES.g():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.g if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.g=v end return v.c end end do local function __modImpl()



local Payload=__DARKLUA_BUNDLE_MODULES.f()













local Message={}
Message.__index=Message

function Message.new(rawMessage:any,restClient:any):Message__DARKLUA_TYPE_k
if type(rawMessage)~="table"then
error("rawMessage must be a table",2)
end

if type(restClient)~="table"then
error("restClient must be a table",2)
end

local self={
Id=rawMessage.id,
ChannelId=rawMessage.channel_id,
GuildId=rawMessage.guild_id,
Content=rawMessage.content or"",
Author=rawMessage.author,
Raw=rawMessage,
restClient=restClient,
}

return(setmetatable(self,Message)::any)::Message__DARKLUA_TYPE_k
end

function Message:Reply(payload:any):any
local state=self::any
return state.restClient:CreateMessage(state.ChannelId,Payload.Message(payload))
end

function Message:Edit(payload:any):any
local state=self::any
return state.restClient:EditMessage(state.ChannelId,state.Id,Payload.Message(payload))
end

function Message:Delete():any
local state=self::any
return state.restClient:DeleteMessage(state.ChannelId,state.Id)
end

return Message end function __DARKLUA_BUNDLE_MODULES.h():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.h if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.h=v end return v.c end end do local function __modImpl()



local Json=__DARKLUA_BUNDLE_MODULES.c()














local Http={}

local function getRequestFunction():(RequestOptions__DARKLUA_TYPE_l)->HttpResponse__DARKLUA_TYPE_m
local requestFunction=(getgenv and getgenv().request)or request or http_request or(http and http.request)

if type(requestFunction)~="function"then
error("UNC request function is unavailable. This executor must support request(options).",2)
end

return requestFunction
end

function Http.Request(options:RequestOptions__DARKLUA_TYPE_l):HttpResponse__DARKLUA_TYPE_m
if type(options.Url)~="string"or options.Url==""then
error("Request Url must be a non-empty string",2)
end

if type(options.Method)~="string"or options.Method==""then
error("Request Method must be a non-empty string",2)
end

local response=getRequestFunction()(options)

if type(response)~="table"then
error("request(options) returned a non-table response",2)
end

if type(response.StatusCode)~="number"then
error("request(options) response is missing numeric StatusCode",2)
end

if type(response.Body)~="string"then
error("request(options) response is missing string Body",2)
end

return response
end

function Http.JsonRequest(method:string,url:string,headers:{[string]:string},body:any):HttpResponse__DARKLUA_TYPE_m
local requestHeaders:{[string]:string}={}
for key,value in pairs(headers)do
requestHeaders[key]=value
end

requestHeaders["Content-Type"]="application/json"

local encodedBody:string?=nil
if body~=nil then
encodedBody=Json.Encode(body)
end

return Http.Request({
Url=url,
Method=method,
Headers=requestHeaders,
Body=encodedBody,
})
end

return Http end function __DARKLUA_BUNDLE_MODULES.i():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.i if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.i=v end return v.c end end do local function __modImpl()












local RateLimiter={}
RateLimiter.__index=RateLimiter

function RateLimiter.new():RateLimiter__DARKLUA_TYPE_o
local self={
buckets={}::{[string]:RateLimitState__DARKLUA_TYPE_n},
}

return(setmetatable(self,RateLimiter)::any)::RateLimiter__DARKLUA_TYPE_o
end

local function parseRetryAfter(headers:{[string]:string},body:string):number
local retryHeader=headers["Retry-After"]or headers["retry-after"]
if retryHeader~=nil then
local retrySeconds=tonumber(retryHeader)
if retrySeconds~=nil then
return retrySeconds
end
end

local success,decoded=pcall(function()
return game:GetService("HttpService"):JSONDecode(body)
end)

if success and type(decoded)=="table"and type(decoded.retry_after)=="number"then
return decoded.retry_after
end

return 1
end

function RateLimiter:Wait(routeKey:string):()
if type(routeKey)~="string"or routeKey==""then
error("routeKey must be a non-empty string",2)
end

local state=(self::any).buckets[routeKey]
if state==nil then
return
end

local delaySeconds=state.unlockedAt-os.clock()
if delaySeconds>0 then
task.wait(delaySeconds)
end
end

function RateLimiter:Update(routeKey:string,statusCode:number,headers:{[string]:string},body:string):()
if type(routeKey)~="string"or routeKey==""then
error("routeKey must be a non-empty string",2)
end

if statusCode~=429 then
return
end

local retryAfter=parseRetryAfter(headers,body)
local state=self::any
state.buckets[routeKey]={
unlockedAt=os.clock()+retryAfter,
}
end

return RateLimiter end function __DARKLUA_BUNDLE_MODULES.j():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.j if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.j=v end return v.c end end do local function __modImpl()



local Http=__DARKLUA_BUNDLE_MODULES.i()
local Json=__DARKLUA_BUNDLE_MODULES.c()
local RateLimiter=__DARKLUA_BUNDLE_MODULES.j()





















local RestClient={}
RestClient.__index=RestClient

local DEFAULT_BASE_URL="https://discord.com/api/v10"

local function assertToken(token:string):()
if type(token)~="string"or token==""then
error("Discord bot token must be a non-empty string",3)
end
end

function RestClient.new(options:RestClientOptions__DARKLUA_TYPE_p):RestClient__DARKLUA_TYPE_q
assertToken(options.Token)

local baseUrl=options.BaseUrl
if baseUrl==nil then
baseUrl=DEFAULT_BASE_URL
end

local self={
token=options.Token,
baseUrl=baseUrl,
rateLimiter=RateLimiter.new(),
}

return(setmetatable(self,RestClient)::any)::RestClient__DARKLUA_TYPE_q
end

local function makeHeaders(token:string):{[string]:string}
return{
Authorization="Bot "..token,
["User-Agent"]="DiscordExecutorLuau/0.1",
}
end

function RestClient:Request(method:string,route:string,body:any):any
if type(method)~="string"or method==""then
error("method must be a non-empty string",2)
end

if type(route)~="string"or route==""then
error("route must be a non-empty string",2)
end

local state=self::any
local routeKey=method.." "..route
state.rateLimiter:Wait(routeKey)

local response=Http.JsonRequest(
method,
state.baseUrl..route,
makeHeaders(state.token),
body
)

state.rateLimiter:Update(routeKey,response.StatusCode,response.Headers or{},response.Body)

if response.StatusCode==204 then
return nil
end

local decoded=nil
if response.Body~=""then
decoded=Json.Decode(response.Body)
end

if response.StatusCode<200 or response.StatusCode>=300 then
error("Discord REST request failed: "..method.." "..route.." status="..tostring(response.StatusCode).." body="..response.Body,2)
end

return decoded
end

function RestClient:CreateMessage(channelId:string,payload:any):any
if type(channelId)~="string"or channelId==""then
error("channelId must be a non-empty string",2)
end

return self:Request("POST","/channels/"..channelId.."/messages",payload)
end

function RestClient:EditMessage(channelId:string,messageId:string,payload:any):any
if type(channelId)~="string"or channelId==""then
error("channelId must be a non-empty string",2)
end

if type(messageId)~="string"or messageId==""then
error("messageId must be a non-empty string",2)
end

return self:Request("PATCH","/channels/"..channelId.."/messages/"..messageId,payload)
end

function RestClient:DeleteMessage(channelId:string,messageId:string):any
if type(channelId)~="string"or channelId==""then
error("channelId must be a non-empty string",2)
end

if type(messageId)~="string"or messageId==""then
error("messageId must be a non-empty string",2)
end

return self:Request("DELETE","/channels/"..channelId.."/messages/"..messageId,nil)
end

function RestClient:CreateGlobalApplicationCommand(applicationId:string,payload:any):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

return self:Request("POST","/applications/"..applicationId.."/commands",payload)
end

function RestClient:BulkOverwriteGlobalApplicationCommands(applicationId:string,payload:{any}):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(payload)~="table"then
error("payload must be a table",2)
end

return self:Request("PUT","/applications/"..applicationId.."/commands",payload)
end

function RestClient:CreateGuildApplicationCommand(applicationId:string,guildId:string,payload:any):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(guildId)~="string"or guildId==""then
error("guildId must be a non-empty string",2)
end

return self:Request("POST","/applications/"..applicationId.."/guilds/"..guildId.."/commands",payload)
end

function RestClient:BulkOverwriteGuildApplicationCommands(applicationId:string,guildId:string,payload:{any}):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(guildId)~="string"or guildId==""then
error("guildId must be a non-empty string",2)
end

if type(payload)~="table"then
error("payload must be a table",2)
end

return self:Request("PUT","/applications/"..applicationId.."/guilds/"..guildId.."/commands",payload)
end

function RestClient:CreateInteractionResponse(interactionId:string,interactionToken:string,payload:any):any
if type(interactionId)~="string"or interactionId==""then
error("interactionId must be a non-empty string",2)
end

if type(interactionToken)~="string"or interactionToken==""then
error("interactionToken must be a non-empty string",2)
end

return self:Request("POST","/interactions/"..interactionId.."/"..interactionToken.."/callback",payload)
end

function RestClient:EditOriginalInteractionResponse(applicationId:string,interactionToken:string,payload:any):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(interactionToken)~="string"or interactionToken==""then
error("interactionToken must be a non-empty string",2)
end

return self:Request("PATCH","/webhooks/"..applicationId.."/"..interactionToken.."/messages/@original",payload)
end

function RestClient:DeleteOriginalInteractionResponse(applicationId:string,interactionToken:string):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(interactionToken)~="string"or interactionToken==""then
error("interactionToken must be a non-empty string",2)
end

return self:Request("DELETE","/webhooks/"..applicationId.."/"..interactionToken.."/messages/@original",nil)
end

function RestClient:CreateFollowupMessage(applicationId:string,interactionToken:string,payload:any):any
if type(applicationId)~="string"or applicationId==""then
error("applicationId must be a non-empty string",2)
end

if type(interactionToken)~="string"or interactionToken==""then
error("interactionToken must be a non-empty string",2)
end

return self:Request("POST","/webhooks/"..applicationId.."/"..interactionToken,payload)
end

return RestClient end function __DARKLUA_BUNDLE_MODULES.k():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.k if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.k=v end return v.c end end do local function __modImpl()



local GatewayClient=__DARKLUA_BUNDLE_MODULES.e()
local Interaction=__DARKLUA_BUNDLE_MODULES.g()
local Message=__DARKLUA_BUNDLE_MODULES.h()
local RestClient=__DARKLUA_BUNDLE_MODULES.k()























local Client={}
Client.__index=Client

function Client.new(options:ClientOptions__DARKLUA_TYPE_r):Client__DARKLUA_TYPE_s
if type(options.Token)~="string"or options.Token==""then
error("Discord bot token must be a non-empty string",2)
end

if type(options.Intents)~="number"then
error("Client intents must be a number",2)
end

local gateway=GatewayClient.new({
Token=options.Token,
Intents=options.Intents,
Url=options.GatewayUrl,
AutoReconnect=options.AutoReconnect,
ReconnectDelay=options.ReconnectDelay,
MaxReconnectAttempts=options.MaxReconnectAttempts,
SessionPersistence=options.SessionPersistence,
SessionFolder=options.SessionFolder,
SessionFileName=options.SessionFileName,
})

local rest=RestClient.new({
Token=options.Token,
BaseUrl=options.RestBaseUrl,
})

local self={
Rest=rest,
gateway=gateway,
}

local client=(setmetatable(self,Client)::any)::Client__DARKLUA_TYPE_s

return client
end

function Client:On(eventName:string,callback:(...any)->()):any
local state=self::any

if eventName=="MESSAGE_CREATE"then
return state.gateway:On(eventName,function(rawMessage:any)
callback(Message.new(rawMessage,state.Rest))
end)
end

if eventName=="INTERACTION_CREATE"then
return state.gateway:On(eventName,function(rawInteraction:any)
callback(Interaction.new(rawInteraction,state.Rest))
end)
end

return state.gateway:On(eventName,callback)
end

function Client:Once(eventName:string,callback:(...any)->()):any
local state=self::any

if eventName=="MESSAGE_CREATE"then
return state.gateway:Once(eventName,function(rawMessage:any)
callback(Message.new(rawMessage,state.Rest))
end)
end

if eventName=="INTERACTION_CREATE"then
return state.gateway:Once(eventName,function(rawInteraction:any)
callback(Interaction.new(rawInteraction,state.Rest))
end)
end

return state.gateway:Once(eventName,callback)
end

function Client:Login():()
(self::any).gateway:Connect()
end

function Client:Destroy():()
(self::any).gateway:Disconnect()
end

function Client:SetPresence(presence:any):()
(self::any).gateway:SetPresence(presence)
end

return Client end function __DARKLUA_BUNDLE_MODULES.l():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.l if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.l=v end return v.c end end do local function __modImpl()













local EmbedBuilder={}
EmbedBuilder.__index=EmbedBuilder

function EmbedBuilder.new():EmbedBuilder__DARKLUA_TYPE_t
local self={
embed={}::{[string]:any},
}

return(setmetatable(self,EmbedBuilder)::any)::EmbedBuilder__DARKLUA_TYPE_t
end

function EmbedBuilder:SetTitle(title:string):EmbedBuilder__DARKLUA_TYPE_t
if type(title)~="string"or title==""then
error("title must be a non-empty string",2)
end

local state=self::any
state.embed.title=title
return self
end

function EmbedBuilder:SetDescription(description:string):EmbedBuilder__DARKLUA_TYPE_t
if type(description)~="string"or description==""then
error("description must be a non-empty string",2)
end

local state=self::any
state.embed.description=description
return self
end

function EmbedBuilder:SetColor(color:number):EmbedBuilder__DARKLUA_TYPE_t
if type(color)~="number"then
error("color must be a number",2)
end

local state=self::any
state.embed.color=color
return self
end

function EmbedBuilder:SetUrl(url:string):EmbedBuilder__DARKLUA_TYPE_t
if type(url)~="string"or url==""then
error("url must be a non-empty string",2)
end

local state=self::any
state.embed.url=url
return self
end

function EmbedBuilder:SetTimestamp(timestamp:string):EmbedBuilder__DARKLUA_TYPE_t
if type(timestamp)~="string"or timestamp==""then
error("timestamp must be a non-empty string",2)
end

local state=self::any
state.embed.timestamp=timestamp
return self
end

function EmbedBuilder:AddField(name:string,value:string,inline:boolean):EmbedBuilder__DARKLUA_TYPE_t
if type(name)~="string"or name==""then
error("name must be a non-empty string",2)
end

if type(value)~="string"or value==""then
error("value must be a non-empty string",2)
end

if type(inline)~="boolean"then
error("inline must be a boolean",2)
end

local embed=(self::any).embed
if embed.fields==nil then
embed.fields={}
end

table.insert(embed.fields,{
name=name,
value=value,
inline=inline,
})

return self
end

function EmbedBuilder:Build():{[string]:any}
local output:{[string]:any}={}

for key,value in pairs((self::any).embed)do
output[key]=value
end

return output
end

return EmbedBuilder end function __DARKLUA_BUNDLE_MODULES.m():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.m if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.m=v end return v.c end end do local function __modImpl()



return{
Guilds=1,
GuildMembers=2,
GuildModeration=4,
GuildEmojisAndStickers=8,
GuildIntegrations=16,
GuildWebhooks=32,
GuildInvites=64,
GuildVoiceStates=128,
GuildPresences=256,
GuildMessages=512,
GuildMessageReactions=1024,
GuildMessageTyping=2048,
DirectMessages=4096,
DirectMessageReactions=8192,
DirectMessageTyping=16384,
MessageContent=32768,
GuildScheduledEvents=65536,
AutoModerationConfiguration=1048576,
AutoModerationExecution=2097152,
}end function __DARKLUA_BUNDLE_MODULES.n():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.n if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.n=v end return v.c end end do local function __modImpl()



return{
Pong=1,
ChannelMessageWithSource=4,
DeferredChannelMessageWithSource=5,
DeferredUpdateMessage=6,
UpdateMessage=7,
ApplicationCommandAutocompleteResult=8,
Modal=9,
}end function __DARKLUA_BUNDLE_MODULES.o():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.o if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.o=v end return v.c end end do local function __modImpl()
























local SlashCommandBuilder={}
SlashCommandBuilder.__index=SlashCommandBuilder

local OptionType={
SubCommand=1,
SubCommandGroup=2,
String=3,
Integer=4,
Boolean=5,
User=6,
Channel=7,
Role=8,
Mentionable=9,
Number=10,
Attachment=11,
}

local function assertCommandName(name:string):()
if type(name)~="string"or not string.match(name,"^[%l%d_-]+$")then
error("slash command names must use lowercase letters, numbers, underscores, or dashes",3)
end

if#name<1 or#name>32 then
error("slash command names must be 1 to 32 characters",3)
end
end

local function assertDescription(description:string):()
if type(description)~="string"or#description<1 or#description>100 then
error("slash command descriptions must be 1 to 100 characters",3)
end
end

local function addOption(self:SlashCommandBuilder__DARKLUA_TYPE_v,optionType:number,name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
assertCommandName(name)
assertDescription(description)

if type(required)~="boolean"then
error("required must be a boolean",3)
end

local state=self::any
table.insert(state.command.options,{
type=optionType,
name=name,
description=description,
required=required,
})

return self
end

function SlashCommandBuilder.new():SlashCommandBuilder__DARKLUA_TYPE_v
local self={
command={
type=1,
name=nil::string?,
description=nil::string?,
options={}::{SlashCommandOption__DARKLUA_TYPE_u},
},
}

return(setmetatable(self,SlashCommandBuilder)::any)::SlashCommandBuilder__DARKLUA_TYPE_v
end

function SlashCommandBuilder:SetName(name:string):SlashCommandBuilder__DARKLUA_TYPE_v
assertCommandName(name)
local state=self::any
state.command.name=name
return self
end

function SlashCommandBuilder:SetDescription(description:string):SlashCommandBuilder__DARKLUA_TYPE_v
assertDescription(description)
local state=self::any
state.command.description=description
return self
end

function SlashCommandBuilder:AddStringOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.String,name,description,required)
end

function SlashCommandBuilder:AddIntegerOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.Integer,name,description,required)
end

function SlashCommandBuilder:AddBooleanOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.Boolean,name,description,required)
end

function SlashCommandBuilder:AddUserOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.User,name,description,required)
end

function SlashCommandBuilder:AddChannelOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.Channel,name,description,required)
end

function SlashCommandBuilder:AddRoleOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_v
return addOption(self,OptionType.Role,name,description,required)
end

function SlashCommandBuilder:Build():{[string]:any}
local command=(self::any).command
if command.name==nil then
error("slash command name is required",2)
end

if command.description==nil then
error("slash command description is required",2)
end

local output:{[string]:any}={
type=command.type,
name=command.name,
description=command.description,
}

if#command.options>0 then
output.options=command.options
end

return output
end

return SlashCommandBuilder end function __DARKLUA_BUNDLE_MODULES.p():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.p if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.p=v end return v.c end end end



local Client=__DARKLUA_BUNDLE_MODULES.l()
local EmbedBuilder=__DARKLUA_BUNDLE_MODULES.m()
local GatewayOpcode=__DARKLUA_BUNDLE_MODULES.b()
local Intents=__DARKLUA_BUNDLE_MODULES.n()
local InteractionResponseType=__DARKLUA_BUNDLE_MODULES.o()
local Interaction=__DARKLUA_BUNDLE_MODULES.g()
local Message=__DARKLUA_BUNDLE_MODULES.h()
local RestClient=__DARKLUA_BUNDLE_MODULES.k()
local SessionStore=__DARKLUA_BUNDLE_MODULES.d()
local SlashCommandBuilder=__DARKLUA_BUNDLE_MODULES.p()

return{
Client=Client,
EmbedBuilder=EmbedBuilder,
GatewayOpcode=GatewayOpcode,
Interaction=Interaction,
Intents=Intents,
InteractionResponseType=InteractionResponseType,
Message=Message,
RestClient=RestClient,
SessionStore=SessionStore,
SlashCommandBuilder=SlashCommandBuilder,
}