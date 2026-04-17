type ActionRowBuilder__DARKLUA_TYPE_a={
AddComponents:(self:ActionRowBuilder__DARKLUA_TYPE_a,...any)->ActionRowBuilder__DARKLUA_TYPE_a,
SetComponents:(self:ActionRowBuilder__DARKLUA_TYPE_a,components:{any})->ActionRowBuilder__DARKLUA_TYPE_a,
Build:(self:ActionRowBuilder__DARKLUA_TYPE_a)->{[string]:any},
}

type ButtonBuilder__DARKLUA_TYPE_b={
SetCustomId:(self:ButtonBuilder__DARKLUA_TYPE_b,customId:string)->ButtonBuilder__DARKLUA_TYPE_b,
SetLabel:(self:ButtonBuilder__DARKLUA_TYPE_b,label:string)->ButtonBuilder__DARKLUA_TYPE_b,
SetStyle:(self:ButtonBuilder__DARKLUA_TYPE_b,style:number)->ButtonBuilder__DARKLUA_TYPE_b,
SetUrl:(self:ButtonBuilder__DARKLUA_TYPE_b,url:string)->ButtonBuilder__DARKLUA_TYPE_b,
SetDisabled:(self:ButtonBuilder__DARKLUA_TYPE_b,disabled:boolean)->ButtonBuilder__DARKLUA_TYPE_b,
Build:(self:ButtonBuilder__DARKLUA_TYPE_b)->{[string]:any},
}

type Disconnectable__DARKLUA_TYPE_c={
Disconnect:(self:Disconnectable__DARKLUA_TYPE_c)->(),
}

type EventEmitter__DARKLUA_TYPE_d={
On:(self:EventEmitter__DARKLUA_TYPE_d,eventName:string,callback:(...any)->())->Disconnectable__DARKLUA_TYPE_c,
Once:(self:EventEmitter__DARKLUA_TYPE_d,eventName:string,callback:(...any)->())->Disconnectable__DARKLUA_TYPE_c,
Emit:(self:EventEmitter__DARKLUA_TYPE_d,eventName:string,...any)->(),
RemoveAllListeners:(self:EventEmitter__DARKLUA_TYPE_d,eventName:string)->(),
}

type Listener__DARKLUA_TYPE_e={
callback:(...any)->(),
once:boolean,
}

type EventEmitterState__DARKLUA_TYPE_f={
listeners:{[string]:{Listener__DARKLUA_TYPE_e}},
}

type Json__DARKLUA_TYPE_g={
Encode:(value:any)->string,
Decode:(value:string)->any,
}

type GatewaySession__DARKLUA_TYPE_h={
sessionId:string?,
sequence:number?,
resumeGatewayUrl:string?,
}

type SessionStore__DARKLUA_TYPE_i={
Load:(self:SessionStore__DARKLUA_TYPE_i)->GatewaySession__DARKLUA_TYPE_h?,
Save:(self:SessionStore__DARKLUA_TYPE_i,session:GatewaySession__DARKLUA_TYPE_h)->(),
Clear:(self:SessionStore__DARKLUA_TYPE_i)->(),
}

type GatewayClientOptions__DARKLUA_TYPE_j={
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

type GatewayClient__DARKLUA_TYPE_k={
On:(self:GatewayClient__DARKLUA_TYPE_k,eventName:string,callback:(...any)->())->any,
Once:(self:GatewayClient__DARKLUA_TYPE_k,eventName:string,callback:(...any)->())->any,
Connect:(self:GatewayClient__DARKLUA_TYPE_k)->(),
Disconnect:(self:GatewayClient__DARKLUA_TYPE_k)->(),
Send:(self:GatewayClient__DARKLUA_TYPE_k,payload:any)->(),
SetPresence:(self:GatewayClient__DARKLUA_TYPE_k,presence:any)->(),
}

type Interaction__DARKLUA_TYPE_l={
Id:string,
Token:string,
ApplicationId:string,
Type:number,
Data:any,
CommandName:string?,
CustomId:string?,
Values:{string},
Options:{any},
Raw:any,
Reply:(self:Interaction__DARKLUA_TYPE_l,payload:any)->any,
ReplyEphemeral:(self:Interaction__DARKLUA_TYPE_l,payload:any)->any,
DeferReply:(self:Interaction__DARKLUA_TYPE_l,ephemeral:boolean)->any,
EditReply:(self:Interaction__DARKLUA_TYPE_l,payload:any)->any,
DeleteReply:(self:Interaction__DARKLUA_TYPE_l)->any,
FollowUp:(self:Interaction__DARKLUA_TYPE_l,payload:any)->any,
ShowModal:(self:Interaction__DARKLUA_TYPE_l,modal:any)->any,
GetOption:(self:Interaction__DARKLUA_TYPE_l,name:string)->any,
GetString:(self:Interaction__DARKLUA_TYPE_l,name:string)->string?,
GetInteger:(self:Interaction__DARKLUA_TYPE_l,name:string)->number?,
GetBoolean:(self:Interaction__DARKLUA_TYPE_l,name:string)->boolean?,
GetTextInputValue:(self:Interaction__DARKLUA_TYPE_l,customId:string)->string?,
}

type Message__DARKLUA_TYPE_m={
Id:string,
ChannelId:string,
GuildId:string?,
Content:string,
Author:any,
Raw:any,
Reply:(self:Message__DARKLUA_TYPE_m,payload:any)->any,
Edit:(self:Message__DARKLUA_TYPE_m,payload:any)->any,
Delete:(self:Message__DARKLUA_TYPE_m)->any,
}

type RequestOptions__DARKLUA_TYPE_n={
Url:string,
Method:string,
Headers:{[string]:string},
Body:string?,
}

type HttpResponse__DARKLUA_TYPE_o={
StatusCode:number,
Body:string,
Headers:{[string]:string},
}

type RateLimitState__DARKLUA_TYPE_p={
unlockedAt:number,
}

type RateLimiter__DARKLUA_TYPE_q={
Wait:(self:RateLimiter__DARKLUA_TYPE_q,routeKey:string)->(),
Update:(self:RateLimiter__DARKLUA_TYPE_q,routeKey:string,statusCode:number,headers:{[string]:string},body:string)->(),
}

type RestClientOptions__DARKLUA_TYPE_r={
Token:string,
BaseUrl:string?,
}

type RestClient__DARKLUA_TYPE_s={
Request:(self:RestClient__DARKLUA_TYPE_s,method:string,route:string,body:any)->any,
CreateMessage:(self:RestClient__DARKLUA_TYPE_s,channelId:string,payload:any)->any,
EditMessage:(self:RestClient__DARKLUA_TYPE_s,channelId:string,messageId:string,payload:any)->any,
DeleteMessage:(self:RestClient__DARKLUA_TYPE_s,channelId:string,messageId:string)->any,
CreateGlobalApplicationCommand:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,payload:any)->any,
BulkOverwriteGlobalApplicationCommands:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,payload:{any})->any,
CreateGuildApplicationCommand:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,guildId:string,payload:any)->any,
BulkOverwriteGuildApplicationCommands:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,guildId:string,payload:{any})->any,
CreateInteractionResponse:(self:RestClient__DARKLUA_TYPE_s,interactionId:string,interactionToken:string,payload:any)->any,
EditOriginalInteractionResponse:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,interactionToken:string,payload:any)->any,
DeleteOriginalInteractionResponse:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,interactionToken:string)->any,
CreateFollowupMessage:(self:RestClient__DARKLUA_TYPE_s,applicationId:string,interactionToken:string,payload:any)->any,
}

type ClientOptions__DARKLUA_TYPE_t={
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

type Client__DARKLUA_TYPE_u={
Rest:any,
On:(self:Client__DARKLUA_TYPE_u,eventName:string,callback:(...any)->())->any,
Once:(self:Client__DARKLUA_TYPE_u,eventName:string,callback:(...any)->())->any,
Login:(self:Client__DARKLUA_TYPE_u)->(),
Destroy:(self:Client__DARKLUA_TYPE_u)->(),
SetPresence:(self:Client__DARKLUA_TYPE_u,presence:any)->(),
}

type ContainerBuilder__DARKLUA_TYPE_v={
SetAccentColor:(self:ContainerBuilder__DARKLUA_TYPE_v,color:number)->ContainerBuilder__DARKLUA_TYPE_v,
SetSpoiler:(self:ContainerBuilder__DARKLUA_TYPE_v,spoiler:boolean)->ContainerBuilder__DARKLUA_TYPE_v,
AddComponents:(self:ContainerBuilder__DARKLUA_TYPE_v,...any)->ContainerBuilder__DARKLUA_TYPE_v,
SetComponents:(self:ContainerBuilder__DARKLUA_TYPE_v,components:{any})->ContainerBuilder__DARKLUA_TYPE_v,
Build:(self:ContainerBuilder__DARKLUA_TYPE_v)->{[string]:any},
}

type EmbedBuilder__DARKLUA_TYPE_w={
SetTitle:(self:EmbedBuilder__DARKLUA_TYPE_w,title:string)->EmbedBuilder__DARKLUA_TYPE_w,
SetDescription:(self:EmbedBuilder__DARKLUA_TYPE_w,description:string)->EmbedBuilder__DARKLUA_TYPE_w,
SetColor:(self:EmbedBuilder__DARKLUA_TYPE_w,color:number)->EmbedBuilder__DARKLUA_TYPE_w,
SetUrl:(self:EmbedBuilder__DARKLUA_TYPE_w,url:string)->EmbedBuilder__DARKLUA_TYPE_w,
SetTimestamp:(self:EmbedBuilder__DARKLUA_TYPE_w,timestamp:string)->EmbedBuilder__DARKLUA_TYPE_w,
AddField:(self:EmbedBuilder__DARKLUA_TYPE_w,name:string,value:string,inline:boolean)->EmbedBuilder__DARKLUA_TYPE_w,
Build:(self:EmbedBuilder__DARKLUA_TYPE_w)->{[string]:any},
}

type ModalBuilder__DARKLUA_TYPE_x={
SetCustomId:(self:ModalBuilder__DARKLUA_TYPE_x,customId:string)->ModalBuilder__DARKLUA_TYPE_x,
SetTitle:(self:ModalBuilder__DARKLUA_TYPE_x,title:string)->ModalBuilder__DARKLUA_TYPE_x,
AddComponents:(self:ModalBuilder__DARKLUA_TYPE_x,...any)->ModalBuilder__DARKLUA_TYPE_x,
SetComponents:(self:ModalBuilder__DARKLUA_TYPE_x,components:{any})->ModalBuilder__DARKLUA_TYPE_x,
Build:(self:ModalBuilder__DARKLUA_TYPE_x)->{[string]:any},
}

type SelectMenuOptionBuilder__DARKLUA_TYPE_y={
SetLabel:(self:SelectMenuOptionBuilder__DARKLUA_TYPE_y,label:string)->SelectMenuOptionBuilder__DARKLUA_TYPE_y,
SetValue:(self:SelectMenuOptionBuilder__DARKLUA_TYPE_y,value:string)->SelectMenuOptionBuilder__DARKLUA_TYPE_y,
SetDescription:(self:SelectMenuOptionBuilder__DARKLUA_TYPE_y,description:string)->SelectMenuOptionBuilder__DARKLUA_TYPE_y,
SetDefault:(self:SelectMenuOptionBuilder__DARKLUA_TYPE_y,defaultValue:boolean)->SelectMenuOptionBuilder__DARKLUA_TYPE_y,
Build:(self:SelectMenuOptionBuilder__DARKLUA_TYPE_y)->{[string]:any},
}

type SectionBuilder__DARKLUA_TYPE_z={
AddComponents:(self:SectionBuilder__DARKLUA_TYPE_z,...any)->SectionBuilder__DARKLUA_TYPE_z,
SetComponents:(self:SectionBuilder__DARKLUA_TYPE_z,components:{any})->SectionBuilder__DARKLUA_TYPE_z,
SetAccessory:(self:SectionBuilder__DARKLUA_TYPE_z,accessory:any)->SectionBuilder__DARKLUA_TYPE_z,
Build:(self:SectionBuilder__DARKLUA_TYPE_z)->{[string]:any},
}

type SeparatorBuilder__DARKLUA_TYPE_A={
SetDivider:(self:SeparatorBuilder__DARKLUA_TYPE_A,divider:boolean)->SeparatorBuilder__DARKLUA_TYPE_A,
SetSpacing:(self:SeparatorBuilder__DARKLUA_TYPE_A,spacing:number)->SeparatorBuilder__DARKLUA_TYPE_A,
Build:(self:SeparatorBuilder__DARKLUA_TYPE_A)->{[string]:any},
}

type SlashCommandOption__DARKLUA_TYPE_B={
type:number,
name:string,
description:string,
required:boolean?,
choices:{any}?,
options:{SlashCommandOption__DARKLUA_TYPE_B}?,
}

type SlashCommandBuilder__DARKLUA_TYPE_C={
SetName:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string)->SlashCommandBuilder__DARKLUA_TYPE_C,
SetDescription:(self:SlashCommandBuilder__DARKLUA_TYPE_C,description:string)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddStringOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddIntegerOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddBooleanOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddUserOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddChannelOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
AddRoleOption:(self:SlashCommandBuilder__DARKLUA_TYPE_C,name:string,description:string,required:boolean)->SlashCommandBuilder__DARKLUA_TYPE_C,
Build:(self:SlashCommandBuilder__DARKLUA_TYPE_C)->{[string]:any},
}

type StringSelectMenuBuilder__DARKLUA_TYPE_D={
SetCustomId:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,customId:string)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
SetPlaceholder:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,placeholder:string)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
SetMinValues:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,minValues:number)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
SetMaxValues:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,maxValues:number)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
SetDisabled:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,disabled:boolean)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
AddOptions:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,...any)->StringSelectMenuBuilder__DARKLUA_TYPE_D,
SetOptions:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D,options:{any})->StringSelectMenuBuilder__DARKLUA_TYPE_D,
Build:(self:StringSelectMenuBuilder__DARKLUA_TYPE_D)->{[string]:any},
}

type TextInputBuilder__DARKLUA_TYPE_E={
SetCustomId:(self:TextInputBuilder__DARKLUA_TYPE_E,customId:string)->TextInputBuilder__DARKLUA_TYPE_E,
SetLabel:(self:TextInputBuilder__DARKLUA_TYPE_E,label:string)->TextInputBuilder__DARKLUA_TYPE_E,
SetStyle:(self:TextInputBuilder__DARKLUA_TYPE_E,style:number)->TextInputBuilder__DARKLUA_TYPE_E,
SetMinLength:(self:TextInputBuilder__DARKLUA_TYPE_E,minLength:number)->TextInputBuilder__DARKLUA_TYPE_E,
SetMaxLength:(self:TextInputBuilder__DARKLUA_TYPE_E,maxLength:number)->TextInputBuilder__DARKLUA_TYPE_E,
SetRequired:(self:TextInputBuilder__DARKLUA_TYPE_E,required:boolean)->TextInputBuilder__DARKLUA_TYPE_E,
SetValue:(self:TextInputBuilder__DARKLUA_TYPE_E,value:string)->TextInputBuilder__DARKLUA_TYPE_E,
SetPlaceholder:(self:TextInputBuilder__DARKLUA_TYPE_E,placeholder:string)->TextInputBuilder__DARKLUA_TYPE_E,
Build:(self:TextInputBuilder__DARKLUA_TYPE_E)->{[string]:any},
}

type TextDisplayBuilder__DARKLUA_TYPE_F={
SetContent:(self:TextDisplayBuilder__DARKLUA_TYPE_F,content:string)->TextDisplayBuilder__DARKLUA_TYPE_F,
Build:(self:TextDisplayBuilder__DARKLUA_TYPE_F)->{[string]:any},
}local __DARKLUA_BUNDLE_MODULES={cache={}::any}do do local function __modImpl()









local ActionRowBuilder={}
ActionRowBuilder.__index=ActionRowBuilder

local COMPONENT_TYPE_ACTION_ROW=1
local MAX_COMPONENTS=5

function ActionRowBuilder.new():ActionRowBuilder__DARKLUA_TYPE_a
local self={
components={}::{any},
}

return(setmetatable(self,ActionRowBuilder)::any)::ActionRowBuilder__DARKLUA_TYPE_a
end

local function normalizeComponent(component:any):any
if type(component)~="table"then
error("component must be a table",3)
end

if type(component.Build)=="function"then
return component:Build()
end

return component
end

function ActionRowBuilder:AddComponents(...:any):ActionRowBuilder__DARKLUA_TYPE_a
local state=self::any
local components=table.pack(...)

for index=1,components.n do
if#state.components>=MAX_COMPONENTS then
error("action rows can contain at most five components",2)
end

table.insert(state.components,normalizeComponent(components[index]))
end

return self
end

function ActionRowBuilder:SetComponents(components:{any}):ActionRowBuilder__DARKLUA_TYPE_a
if type(components)~="table"then
error("components must be a table",2)
end

if#components>MAX_COMPONENTS then
error("action rows can contain at most five components",2)
end

local normalizedComponents:{any}={}
for _,component in ipairs(components)do
table.insert(normalizedComponents,normalizeComponent(component))
end

local state=self::any
state.components=normalizedComponents
return self
end

function ActionRowBuilder:Build():{[string]:any}
local state=self::any

if#state.components<1 then
error("action rows require at least one component",2)
end

return{
type=COMPONENT_TYPE_ACTION_ROW,
components=state.components,
}
end

return ActionRowBuilder end function __DARKLUA_BUNDLE_MODULES.a():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.a if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.a=v end return v.c end end do local function __modImpl()












local ButtonBuilder={}
ButtonBuilder.__index=ButtonBuilder

local COMPONENT_TYPE_BUTTON=2
local LINK_BUTTON_STYLE=5

local function assertString(name:string,value:string,maxLength:number):()
if type(value)~="string"or value==""then
error(name.." must be a non-empty string",3)
end

if#value>maxLength then
error(name.." must be "..tostring(maxLength).." characters or fewer",3)
end
end

function ButtonBuilder.new():ButtonBuilder__DARKLUA_TYPE_b
local self={
component={
type=COMPONENT_TYPE_BUTTON,
}::{[string]:any},
}

return(setmetatable(self,ButtonBuilder)::any)::ButtonBuilder__DARKLUA_TYPE_b
end

function ButtonBuilder:SetCustomId(customId:string):ButtonBuilder__DARKLUA_TYPE_b
assertString("customId",customId,100)

local component=(self::any).component
component.custom_id=customId
component.url=nil
return self
end

function ButtonBuilder:SetLabel(label:string):ButtonBuilder__DARKLUA_TYPE_b
assertString("label",label,80)

local component=(self::any).component
component.label=label
return self
end

function ButtonBuilder:SetStyle(style:number):ButtonBuilder__DARKLUA_TYPE_b
if type(style)~="number"or style<1 or style>5 then
error("button style must be a number from 1 to 5",2)
end

local component=(self::any).component
component.style=style
return self
end

function ButtonBuilder:SetUrl(url:string):ButtonBuilder__DARKLUA_TYPE_b
assertString("url",url,512)

local component=(self::any).component
component.url=url
component.custom_id=nil
component.style=LINK_BUTTON_STYLE
return self
end

function ButtonBuilder:SetDisabled(disabled:boolean):ButtonBuilder__DARKLUA_TYPE_b
if type(disabled)~="boolean"then
error("disabled must be a boolean",2)
end

local component=(self::any).component
component.disabled=disabled
return self
end

function ButtonBuilder:Build():{[string]:any}
local component=(self::any).component

if type(component.style)~="number"then
error("button style is required",2)
end

if component.style==LINK_BUTTON_STYLE then
if type(component.url)~="string"or component.url==""then
error("link buttons require a url",2)
end
else
if type(component.custom_id)~="string"or component.custom_id==""then
error("non-link buttons require a customId",2)
end
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return ButtonBuilder end function __DARKLUA_BUNDLE_MODULES.b():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.b if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.b=v end return v.c end end do local function __modImpl()



return{
Primary=1,
Secondary=2,
Success=3,
Danger=4,
Link=5,
}end function __DARKLUA_BUNDLE_MODULES.c():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end do local function __modImpl()























local EventEmitter={}
EventEmitter.__index=EventEmitter

function EventEmitter.new():EventEmitter__DARKLUA_TYPE_d
local self:EventEmitterState__DARKLUA_TYPE_f={
listeners={},
}

return(setmetatable(self,EventEmitter)::any)::EventEmitter__DARKLUA_TYPE_d
end

function EventEmitter:On(eventName:string,callback:(...any)->()):Disconnectable__DARKLUA_TYPE_c
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

if type(callback)~="function"then
error("callback must be a function",2)
end

local state=self::any
local listener:Listener__DARKLUA_TYPE_e={
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

local nextListeners:{Listener__DARKLUA_TYPE_e}={}
for _,currentListener in ipairs(currentListeners)do
if currentListener~=listener then
table.insert(nextListeners,currentListener)
end
end

state.listeners[eventName]=nextListeners
end

return disconnectable::Disconnectable__DARKLUA_TYPE_c
end

function EventEmitter:Once(eventName:string,callback:(...any)->()):Disconnectable__DARKLUA_TYPE_c
if type(eventName)~="string"or eventName==""then
error("eventName must be a non-empty string",2)
end

if type(callback)~="function"then
error("callback must be a function",2)
end

local state=self::any
local listener:Listener__DARKLUA_TYPE_e={
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

local nextListeners:{Listener__DARKLUA_TYPE_e}={}
for _,currentListener in ipairs(currentListeners)do
if currentListener~=listener then
table.insert(nextListeners,currentListener)
end
end

state.listeners[eventName]=nextListeners
end

return disconnectable::Disconnectable__DARKLUA_TYPE_c
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
local nextListeners:{Listener__DARKLUA_TYPE_e}={}

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

return EventEmitter end function __DARKLUA_BUNDLE_MODULES.d():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function __modImpl()



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
}end function __DARKLUA_BUNDLE_MODULES.e():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end do local function __modImpl()








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

return Json end function __DARKLUA_BUNDLE_MODULES.f():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end do local function __modImpl()



local Json=__DARKLUA_BUNDLE_MODULES.f()













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

function SessionStore.new(folder:string?,fileName:string?):SessionStore__DARKLUA_TYPE_i
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

return(setmetatable(self,SessionStore)::any)::SessionStore__DARKLUA_TYPE_i
end

function SessionStore:Load():GatewaySession__DARKLUA_TYPE_h?
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

function SessionStore:Save(session:GatewaySession__DARKLUA_TYPE_h):()
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

return SessionStore end function __DARKLUA_BUNDLE_MODULES.g():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.g if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.g=v end return v.c end end do local function __modImpl()



local EventEmitter=__DARKLUA_BUNDLE_MODULES.d()
local GatewayOpcode=__DARKLUA_BUNDLE_MODULES.e()
local Json=__DARKLUA_BUNDLE_MODULES.f()
local SessionStore=__DARKLUA_BUNDLE_MODULES.g()






















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

function GatewayClient.new(options:GatewayClientOptions__DARKLUA_TYPE_j):GatewayClient__DARKLUA_TYPE_k
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

return(setmetatable(self,GatewayClient)::any)::GatewayClient__DARKLUA_TYPE_k
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

return GatewayClient end function __DARKLUA_BUNDLE_MODULES.h():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.h if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.h=v end return v.c end end do local function __modImpl()



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

function Payload.Modal(value:any):any
local modalPayload=value
if type(value)=="table"and type(value.Build)=="function"then
modalPayload=value:Build()
end

if type(modalPayload)~="table"then
error("modal payload must be a table or ModalBuilder",3)
end

return{
type=9,
data=modalPayload,
}
end

function Payload.EphemeralMessage(value:any):any
local messagePayload=Payload.Message(value)
messagePayload.flags=64
return messagePayload
end

function Payload.WithFlags(value:any,flags:number):any
local messagePayload=Payload.Message(value)
messagePayload.flags=flags
return messagePayload
end

return Payload end function __DARKLUA_BUNDLE_MODULES.i():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.i if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.i=v end return v.c end end do local function __modImpl()



local Payload=__DARKLUA_BUNDLE_MODULES.i()


























local Interaction={}
Interaction.__index=Interaction

local function getOptions(rawInteraction:any):{any}
if type(rawInteraction.data)~="table"or type(rawInteraction.data.options)~="table"then
return{}
end

return rawInteraction.data.options
end

function Interaction.new(rawInteraction:any,restClient:any):Interaction__DARKLUA_TYPE_l
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

local customId=nil
if type(rawInteraction.data)=="table"then
customId=rawInteraction.data.custom_id
end

local values={}
if type(rawInteraction.data)=="table"and type(rawInteraction.data.values)=="table"then
values=rawInteraction.data.values
end

local self={
Id=rawInteraction.id,
Token=rawInteraction.token,
ApplicationId=rawInteraction.application_id,
Type=rawInteraction.type,
Data=rawInteraction.data,
CommandName=commandName,
CustomId=customId,
Values=values,
Options=getOptions(rawInteraction),
Raw=rawInteraction,
restClient=restClient,
}

return(setmetatable(self,Interaction)::any)::Interaction__DARKLUA_TYPE_l
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

function Interaction:ShowModal(modal:any):any
local state=self::any
return state.restClient:CreateInteractionResponse(
state.Id,
state.Token,
Payload.Modal(modal)
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

function Interaction:GetTextInputValue(customId:string):string?
if type(customId)~="string"or customId==""then
error("customId must be a non-empty string",2)
end

local data=(self::any).Data
if type(data)~="table"or type(data.components)~="table"then
return nil
end

for _,row in ipairs(data.components)do
if type(row)=="table"and type(row.components)=="table"then
for _,component in ipairs(row.components)do
if type(component)=="table"and component.custom_id==customId then
return component.value
end
end
end
end

return nil
end

return Interaction end function __DARKLUA_BUNDLE_MODULES.j():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.j if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.j=v end return v.c end end do local function __modImpl()



local Payload=__DARKLUA_BUNDLE_MODULES.i()













local Message={}
Message.__index=Message

function Message.new(rawMessage:any,restClient:any):Message__DARKLUA_TYPE_m
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

return(setmetatable(self,Message)::any)::Message__DARKLUA_TYPE_m
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

return Message end function __DARKLUA_BUNDLE_MODULES.k():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.k if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.k=v end return v.c end end do local function __modImpl()



local Json=__DARKLUA_BUNDLE_MODULES.f()














local Http={}

local function getRequestFunction():(RequestOptions__DARKLUA_TYPE_n)->HttpResponse__DARKLUA_TYPE_o
local requestFunction=(getgenv and getgenv().request)or request or http_request or(http and http.request)

if type(requestFunction)~="function"then
error("UNC request function is unavailable. This executor must support request(options).",2)
end

return requestFunction
end

function Http.Request(options:RequestOptions__DARKLUA_TYPE_n):HttpResponse__DARKLUA_TYPE_o
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

function Http.JsonRequest(method:string,url:string,headers:{[string]:string},body:any):HttpResponse__DARKLUA_TYPE_o
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

return Http end function __DARKLUA_BUNDLE_MODULES.l():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.l if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.l=v end return v.c end end do local function __modImpl()












local RateLimiter={}
RateLimiter.__index=RateLimiter

function RateLimiter.new():RateLimiter__DARKLUA_TYPE_q
local self={
buckets={}::{[string]:RateLimitState__DARKLUA_TYPE_p},
}

return(setmetatable(self,RateLimiter)::any)::RateLimiter__DARKLUA_TYPE_q
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

return RateLimiter end function __DARKLUA_BUNDLE_MODULES.m():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.m if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.m=v end return v.c end end do local function __modImpl()



local Http=__DARKLUA_BUNDLE_MODULES.l()
local Json=__DARKLUA_BUNDLE_MODULES.f()
local RateLimiter=__DARKLUA_BUNDLE_MODULES.m()





















local RestClient={}
RestClient.__index=RestClient

local DEFAULT_BASE_URL="https://discord.com/api/v10"

local function assertToken(token:string):()
if type(token)~="string"or token==""then
error("Discord bot token must be a non-empty string",3)
end
end

function RestClient.new(options:RestClientOptions__DARKLUA_TYPE_r):RestClient__DARKLUA_TYPE_s
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

return(setmetatable(self,RestClient)::any)::RestClient__DARKLUA_TYPE_s
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

return RestClient end function __DARKLUA_BUNDLE_MODULES.n():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.n if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.n=v end return v.c end end do local function __modImpl()



local GatewayClient=__DARKLUA_BUNDLE_MODULES.h()
local Interaction=__DARKLUA_BUNDLE_MODULES.j()
local Message=__DARKLUA_BUNDLE_MODULES.k()
local RestClient=__DARKLUA_BUNDLE_MODULES.n()























local Client={}
Client.__index=Client

function Client.new(options:ClientOptions__DARKLUA_TYPE_t):Client__DARKLUA_TYPE_u
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

local client=(setmetatable(self,Client)::any)::Client__DARKLUA_TYPE_u

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

return Client end function __DARKLUA_BUNDLE_MODULES.o():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.o if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.o=v end return v.c end end do local function __modImpl()











local ContainerBuilder={}
ContainerBuilder.__index=ContainerBuilder

local COMPONENT_TYPE_CONTAINER=17
local MAX_COMPONENTS=40

local function normalizeComponent(component:any):any
if type(component)~="table"then
error("container component must be a table",3)
end

if type(component.Build)=="function"then
return component:Build()
end

return component
end

function ContainerBuilder.new():ContainerBuilder__DARKLUA_TYPE_v
local self={
component={
type=COMPONENT_TYPE_CONTAINER,
components={}::{any},
}::{[string]:any},
}

return(setmetatable(self,ContainerBuilder)::any)::ContainerBuilder__DARKLUA_TYPE_v
end

function ContainerBuilder:SetAccentColor(color:number):ContainerBuilder__DARKLUA_TYPE_v
if type(color)~="number"or color<0 or color>0xFFFFFF then
error("color must be a number from 0x000000 to 0xFFFFFF",2)
end

local component=(self::any).component
component.accent_color=color
return self
end

function ContainerBuilder:SetSpoiler(spoiler:boolean):ContainerBuilder__DARKLUA_TYPE_v
if type(spoiler)~="boolean"then
error("spoiler must be a boolean",2)
end

local component=(self::any).component
component.spoiler=spoiler
return self
end

function ContainerBuilder:AddComponents(...:any):ContainerBuilder__DARKLUA_TYPE_v
local component=(self::any).component
local components=table.pack(...)

for index=1,components.n do
if#component.components>=MAX_COMPONENTS then
error("containers can contain at most 40 components",2)
end

table.insert(component.components,normalizeComponent(components[index]))
end

return self
end

function ContainerBuilder:SetComponents(components:{any}):ContainerBuilder__DARKLUA_TYPE_v
if type(components)~="table"then
error("components must be a table",2)
end

if#components>MAX_COMPONENTS then
error("containers can contain at most 40 components",2)
end

local normalizedComponents:{any}={}
for _,component in ipairs(components)do
table.insert(normalizedComponents,normalizeComponent(component))
end

local component=(self::any).component
component.components=normalizedComponents
return self
end

function ContainerBuilder:Build():{[string]:any}
local component=(self::any).component

if#component.components<1 then
error("containers require at least one component",2)
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return ContainerBuilder end function __DARKLUA_BUNDLE_MODULES.p():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.p if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.p=v end return v.c end end do local function __modImpl()













local EmbedBuilder={}
EmbedBuilder.__index=EmbedBuilder

function EmbedBuilder.new():EmbedBuilder__DARKLUA_TYPE_w
local self={
embed={}::{[string]:any},
}

return(setmetatable(self,EmbedBuilder)::any)::EmbedBuilder__DARKLUA_TYPE_w
end

function EmbedBuilder:SetTitle(title:string):EmbedBuilder__DARKLUA_TYPE_w
if type(title)~="string"or title==""then
error("title must be a non-empty string",2)
end

local state=self::any
state.embed.title=title
return self
end

function EmbedBuilder:SetDescription(description:string):EmbedBuilder__DARKLUA_TYPE_w
if type(description)~="string"or description==""then
error("description must be a non-empty string",2)
end

local state=self::any
state.embed.description=description
return self
end

function EmbedBuilder:SetColor(color:number):EmbedBuilder__DARKLUA_TYPE_w
if type(color)~="number"then
error("color must be a number",2)
end

local state=self::any
state.embed.color=color
return self
end

function EmbedBuilder:SetUrl(url:string):EmbedBuilder__DARKLUA_TYPE_w
if type(url)~="string"or url==""then
error("url must be a non-empty string",2)
end

local state=self::any
state.embed.url=url
return self
end

function EmbedBuilder:SetTimestamp(timestamp:string):EmbedBuilder__DARKLUA_TYPE_w
if type(timestamp)~="string"or timestamp==""then
error("timestamp must be a non-empty string",2)
end

local state=self::any
state.embed.timestamp=timestamp
return self
end

function EmbedBuilder:AddField(name:string,value:string,inline:boolean):EmbedBuilder__DARKLUA_TYPE_w
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

return EmbedBuilder end function __DARKLUA_BUNDLE_MODULES.q():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.q if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.q=v end return v.c end end do local function __modImpl()



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
}end function __DARKLUA_BUNDLE_MODULES.r():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.r if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.r=v end return v.c end end do local function __modImpl()



return{
Pong=1,
ChannelMessageWithSource=4,
DeferredChannelMessageWithSource=5,
DeferredUpdateMessage=6,
UpdateMessage=7,
ApplicationCommandAutocompleteResult=8,
Modal=9,
}end function __DARKLUA_BUNDLE_MODULES.s():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.s if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.s=v end return v.c end end do local function __modImpl()



return{
Crossposted=1,
IsCrosspost=2,
SuppressEmbeds=4,
SourceMessageDeleted=8,
Urgent=16,
HasThread=32,
Ephemeral=64,
Loading=128,
FailedToMentionSomeRolesInThread=256,
SuppressNotifications=4096,
IsVoiceMessage=8192,
HasSnapshot=16384,
IsComponentsV2=32768,
}end function __DARKLUA_BUNDLE_MODULES.t():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.t if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.t=v end return v.c end end do local function __modImpl()











local ModalBuilder={}
ModalBuilder.__index=ModalBuilder

local MAX_ACTION_ROWS=5

local function assertString(name:string,value:string,maxLength:number):()
if type(value)~="string"or value==""then
error(name.." must be a non-empty string",3)
end

if#value>maxLength then
error(name.." must be "..tostring(maxLength).." characters or fewer",3)
end
end

local function normalizeComponent(component:any):any
if type(component)~="table"then
error("modal component must be a table",3)
end

if type(component.Build)=="function"then
return component:Build()
end

return component
end

function ModalBuilder.new():ModalBuilder__DARKLUA_TYPE_x
local self={
modal={
components={}::{any},
}::{[string]:any},
}

return(setmetatable(self,ModalBuilder)::any)::ModalBuilder__DARKLUA_TYPE_x
end

function ModalBuilder:SetCustomId(customId:string):ModalBuilder__DARKLUA_TYPE_x
assertString("customId",customId,100)
local modal=(self::any).modal
modal.custom_id=customId
return self
end

function ModalBuilder:SetTitle(title:string):ModalBuilder__DARKLUA_TYPE_x
assertString("title",title,45)
local modal=(self::any).modal
modal.title=title
return self
end

function ModalBuilder:AddComponents(...:any):ModalBuilder__DARKLUA_TYPE_x
local modal=(self::any).modal
local components=table.pack(...)

for index=1,components.n do
if#modal.components>=MAX_ACTION_ROWS then
error("modals can contain at most five action rows",2)
end

table.insert(modal.components,normalizeComponent(components[index]))
end

return self
end

function ModalBuilder:SetComponents(components:{any}):ModalBuilder__DARKLUA_TYPE_x
if type(components)~="table"then
error("components must be a table",2)
end

if#components>MAX_ACTION_ROWS then
error("modals can contain at most five action rows",2)
end

local normalizedComponents:{any}={}
for _,component in ipairs(components)do
table.insert(normalizedComponents,normalizeComponent(component))
end

local modal=(self::any).modal
modal.components=normalizedComponents
return self
end

function ModalBuilder:Build():{[string]:any}
local modal=(self::any).modal

if type(modal.custom_id)~="string"or modal.custom_id==""then
error("modals require a customId",2)
end

if type(modal.title)~="string"or modal.title==""then
error("modals require a title",2)
end

if#modal.components<1 then
error("modals require at least one action row",2)
end

local output:{[string]:any}={}
for key,value in pairs(modal)do
output[key]=value
end

return output
end

return ModalBuilder end function __DARKLUA_BUNDLE_MODULES.u():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.u if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.u=v end return v.c end end do local function __modImpl()











local SelectMenuOptionBuilder={}
SelectMenuOptionBuilder.__index=SelectMenuOptionBuilder

local function assertString(name:string,value:string,maxLength:number):()
if type(value)~="string"or value==""then
error(name.." must be a non-empty string",3)
end

if#value>maxLength then
error(name.." must be "..tostring(maxLength).." characters or fewer",3)
end
end

function SelectMenuOptionBuilder.new():SelectMenuOptionBuilder__DARKLUA_TYPE_y
local self={
option={}::{[string]:any},
}

return(setmetatable(self,SelectMenuOptionBuilder)::any)::SelectMenuOptionBuilder__DARKLUA_TYPE_y
end

function SelectMenuOptionBuilder:SetLabel(label:string):SelectMenuOptionBuilder__DARKLUA_TYPE_y
assertString("label",label,100)
local state=self::any
state.option.label=label
return self
end

function SelectMenuOptionBuilder:SetValue(value:string):SelectMenuOptionBuilder__DARKLUA_TYPE_y
assertString("value",value,100)
local state=self::any
state.option.value=value
return self
end

function SelectMenuOptionBuilder:SetDescription(description:string):SelectMenuOptionBuilder__DARKLUA_TYPE_y
assertString("description",description,100)
local state=self::any
state.option.description=description
return self
end

function SelectMenuOptionBuilder:SetDefault(defaultValue:boolean):SelectMenuOptionBuilder__DARKLUA_TYPE_y
if type(defaultValue)~="boolean"then
error("defaultValue must be a boolean",2)
end

local state=self::any
state.option.default=defaultValue
return self
end

function SelectMenuOptionBuilder:Build():{[string]:any}
local option=(self::any).option

if type(option.label)~="string"or option.label==""then
error("select menu option label is required",2)
end

if type(option.value)~="string"or option.value==""then
error("select menu option value is required",2)
end

local output:{[string]:any}={}
for key,value in pairs(option)do
output[key]=value
end

return output
end

return SelectMenuOptionBuilder end function __DARKLUA_BUNDLE_MODULES.v():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.v if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.v=v end return v.c end end do local function __modImpl()










local SectionBuilder={}
SectionBuilder.__index=SectionBuilder

local COMPONENT_TYPE_SECTION=9
local MAX_TEXT_COMPONENTS=3

local function normalizeComponent(component:any):any
if type(component)~="table"then
error("section component must be a table",3)
end

if type(component.Build)=="function"then
return component:Build()
end

return component
end

function SectionBuilder.new():SectionBuilder__DARKLUA_TYPE_z
local self={
component={
type=COMPONENT_TYPE_SECTION,
components={}::{any},
}::{[string]:any},
}

return(setmetatable(self,SectionBuilder)::any)::SectionBuilder__DARKLUA_TYPE_z
end

function SectionBuilder:AddComponents(...:any):SectionBuilder__DARKLUA_TYPE_z
local component=(self::any).component
local components=table.pack(...)

for index=1,components.n do
if#component.components>=MAX_TEXT_COMPONENTS then
error("sections can contain at most three text components",2)
end

table.insert(component.components,normalizeComponent(components[index]))
end

return self
end

function SectionBuilder:SetComponents(components:{any}):SectionBuilder__DARKLUA_TYPE_z
if type(components)~="table"then
error("components must be a table",2)
end

if#components>MAX_TEXT_COMPONENTS then
error("sections can contain at most three text components",2)
end

local normalizedComponents:{any}={}
for _,component in ipairs(components)do
table.insert(normalizedComponents,normalizeComponent(component))
end

local component=(self::any).component
component.components=normalizedComponents
return self
end

function SectionBuilder:SetAccessory(accessory:any):SectionBuilder__DARKLUA_TYPE_z
local component=(self::any).component
component.accessory=normalizeComponent(accessory)
return self
end

function SectionBuilder:Build():{[string]:any}
local component=(self::any).component

if#component.components<1 then
error("sections require at least one text component",2)
end

if type(component.accessory)~="table"then
error("sections require an accessory component",2)
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return SectionBuilder end function __DARKLUA_BUNDLE_MODULES.w():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.w if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.w=v end return v.c end end do local function __modImpl()









local SeparatorBuilder={}
SeparatorBuilder.__index=SeparatorBuilder

local COMPONENT_TYPE_SEPARATOR=14

function SeparatorBuilder.new():SeparatorBuilder__DARKLUA_TYPE_A
local self={
component={
type=COMPONENT_TYPE_SEPARATOR,
}::{[string]:any},
}

return(setmetatable(self,SeparatorBuilder)::any)::SeparatorBuilder__DARKLUA_TYPE_A
end

function SeparatorBuilder:SetDivider(divider:boolean):SeparatorBuilder__DARKLUA_TYPE_A
if type(divider)~="boolean"then
error("divider must be a boolean",2)
end

local component=(self::any).component
component.divider=divider
return self
end

function SeparatorBuilder:SetSpacing(spacing:number):SeparatorBuilder__DARKLUA_TYPE_A
if type(spacing)~="number"or(spacing~=1 and spacing~=2)then
error("spacing must be SeparatorSpacing.Small or SeparatorSpacing.Large",2)
end

local component=(self::any).component
component.spacing=spacing
return self
end

function SeparatorBuilder:Build():{[string]:any}
local component=(self::any).component
local output:{[string]:any}={}

for key,value in pairs(component)do
output[key]=value
end

return output
end

return SeparatorBuilder end function __DARKLUA_BUNDLE_MODULES.x():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.x if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.x=v end return v.c end end do local function __modImpl()



return{
Small=1,
Large=2,
}end function __DARKLUA_BUNDLE_MODULES.y():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.y if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.y=v end return v.c end end do local function __modImpl()
























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

local function addOption(self:SlashCommandBuilder__DARKLUA_TYPE_C,optionType:number,name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
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

function SlashCommandBuilder.new():SlashCommandBuilder__DARKLUA_TYPE_C
local self={
command={
type=1,
name=nil::string?,
description=nil::string?,
options={}::{SlashCommandOption__DARKLUA_TYPE_B},
},
}

return(setmetatable(self,SlashCommandBuilder)::any)::SlashCommandBuilder__DARKLUA_TYPE_C
end

function SlashCommandBuilder:SetName(name:string):SlashCommandBuilder__DARKLUA_TYPE_C
assertCommandName(name)
local state=self::any
state.command.name=name
return self
end

function SlashCommandBuilder:SetDescription(description:string):SlashCommandBuilder__DARKLUA_TYPE_C
assertDescription(description)
local state=self::any
state.command.description=description
return self
end

function SlashCommandBuilder:AddStringOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
return addOption(self,OptionType.String,name,description,required)
end

function SlashCommandBuilder:AddIntegerOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
return addOption(self,OptionType.Integer,name,description,required)
end

function SlashCommandBuilder:AddBooleanOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
return addOption(self,OptionType.Boolean,name,description,required)
end

function SlashCommandBuilder:AddUserOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
return addOption(self,OptionType.User,name,description,required)
end

function SlashCommandBuilder:AddChannelOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
return addOption(self,OptionType.Channel,name,description,required)
end

function SlashCommandBuilder:AddRoleOption(name:string,description:string,required:boolean):SlashCommandBuilder__DARKLUA_TYPE_C
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

return SlashCommandBuilder end function __DARKLUA_BUNDLE_MODULES.z():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.z if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.z=v end return v.c end end do local function __modImpl()














local StringSelectMenuBuilder={}
StringSelectMenuBuilder.__index=StringSelectMenuBuilder

local COMPONENT_TYPE_STRING_SELECT=3
local MAX_OPTIONS=25

local function assertString(name:string,value:string,maxLength:number):()
if type(value)~="string"or value==""then
error(name.." must be a non-empty string",3)
end

if#value>maxLength then
error(name.." must be "..tostring(maxLength).." characters or fewer",3)
end
end

local function normalizeOption(option:any):any
if type(option)~="table"then
error("select menu option must be a table",3)
end

if type(option.Build)=="function"then
return option:Build()
end

return option
end

function StringSelectMenuBuilder.new():StringSelectMenuBuilder__DARKLUA_TYPE_D
local self={
component={
type=COMPONENT_TYPE_STRING_SELECT,
options={}::{any},
}::{[string]:any},
}

return(setmetatable(self,StringSelectMenuBuilder)::any)::StringSelectMenuBuilder__DARKLUA_TYPE_D
end

function StringSelectMenuBuilder:SetCustomId(customId:string):StringSelectMenuBuilder__DARKLUA_TYPE_D
assertString("customId",customId,100)
local component=(self::any).component
component.custom_id=customId
return self
end

function StringSelectMenuBuilder:SetPlaceholder(placeholder:string):StringSelectMenuBuilder__DARKLUA_TYPE_D
assertString("placeholder",placeholder,150)
local component=(self::any).component
component.placeholder=placeholder
return self
end

function StringSelectMenuBuilder:SetMinValues(minValues:number):StringSelectMenuBuilder__DARKLUA_TYPE_D
if type(minValues)~="number"or minValues<0 or minValues>25 then
error("minValues must be a number from 0 to 25",2)
end

local component=(self::any).component
component.min_values=minValues
return self
end

function StringSelectMenuBuilder:SetMaxValues(maxValues:number):StringSelectMenuBuilder__DARKLUA_TYPE_D
if type(maxValues)~="number"or maxValues<1 or maxValues>25 then
error("maxValues must be a number from 1 to 25",2)
end

local component=(self::any).component
component.max_values=maxValues
return self
end

function StringSelectMenuBuilder:SetDisabled(disabled:boolean):StringSelectMenuBuilder__DARKLUA_TYPE_D
if type(disabled)~="boolean"then
error("disabled must be a boolean",2)
end

local component=(self::any).component
component.disabled=disabled
return self
end

function StringSelectMenuBuilder:AddOptions(...:any):StringSelectMenuBuilder__DARKLUA_TYPE_D
local component=(self::any).component
local options=table.pack(...)

for index=1,options.n do
if#component.options>=MAX_OPTIONS then
error("string select menus can contain at most 25 options",2)
end

table.insert(component.options,normalizeOption(options[index]))
end

return self
end

function StringSelectMenuBuilder:SetOptions(options:{any}):StringSelectMenuBuilder__DARKLUA_TYPE_D
if type(options)~="table"then
error("options must be a table",2)
end

if#options>MAX_OPTIONS then
error("string select menus can contain at most 25 options",2)
end

local normalizedOptions:{any}={}
for _,option in ipairs(options)do
table.insert(normalizedOptions,normalizeOption(option))
end

local component=(self::any).component
component.options=normalizedOptions
return self
end

function StringSelectMenuBuilder:Build():{[string]:any}
local component=(self::any).component

if type(component.custom_id)~="string"or component.custom_id==""then
error("string select menus require a customId",2)
end

if#component.options<1 then
error("string select menus require at least one option",2)
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return StringSelectMenuBuilder end function __DARKLUA_BUNDLE_MODULES.A():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.A if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.A=v end return v.c end end do local function __modImpl()















local TextInputBuilder={}
TextInputBuilder.__index=TextInputBuilder

local COMPONENT_TYPE_TEXT_INPUT=4

local function assertString(name:string,value:string,maxLength:number):()
if type(value)~="string"or value==""then
error(name.." must be a non-empty string",3)
end

if#value>maxLength then
error(name.." must be "..tostring(maxLength).." characters or fewer",3)
end
end

function TextInputBuilder.new():TextInputBuilder__DARKLUA_TYPE_E
local self={
component={
type=COMPONENT_TYPE_TEXT_INPUT,
}::{[string]:any},
}

return(setmetatable(self,TextInputBuilder)::any)::TextInputBuilder__DARKLUA_TYPE_E
end

function TextInputBuilder:SetCustomId(customId:string):TextInputBuilder__DARKLUA_TYPE_E
assertString("customId",customId,100)
local component=(self::any).component
component.custom_id=customId
return self
end

function TextInputBuilder:SetLabel(label:string):TextInputBuilder__DARKLUA_TYPE_E
assertString("label",label,45)
local component=(self::any).component
component.label=label
return self
end

function TextInputBuilder:SetStyle(style:number):TextInputBuilder__DARKLUA_TYPE_E
if type(style)~="number"or(style~=1 and style~=2)then
error("text input style must be 1 or 2",2)
end

local component=(self::any).component
component.style=style
return self
end

function TextInputBuilder:SetMinLength(minLength:number):TextInputBuilder__DARKLUA_TYPE_E
if type(minLength)~="number"or minLength<0 or minLength>4000 then
error("minLength must be a number from 0 to 4000",2)
end

local component=(self::any).component
component.min_length=minLength
return self
end

function TextInputBuilder:SetMaxLength(maxLength:number):TextInputBuilder__DARKLUA_TYPE_E
if type(maxLength)~="number"or maxLength<1 or maxLength>4000 then
error("maxLength must be a number from 1 to 4000",2)
end

local component=(self::any).component
component.max_length=maxLength
return self
end

function TextInputBuilder:SetRequired(required:boolean):TextInputBuilder__DARKLUA_TYPE_E
if type(required)~="boolean"then
error("required must be a boolean",2)
end

local component=(self::any).component
component.required=required
return self
end

function TextInputBuilder:SetValue(value:string):TextInputBuilder__DARKLUA_TYPE_E
assertString("value",value,4000)
local component=(self::any).component
component.value=value
return self
end

function TextInputBuilder:SetPlaceholder(placeholder:string):TextInputBuilder__DARKLUA_TYPE_E
assertString("placeholder",placeholder,100)
local component=(self::any).component
component.placeholder=placeholder
return self
end

function TextInputBuilder:Build():{[string]:any}
local component=(self::any).component

if type(component.custom_id)~="string"or component.custom_id==""then
error("text inputs require a customId",2)
end

if type(component.label)~="string"or component.label==""then
error("text inputs require a label",2)
end

if type(component.style)~="number"then
error("text inputs require a style",2)
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return TextInputBuilder end function __DARKLUA_BUNDLE_MODULES.B():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.B if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.B=v end return v.c end end do local function __modImpl()



return{
Short=1,
Paragraph=2,
}end function __DARKLUA_BUNDLE_MODULES.C():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.C if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.C=v end return v.c end end do local function __modImpl()








local TextDisplayBuilder={}
TextDisplayBuilder.__index=TextDisplayBuilder

local COMPONENT_TYPE_TEXT_DISPLAY=10

function TextDisplayBuilder.new():TextDisplayBuilder__DARKLUA_TYPE_F
local self={
component={
type=COMPONENT_TYPE_TEXT_DISPLAY,
}::{[string]:any},
}

return(setmetatable(self,TextDisplayBuilder)::any)::TextDisplayBuilder__DARKLUA_TYPE_F
end

function TextDisplayBuilder:SetContent(content:string):TextDisplayBuilder__DARKLUA_TYPE_F
if type(content)~="string"or content==""then
error("content must be a non-empty string",2)
end

if#content>4000 then
error("content must be 4000 characters or fewer",2)
end

local component=(self::any).component
component.content=content
return self
end

function TextDisplayBuilder:Build():{[string]:any}
local component=(self::any).component

if type(component.content)~="string"or component.content==""then
error("text displays require content",2)
end

local output:{[string]:any}={}
for key,value in pairs(component)do
output[key]=value
end

return output
end

return TextDisplayBuilder end function __DARKLUA_BUNDLE_MODULES.D():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.D if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.D=v end return v.c end end end



local ActionRowBuilder=__DARKLUA_BUNDLE_MODULES.a()
local ButtonBuilder=__DARKLUA_BUNDLE_MODULES.b()
local ButtonStyle=__DARKLUA_BUNDLE_MODULES.c()
local Client=__DARKLUA_BUNDLE_MODULES.o()
local ContainerBuilder=__DARKLUA_BUNDLE_MODULES.p()
local EmbedBuilder=__DARKLUA_BUNDLE_MODULES.q()
local GatewayOpcode=__DARKLUA_BUNDLE_MODULES.e()
local Intents=__DARKLUA_BUNDLE_MODULES.r()
local InteractionResponseType=__DARKLUA_BUNDLE_MODULES.s()
local Interaction=__DARKLUA_BUNDLE_MODULES.j()
local Message=__DARKLUA_BUNDLE_MODULES.k()
local MessageFlags=__DARKLUA_BUNDLE_MODULES.t()
local ModalBuilder=__DARKLUA_BUNDLE_MODULES.u()
local RestClient=__DARKLUA_BUNDLE_MODULES.n()
local SessionStore=__DARKLUA_BUNDLE_MODULES.g()
local SelectMenuOptionBuilder=__DARKLUA_BUNDLE_MODULES.v()
local SectionBuilder=__DARKLUA_BUNDLE_MODULES.w()
local SeparatorBuilder=__DARKLUA_BUNDLE_MODULES.x()
local SeparatorSpacing=__DARKLUA_BUNDLE_MODULES.y()
local SlashCommandBuilder=__DARKLUA_BUNDLE_MODULES.z()
local StringSelectMenuBuilder=__DARKLUA_BUNDLE_MODULES.A()
local TextInputBuilder=__DARKLUA_BUNDLE_MODULES.B()
local TextInputStyle=__DARKLUA_BUNDLE_MODULES.C()
local TextDisplayBuilder=__DARKLUA_BUNDLE_MODULES.D()

return{
ActionRowBuilder=ActionRowBuilder,
ButtonBuilder=ButtonBuilder,
ButtonStyle=ButtonStyle,
Client=Client,
ContainerBuilder=ContainerBuilder,
EmbedBuilder=EmbedBuilder,
GatewayOpcode=GatewayOpcode,
Interaction=Interaction,
Intents=Intents,
InteractionResponseType=InteractionResponseType,
Message=Message,
MessageFlags=MessageFlags,
ModalBuilder=ModalBuilder,
RestClient=RestClient,
SelectMenuOptionBuilder=SelectMenuOptionBuilder,
SectionBuilder=SectionBuilder,
SeparatorBuilder=SeparatorBuilder,
SeparatorSpacing=SeparatorSpacing,
SessionStore=SessionStore,
SlashCommandBuilder=SlashCommandBuilder,
StringSelectMenuBuilder=StringSelectMenuBuilder,
TextDisplayBuilder=TextDisplayBuilder,
TextInputBuilder=TextInputBuilder,
TextInputStyle=TextInputStyle,
}