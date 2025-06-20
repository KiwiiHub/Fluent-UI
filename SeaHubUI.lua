	if getgenv().Tvk then 
		if game.CoreGui:FindFirstChild("Sea Hub GUI") then for i, v in ipairs(game.CoreGui:GetChildren()) do if v.Name == "Sea Hub GUI" then v:Destroy() end end end
	end
	getgenv().Tvk = true
	local IndexUIColor = {
		["Border Color"] = Color3.fromRGB(131, 181, 255),
		["Click Effect Color"] = Color3.fromRGB(230, 230, 230),
		["Setting Icon Color"] = Color3.fromRGB(230, 230, 230),
		["Logo Image"] = "rbxassetid://6248942117",
		["Search Icon Color"] = Color3.fromRGB(255, 255, 255),
		["Search Icon Highlight Color"] = Color3.fromRGB(131, 181, 255),
		["GUI Text Color"] = Color3.fromRGB(230, 230, 230),
		["Text Color"] = Color3.fromRGB(230, 230, 230),
		["Placeholder Text Color"] = Color3.fromRGB(178, 178, 178),
		["Title Text Color"] = Color3.fromRGB(131, 181, 255),
		["Background 1 Color"] = Color3.fromRGB(43, 43, 43),
		["Background 1 Transparency"] = 0,
		["Background 2 Color"] = Color3.fromRGB(90, 90, 90),
		["Background 3 Color"] = Color3.fromRGB(53, 53, 53),
		["Background Image"] = "",
		["Page Selected Color"] = Color3.fromRGB(131, 181, 255),
		["Section Text Color"] = Color3.fromRGB(131, 181, 255),
		["Section Underline Color"] = Color3.fromRGB(131, 181, 255),
		["Toggle Border Color"] = Color3.fromRGB(131, 181, 255),
		["Toggle Checked Color"] = Color3.fromRGB(230, 230, 230),
		["Toggle Desc Color"] = Color3.fromRGB(185, 185, 185),
		["Button Color"] = Color3.fromRGB(131, 181, 255),
		["Label Color"] = Color3.fromRGB(101, 152, 220),
		["Dropdown Icon Color"] = Color3.fromRGB(230, 230, 230),
		["Dropdown Selected Color"] = Color3.fromRGB(131, 181, 255),
		["Textbox Highlight Color"] = Color3.fromRGB(131, 181, 255),
		["Box Highlight Color"] = Color3.fromRGB(131, 181, 255),
		["Slider Line Color"] = Color3.fromRGB(75, 75, 75),
		["Slider Highlight Color"] = Color3.fromRGB(59, 82, 115),
		["Tween Animation 1 Speed"] = 0.25,
		["Tween Animation 2 Speed"] = 0.5,
		["Tween Animation 3 Speed"] = 0.1,
	}
	local UpdateCallBack = {}
	for k,v in pairs(IndexUIColor) do 
		UpdateCallBack[k] = {}
	end
	local SettingsRac = {}
	for k,v in pairs(IndexUIColor) do 
		SettingsRac[k] = {
			Color = v,
			Rainbow = false,
			Breathing = {
				Toggle = false,
				Color1 = Color3.new(),
				Color2 = Color3.new()
			}
		}
	end
	local function Rac(color)
		return {math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), "Dit"}
	end
	function CorrectTable(tabl)
		local ret = {}
		for k, v in pairs(tabl) do 
			if typeof(v) == "Color3" then 
				ret[k] = Rac(v)
			elseif type(v) == "table" then
				ret[k] = CorrectTable(v)
			else
				ret[k] = v
			end
		end
		return ret
	end
	function DCorrectTable(tabl)
		local ret = {}
		for k,v in pairs(tabl) do 
			if type(v) == "table" and v[4] == "Dit" then 
				ret[k] = Color3.fromRGB(unpack(v))
			elseif type(v) == "table" then
				ret[k] = DCorrectTable(v)
			else
				ret[k] = v
			end
		end
		return ret
	end
	local HttpService = game:GetService("HttpService")
	local SaveCustomFileName = "!CustomUI.json"
	function SaveCustomUISettings()
		local HttpService = game:GetService("HttpService")
		if not isfolder("Sea Hub") then
			makefolder("Sea Hub")
		end
		writefile("Sea Hub/" .. SaveCustomFileName, HttpService:JSONEncode(CorrectTable(SettingsRac)))
	end
	function ReadCustomUISetting() 
		local s,e = pcall(function() 
			local HttpService = game:GetService("HttpService")
			if not isfolder("Sea Hub") then
				makefolder("Sea Hub")
			end
			return HttpService:JSONDecode(readfile("Sea Hub/" .. SaveCustomFileName))
		end)
		if s then return e 
		else
			SaveCustomUISettings()
			return ReadCustomUISetting()
		end
	end
	SettingsRac=DCorrectTable(ReadCustomUISetting())
	for k,v in pairs(SettingsRac) do 
		IndexUIColor[k]=v.Color
	end
	if not getgenv().ractvkretarddumb then
		spawn(function() 
			while wait(1) do
				SaveCustomUISettings()
			end
		end)
		getgenv().ractvkretarddumb = true
	end
	getgenv().UIColor=setmetatable({},{
		__newindex=function(Self, Key, Value) 
			if UpdateCallBack[Key] then 
				for k, v in pairs(UpdateCallBack[Key]) do 
					v()
				end
			end
			rawset(IndexUIColor,Key,Value)
			SettingsRac[Key].Color = Value
		end,
		__index = IndexUIColor
	})
	local currcolor = {}
	local Library = {};
	local Library_Function = {}
	local TweenService = game:GetService('TweenService')
	local uis = game:GetService("UserInputService")
	--Button Effect
	function Library_Function.ButtonEffect()
		local mouse = game:GetService("Players").LocalPlayer:GetMouse();
		local buttoneffect = Drawing.new("Circle")
		buttoneffect.Visible = true
		buttoneffect.Radius = 10
		buttoneffect.Filled = true
		buttoneffect.Color = getgenv().UIColor["Click Effect Color"]
		buttoneffect.Position = Vector2.new(mouse.X, mouse.Y + 35)
		local BuoiFolder = Instance.new('Folder')
		BuoiFolder.Parent = Library_Function.gui
		BuoiFolder.Name = 'Game nhu buoi'
		local a = Instance.new('NumberValue')
		a.Value = 10
		a.Parent = BuoiFolder
		a.Name = 'Rua nhu buoi'
		local b = Instance.new('NumberValue')
		b.Value = 1
		b.Parent = BuoiFolder
		b.Name = 'Rua nhu buoi 2'
		TweenService:Create(a,TweenInfo.new(.25),{Value = 25}):Play()
		TweenService:Create(b,TweenInfo.new(.25),{Value = 0}):Play()
		a:GetPropertyChangedSignal('Value'):Connect(function()
			buttoneffect.Radius = a.Value
		end)
		b:GetPropertyChangedSignal('Value'):Connect(function()
			buttoneffect.Transparency = b.Value
		end)
		wait(.5)
		BuoiFolder:Destroy()
	end
	Library_Function.GetIMG = function(url)
		local File = 'SynAsset ['
		local returnimage = ""
		if string.find(url, "rbxassetid://") then
			returnimage = url
		else
			pcall(function()
				if url and type(url) == 'string' and tostring(game:HttpGet(url)):find('PNG') then
					for i = 1, 5 do
						File = tostring(File..string.char(math.random(65, 122)))
					end
					File = File..'].png'
					writefile(File, game:HttpGet(url))
					spawn(function()
						wait(5)
						delfile(File)
					end)
					returnimage = getsynasset(File)
				end
			end)
		end
		return returnimage
	end
	Library_Function.Gui = Instance.new('ScreenGui')
	Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Library_Function.Gui.Name = 'Sea Hub GUI'
	getgenv().ReadyForGuiLoaded = false
	spawn(function()
		Library_Function.Gui.Enabled = false
		repeat wait()
		until getgenv().ReadyForGuiLoaded
		Library_Function.Gui.Enabled = true
	end)
	Library_Function.NotiGui = Instance.new('ScreenGui')
	Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Library_Function.NotiGui.Name = 'Sea Hub Notification'
	local NotiContainer = Instance.new("Frame")
	local NotiList = Instance.new("UIListLayout")
	NotiContainer.Name = "NotiContainer"
	NotiContainer.Parent = Library_Function.NotiGui
	NotiContainer.AnchorPoint = Vector2.new(1, 1)
	NotiContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	NotiContainer.BackgroundTransparency = 1.000
	NotiContainer.Position = UDim2.new(1, -5, 1, -5)
	NotiContainer.Size = UDim2.new(0, 350, 1, -10)
	NotiList.Name = "NotiList"
	NotiList.Parent = NotiContainer
	NotiList.SortOrder = Enum.SortOrder.LayoutOrder
	NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotiList.Padding = UDim.new(0, 5)
	Library_Function.Gui.Parent = game:GetService('CoreGui')
	Library_Function.NotiGui.Parent = game:GetService('CoreGui')
	function Library_Function.Getcolor(color)
		return {math.floor(color.r*255),math.floor(color.g*255),math.floor(color.b*255)}
	end
	function Library.CreateNoti(Setting)
		getgenv().TitleNameNoti = Setting.Title or ""; 
		local Desc = Setting.Desc; 
		local Timeshow = Setting.ShowTime or 10;
		local NotiFrame = Instance.new("Frame")
		local Noticontainer = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Topnoti = Instance.new("Frame")
		local Ruafimg = Instance.new("ImageLabel")
		local RuafimgCorner = Instance.new("UICorner")
		local TextLabelNoti = Instance.new("TextLabel")
		local CloseContainer = Instance.new("Frame")
		local CloseImage = Instance.new("ImageLabel")
		local TextButton = Instance.new("TextButton")
		local TextLabelNoti2 = Instance.new("TextLabel")
		NotiFrame.Name = "NotiFrame"
		NotiFrame.Parent = NotiContainer
		NotiFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		NotiFrame.BackgroundTransparency = 1.000
		NotiFrame.ClipsDescendants = true
		NotiFrame.Position = UDim2.new(0, 0, 0, 0)
		NotiFrame.Size = UDim2.new(1, 0, 0, 0)
		NotiFrame.AutomaticSize = Enum.AutomaticSize.Y
		Noticontainer.Name = "Noticontainer"
		Noticontainer.Parent = NotiFrame
		Noticontainer.Position = UDim2.new(1, 0, 0, 0)
		Noticontainer.Size = UDim2.new(1, 0, 1, 6)
		Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
		Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
		table.insert(UpdateCallBack["Background 3 Color"],function() 
			Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
		end)
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Noticontainer
		Topnoti.Name = "Topnoti"
		Topnoti.Parent = Noticontainer
		Topnoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Topnoti.BackgroundTransparency = 1.000
		Topnoti.Position = UDim2.new(0, 0, 0, 5)
		Topnoti.Size = UDim2.new(1, 0, 0, 25)
		Ruafimg.Name = "Ruafimg"
		Ruafimg.Parent = Topnoti
		Ruafimg.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Ruafimg.BackgroundTransparency = 1.000
		Ruafimg.Position = UDim2.new(0, 10, 0, 0)
		Ruafimg.Size = UDim2.new(0, 25, 0, 25)
		Ruafimg.Image = getgenv().UIColor["Logo Image"]
		table.insert(UpdateCallBack["Logo Image"], function() 
			Ruafimg.Image = Library_Function.GetIMG(getgenv().UIColor["Logo Image"])
		end)
		RuafimgCorner.CornerRadius = UDim.new(1, 0)
		RuafimgCorner.Name = "RuafimgCorner"
		RuafimgCorner.Parent = Ruafimg
		local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
		local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
		local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
		local color = colorR .. ',' .. colorG .. ',' .. colorB
		TextLabelNoti.Text = "<font color=\"rgb(" .. color .. ")\">Sea Hub</font> "..getgenv().TitleNameNoti
		table.insert(UpdateCallBack["Title Text Color"],function() 
			local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
			local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
			local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
			local color = colorR .. ',' .. colorG .. ',' .. colorB
			TextLabelNoti.Text = "<font color=\"rgb(" .. color .. ")\">Sea Hub</font> "..getgenv().TitleNameNoti
		end)
		TextLabelNoti.Name = "TextLabelNoti"
		TextLabelNoti.Parent = Topnoti
		TextLabelNoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelNoti.BackgroundTransparency = 1.000
		TextLabelNoti.Position = UDim2.new(0, 40, 0, 0)
		TextLabelNoti.Size = UDim2.new(1, -40, 1, 0)
		TextLabelNoti.Font = Enum.Font.GothamBold
		TextLabelNoti.TextSize = 14.000
		TextLabelNoti.TextWrapped = true
		TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti.RichText = true
		TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]
		table.insert(UpdateCallBack["GUI Text Color"], function() 
			TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]
		end)
		CloseContainer.Name = "CloseContainer"
		CloseContainer.Parent = Topnoti
		CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
		CloseContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		CloseContainer.BackgroundTransparency = 1.000
		CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
		CloseContainer.Size = UDim2.new(0, 22, 0, 22)
		CloseImage.Name = "CloseImage"
		CloseImage.Parent = CloseContainer
		CloseImage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		CloseImage.BackgroundTransparency = 1.000
		CloseImage.Size = UDim2.new(1, 0, 1, 0)
		CloseImage.Image = "rbxassetid://3926305904"
		CloseImage.ImageRectOffset = Vector2.new(284, 4)
		CloseImage.ImageRectSize = Vector2.new(24, 24)
		CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]
		table.insert(UpdateCallBack["Search Icon Color"],function() 
			CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]
		end)
		TextButton.Parent = CloseContainer
		TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextButton.BackgroundTransparency = 1.000
		TextButton.Size = UDim2.new(1, 0, 1, 0)
		TextButton.Font = Enum.Font.SourceSans
		TextButton.Text = ""
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.TextSize = 14.000
		if Desc then
			TextLabelNoti2.Name = 'TextColor'
			TextLabelNoti2.Parent = Noticontainer
			TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TextLabelNoti2.BackgroundTransparency = 1.000
			TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
			TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
			TextLabelNoti2.Font = Enum.Font.GothamBold
			TextLabelNoti2.Text = Desc
			TextLabelNoti2.TextSize = 14.000
			TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabelNoti2.RichText = true
			TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
			TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
			TextLabelNoti2.TextWrapped = true
			table.insert(UpdateCallBack["Text Color"],function() 
				TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
			end)
		end
		local function remove()
			TweenService:Create(Noticontainer,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Position = UDim2.new(1,0,0,0)}):Play()
			wait(.25)
			NotiFrame:Destroy()
		end
		TweenService:Create(Noticontainer,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Position = UDim2.new(0,0,0,0)}):Play()
		TextButton.MouseEnter:Connect(function()
			TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]}):Play()
		end)
		TextButton.MouseLeave:Connect(function()
			TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Color"]}):Play()
		end)
		TextButton.MouseButton1Click:Connect(function()
			spawn(function() Library_Function.ButtonEffect() end)
			wait(.25)
			remove()
		end)
		spawn(function()
			wait(Timeshow)
			remove()
		end)
	end
	function Library.CreateMain(Setting)
		local TitleNameMain = tostring(Setting.Title) or "Sea Hub"
		getgenv().MainDesc = Setting.Desc or ""
		local djtmemay = false
		cac = false
		local function makeDraggable(topBarObject, object)
			local dragging = nil
			local dragInput = nil
			local dragStart = nil
			local startPosition = nil
			topBarObject.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPosition = object.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)
			topBarObject.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			uis.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					local delta = input.Position - dragStart
					if not djtmemay and cac then
						TweenService:Create(object, TweenInfo.new(0.35,Enum.EasingStyle.Linear,Enum.EasingDirection.Out), {
							Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
						}):Play()
					elseif not djtmemay and not cac then
						object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
					end
				end
			end)
		end
		local Main = Instance.new("Frame")
		local maingui = Instance.new("ImageLabel")
		local MainCorner = Instance.new("UICorner")
		local TopMain = Instance.new("Frame")
		local Ruafimg = Instance.new("ImageLabel")
		local TextLabelMain = Instance.new("TextLabel")
		local PageControl = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ControlList = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local ControlTitle = Instance.new("TextLabel")
		local MainPage = Instance.new("Frame")
		local UIPage = Instance.new("UIPageLayout")
		local SettionMain = Instance.new("Frame")
		local SettionButton = Instance.new("TextButton")
		local SettingIcon = Instance.new("ImageLabel")
		local Concacontainer = Instance.new("Frame")
		local Concacmain = Instance.new("Frame")
		local Concacmain1 = Instance.new("Frame")
		local Concacpage = Instance.new("UIPageLayout")
		local MainContainer
		Main.Name = "Main"
		Main.Parent = Library_Function.Gui
		Main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		Main.BackgroundTransparency = 1.000
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		Main.AnchorPoint = Vector2.new(0.5, 0.5)
		Main.Size = UDim2.new(0, 629, 0, 359)
		makeDraggable(Main, Main)
		maingui.Name = "maingui"
		maingui.Parent = Main
		maingui.AnchorPoint = Vector2.new(0.5, 0.5)
		maingui.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		maingui.BackgroundTransparency = 1.000
		maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
		maingui.Selectable = true
		maingui.Size = UDim2.new(1, 30, 1, 30)
		maingui.Image = "rbxassetid://8068653048"
		maingui.ScaleType = Enum.ScaleType.Slice
		maingui.SliceCenter = Rect.new(15, 15, 175, 175)
		maingui.SliceScale = 1.300
		maingui.ImageColor3 = getgenv().UIColor["Border Color"]
		table.insert(UpdateCallBack["Border Color"],function() 
			maingui.ImageColor3 = getgenv().UIColor["Border Color"]
		end)
		function Library_Function.ReloadMain(v)
			maingui.ImageColor3 = getgenv().UIColor['Title Text Color']
			local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
			local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
			local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
			local color = colorR .. ',' .. colorG .. ',' .. colorB
			TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
			table.insert(UpdateCallBack["Title Text Color"],function() 
				maingui.ImageColor3 = getgenv().UIColor['Title Text Color']
				local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
				local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
				local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
				local color = colorR .. ',' .. colorG .. ',' .. colorB
				TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
			end)
			local MainContainer_
			if v ~= ""
			and type(v) == 'string'
			and string.find(v:lower(), ".webm")
			and pcall(function() writefile("seahub.webm", http_request({Url=v}).Body) end) then
				wait(.25)
				local sus = isfile("seahub.webm")
				wait(.25)
				if sus then
					MainContainer_ = Instance.new("VideoFrame")  
					MainContainer_.Name = "MainContainer"
					MainContainer_.Parent = Main
					MainContainer_.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
					MainContainer_.Size = UDim2.new(1, 0, 1, 0)
					MainContainer_.Video = getsynasset("seahub.webm")
					MainContainer_.Looped = true
					MainContainer_:Play()
					wait(.5)
					delfile('seahub.webm')
				end
			else
				MainContainer_ = Instance.new("ImageLabel")
				MainContainer_.Name = "MainContainer"
				MainContainer_.Parent = Main
				MainContainer_.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				MainContainer_.Size = UDim2.new(1, 0, 1, 0)
				MainContainer_.Image = Library_Function.GetIMG(v)
			end
			MainCorner_ = Instance.new("UICorner")
			MainCorner_.CornerRadius = UDim.new(0, 4)
			MainCorner_.Name = "MainCorner"
			MainCorner_.Parent = MainContainer_
			for i,e in next, Main:GetChildren() do 
				if e.Name == "MainContainer" then
					for i,v in next, e:GetChildren() do
						v.Parent = MainContainer_
					end
					wait()
					e:Destroy()
					break
				end
			end
			table.insert(UpdateCallBack["Background 3 Color"],function() 
				MainContainer_.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
			end)
		end
		maingui.ImageColor3 = getgenv().UIColor['Title Text Color']
		local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
		local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
		local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
		local color = colorR .. ',' .. colorG .. ',' .. colorB
		TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
		table.insert(UpdateCallBack["Title Text Color"],function() 
			maingui.ImageColor3 = getgenv().UIColor['Title Text Color']
			local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
			local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
			local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
			local color = colorR .. ',' .. colorG .. ',' .. colorB
			TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
		end)
		local MainContainer
		local defurl = getgenv().UIColor["Background Image"]
		if defurl ~= ""
		and type(defurl) == 'string'
		and string.find(defurl:lower(), ".webm")
		and pcall(function() writefile("seahub.webm", http_request({Url=defurl}).Body) end) then
			wait(.25)
			local sus = isfile("seahub.webm")
			wait(.25)
			if sus then
				MainContainer = Instance.new("VideoFrame")  
				MainContainer.Name = "MainContainer"
				MainContainer.Parent = Main
				MainContainer.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				MainContainer.Size = UDim2.new(1, 0, 1, 0)
				MainContainer.Video = getsynasset("seahub.webm")
				MainContainer.Looped = true
				MainContainer:Play()
				wait(.5)
				delfile('seahub.webm')
			end
		else
			MainContainer = Instance.new("ImageLabel")
			MainContainer.Name = "MainContainer"
			MainContainer.Parent = Main
			MainContainer.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
			MainContainer.Size = UDim2.new(1, 0, 1, 0)
			MainContainer.Image = Library_Function.GetIMG(defurl)
		end
		table.insert(UpdateCallBack["Background 3 Color"],function() 
			MainContainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
		end)
		getgenv().ReadyForGuiLoaded = true
		MainCorner.CornerRadius = UDim.new(0, 4)
		MainCorner.Name = "MainCorner"
		MainCorner.Parent = MainContainer
		Concacontainer.Name = "Concacontainer"
		Concacontainer.Parent = MainContainer
		Concacontainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Concacontainer.BackgroundTransparency = 1.000
		Concacontainer.ClipsDescendants = true
		Concacontainer.Position = UDim2.new(0, 0, 0, 30)
		Concacontainer.Size = UDim2.new(1, 0, 1, -30)
		Concacmain.Name = "Concacmain"
		Concacmain.Parent = Concacontainer
		Concacmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Concacmain.BackgroundTransparency = 1.000
		Concacmain.Selectable = true
		Concacmain.Size = UDim2.new(1, 0, 1, 0)
		Concacmain1.Name = "Background1"
		Concacmain1.Parent = Concacontainer
		Concacmain1.LayoutOrder = 1
		Concacmain1.Selectable = true
		Concacmain1.Size = UDim2.new(1, 0, 1, 0)
		Concacmain1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
		table.insert(UpdateCallBack["Background 1 Transparency"],function() 
			Concacmain1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
		end)
		Concacmain1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		table.insert(UpdateCallBack["Background 1 Color"],function() 
			Concacmain1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		end)
		Concacpage.Name = "Concacpage"
		Concacpage.Parent = Concacontainer
		Concacpage.SortOrder = Enum.SortOrder.LayoutOrder
		Concacpage.EasingDirection = Enum.EasingDirection.InOut
		Concacpage.EasingStyle = Enum.EasingStyle.Quad
		Concacpage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]
		table.insert(UpdateCallBack["Tween Animation 1 Speed"], function() 
			Concacpage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]
		end)
		TopMain.Name = "TopMain"
		TopMain.Parent = MainContainer
		TopMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopMain.BackgroundTransparency = 1.000
		TopMain.Size = UDim2.new(1, 0, 0, 25)
		Ruafimg.Name = "Ruafimg"
		Ruafimg.Parent = TopMain
		Ruafimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ruafimg.BackgroundTransparency = 1.000
		Ruafimg.Position = UDim2.new(0, 5, 0, 0)
		Ruafimg.Size = UDim2.new(0, 25, 0, 25)
		Ruafimg.Image = getgenv().UIColor["Logo Image"]
		table.insert(UpdateCallBack["Logo Image"],function() 
			Ruafimg.Image = getgenv().UIColor["Logo Image"]
		end)
		TextLabelMain.Name = "TextLabelMain"
		TextLabelMain.Parent = TopMain
		TextLabelMain.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelMain.BackgroundTransparency = 1.000
		TextLabelMain.Position = UDim2.new(0, 35, 0, 0)
		TextLabelMain.Size = UDim2.new(1, -35, 1, 0)
		TextLabelMain.Font = Enum.Font.GothamBold
		TextLabelMain.RichText = true
		TextLabelMain.TextSize = 16.000
		TextLabelMain.TextWrapped = true
		TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]
		table.insert(UpdateCallBack["GUI Text Color"],function() 
			TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]
		end)
		local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
		local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
		local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
		local color = colorR .. ',' .. colorG .. ',' .. colorB
		TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
		table.insert(UpdateCallBack["Title Text Color"],function() 
			local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
			local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
			local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
			local color = colorR .. ',' .. colorG .. ',' .. colorB
			TextLabelMain.Text = "<font color=\"rgb("..color..")\">Sea Hub</font> " .. getgenv().MainDesc
		end)
		SettionMain.Name = "SettionMain"
		SettionMain.Parent = TopMain
		SettionMain.AnchorPoint = Vector2.new(1, 0)
		SettionMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SettionMain.BackgroundTransparency = 1.000
		SettionMain.Position = UDim2.new(1, 0, 0, 0)
		SettionMain.Size = UDim2.new(0, 30, 0, 30)
		SettionButton.Name = "SettionButton"
		SettionButton.Parent = SettionMain
		SettionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SettionButton.BackgroundTransparency = 1.000
		SettionButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
		SettionButton.Size = UDim2.new(1, 0, 1, 0)
		SettionButton.Font = Enum.Font.SourceSans
		SettionButton.Text = ""
		SettionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SettionButton.TextSize = 14.000
		SettionButton.Visible = true
		SettingIcon.Name = "SettingIcon"
		SettingIcon.Parent = SettionMain
		SettingIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SettingIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SettingIcon.BackgroundTransparency = 1.000
		SettingIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SettingIcon.Size = UDim2.new(1, -10, 1, -10)
		SettingIcon.Image = "rbxassetid://7397332215"
		SettingIcon.Visible = true
		SettingIcon.ImageColor3 = getgenv().UIColor["Setting Icon Color"]
		table.insert(UpdateCallBack["Setting Icon Color"],function() 
			SettingIcon.ImageColor3 = getgenv().UIColor["Setting Icon Color"]
		end)
		PageControl.Name = "Background1"
		PageControl.Parent = Concacmain
		PageControl.Position = UDim2.new(0, 5, 0, 0)
		PageControl.Size = UDim2.new(0, 180, 0, 325)
		PageControl.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
		table.insert(UpdateCallBack["Background 1 Transparency"],function() 
			PageControl.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
		end)
		PageControl.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		table.insert(UpdateCallBack["Background 1 Color"],function() 
			PageControl.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		end)
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = PageControl
		ControlList.Name = "ControlList"
		ControlList.Parent = PageControl
		ControlList.Active = true
		ControlList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		ControlList.BackgroundTransparency = 1.000
		ControlList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		ControlList.BorderSizePixel = 0
		ControlList.Position = UDim2.new(0, 0, 0, 30)
		ControlList.Size = UDim2.new(1, -5, 1, -30)
		ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
		ControlList.ScrollBarThickness = 5
		ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		UIListLayout.Parent = ControlList
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)
		ControlTitle.Name = "GUITextColor"
		ControlTitle.Parent = PageControl
		ControlTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		ControlTitle.BackgroundTransparency = 1.000
		ControlTitle.Position = UDim2.new(0, 5, 0, 0)
		ControlTitle.Size = UDim2.new(1, 0, 0, 25)
		ControlTitle.Font = Enum.Font.GothamBold
		ControlTitle.Text = TitleNameMain
		ControlTitle.TextSize = 14.000
		ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
		ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
		table.insert(UpdateCallBack["GUI Text Color"], function() 
			ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
		end)
		MainPage.Name = "MainPage"
		MainPage.Parent = Concacmain
		MainPage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		MainPage.BackgroundTransparency = 1.000
		MainPage.ClipsDescendants = true
		MainPage.Position = UDim2.new(0, 190, 0, 0)
		MainPage.Size = UDim2.new(0, 435, 0, 325)
		UIPage.Name = "UIPage"
		UIPage.Parent = MainPage
		UIPage.FillDirection = Enum.FillDirection.Vertical
		UIPage.SortOrder = Enum.SortOrder.LayoutOrder
		UIPage.EasingDirection = Enum.EasingDirection.InOut
		UIPage.EasingStyle = Enum.EasingStyle.Quart
		UIPage.Padding = UDim.new(0, 10)
		UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]
		table.insert(UpdateCallBack["Tween Animation 1 Speed"], function() 
			UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]
		end)
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
		end)
		local cummm = false 
		SettionButton.MouseButton1Click:Connect(function() Library_Function.ButtonEffect() end)
		SettionButton.MouseButton1Click:Connect(function()
			cummm = not cummm
			pa = cummm and 1 or 0 
			ro = cummm and 180 or 0 
			Concacpage:JumpToIndex(pa)
			game.TweenService:Create(SettingIcon,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Rotation = ro}):Play()
		end)
		local CustomList = Instance.new("ScrollingFrame")
		local CustomListLayout = Instance.new("UIListLayout")
		CustomList.Name = "CustomList"
		CustomList.Parent = Concacmain1
		CustomList.Active = true
		CustomList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CustomList.BackgroundTransparency = 1.000
		CustomList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		CustomList.BorderSizePixel = 0
		CustomList.Position = UDim2.new(0, 5, 0, 30)
		CustomList.Size = UDim2.new(1, -10, 1, -30)
		CustomList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		CustomList.ScrollBarThickness = 5
		CustomList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		CustomListLayout.Name = "CustomListLayout"
		CustomListLayout.Parent = CustomList
		CustomListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		CustomListLayout.Padding = UDim.new(0, 5)
		CustomListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			CustomList.CanvasSize = UDim2.new(0, 0, 0, CustomListLayout.AbsoluteContentSize.Y + 5)
		end)
		local CustomTitle = Instance.new("TextLabel")
		CustomTitle.Name = "GUITextColor"
		CustomTitle.Parent = Concacmain1
		CustomTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CustomTitle.BackgroundTransparency = 1.000
		CustomTitle.Position = UDim2.new(0, 15, 0, 0)
		CustomTitle.Size = UDim2.new(1, -15, 0, 25)
		CustomTitle.Font = Enum.Font.GothamBold
		CustomTitle.Text = ''
		CustomTitle.TextSize = 16.000
		CustomTitle.TextXAlignment = Enum.TextXAlignment.Left
		CustomTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
		table.insert(UpdateCallBack["GUI Text Color"],function() 
			CustomTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
		end)
		local CustomSearch = Instance.new("Frame")
		local PageSearchCorner = Instance.new("UICorner")
		local SearchFrame = Instance.new("Frame")
		local SearchIcon = Instance.new("ImageLabel")
		local active = Instance.new("TextButton")
		local SearchBucu = Instance.new("TextBox")
		CustomSearch.Name = "Background2"
		CustomSearch.Parent = Concacmain1
		CustomSearch.AnchorPoint = Vector2.new(1, 0)
		CustomSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		CustomSearch.ClipsDescendants = true
		CustomSearch.Position = UDim2.new(1, -5, 0, 5)
		CustomSearch.Size = UDim2.new(0, 20, 0, 20)
		CustomSearch.ClipsDescendants = true
		table.insert(UpdateCallBack["Background 2 Color"],function() 
			CustomSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		end)
		PageSearchCorner.CornerRadius = UDim.new(0, 2)
		PageSearchCorner.Name = "PageSearchCorner"
		PageSearchCorner.Parent = CustomSearch
		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = CustomSearch
		SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchFrame.BackgroundTransparency = 1.000
		SearchFrame.Size = UDim2.new(0, 20, 0, 20)
		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchFrame
		SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchIcon.BackgroundTransparency = 1.000
		SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon.Size = UDim2.new(0, 16, 0, 16)
		SearchIcon.Image = "rbxassetid://8154282545"
		SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]
		table.insert(UpdateCallBack["Search Icon Color"],function() 
			SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]
		end)
		active.Name = "active"
		active.Parent = SearchFrame
		active.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		active.BackgroundTransparency = 1.000
		active.Size = UDim2.new(1, 0, 1, 0)
		active.Font = Enum.Font.SourceSans
		active.Text = ""
		active.TextColor3 = Color3.fromRGB(0, 0, 0)
		active.TextSize = 14.000
		SearchBucu.Name = "TextColorPlaceholder"
		SearchBucu.Parent = CustomSearch
		SearchBucu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchBucu.BackgroundTransparency = 1.000
		SearchBucu.Position = UDim2.new(0, 30, 0, 0)
		SearchBucu.Size = UDim2.new(1, -30, 1, 0)
		SearchBucu.Font = Enum.Font.GothamBold
		SearchBucu.Text = ''
		SearchBucu.TextSize = 14.000
		SearchBucu.TextXAlignment = Enum.TextXAlignment.Left
		SearchBucu.PlaceholderText =  "Search Section name"
		SearchBucu.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBucu.TextColor3 = getgenv().UIColor["Text Color"]
		table.insert(UpdateCallBack["Placeholder Text Color"],function() 
			SearchBucu.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		end)
		table.insert(UpdateCallBack["Text Color"],function() 
			SearchBucu.TextColor3 = getgenv().UIColor["Text Color"]
		end)
		local cummmed_ = false 
			active.MouseEnter:Connect(function()
				TweenService:Create(SearchIcon,TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]}):Play()
			end)
			active.MouseLeave:Connect(function()
				TweenService:Create(SearchIcon,TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Color"]}):Play()
			end)
			active.MouseButton1Click:Connect(function()
				Library_Function.ButtonEffect()
			end)
			SearchBucu.Focused:Connect(function()
				Library_Function.ButtonEffect()
			end)
			active.MouseButton1Click:Connect(function()
				cummmed_ = not cummmed_
				local size = cummmed_ and UDim2.new(0,175,0,20) or  UDim2.new(0,20,0,20)
				game.TweenService:Create(CustomSearch,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = size}):Play()
			end)
			local function succac_()
				for i,v in next, CustomList:GetChildren() do 
					if not v:IsA('UIListLayout') then 
						v.Visible = false
					end
				end
			end
			local function ra_()
				for a, b in pairs(CustomList:GetChildren()) do
					if not b:IsA('UIListLayout') then 
						if string.find(string.lower(b.Name),string.lower(SearchBucu.Text)) then 
							b.Visible = true
						end
					end
				end
			end
			SearchBucu:GetPropertyChangedSignal("Text"):Connect(function()
				succac_()
				ra_()
			end)
		function Library.CreateCustomColor(Name)
			CustomTitle.Text = Name or 'Custom GUI'
			local Setting_Function = {}
			function Setting_Function.CreateSection(Section_Name)
				local Section = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Topsec = Instance.new("Frame")
				local Sectiontitle = Instance.new("TextLabel")
				local Linesec = Instance.new("Frame")
				local UIGradient = Instance.new("UIGradient")
				local SectionList = Instance.new("UIListLayout")
				local SectionName = Section_Name or "Section"
				Section.Name = Section_Name.."Section"
				Section.Parent = CustomList
				Section.Size = UDim2.new(1, 0, 0, 285)
				Section.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
				table.insert(UpdateCallBack["Background 3 Color"],function() 
					Section.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
				end)
				Section.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				table.insert(UpdateCallBack["Background 1 Transparency"],function() 
					Section.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				end)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Section
				Topsec.Name = "Topsec"
				Topsec.Parent = Section
				Topsec.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Topsec.BackgroundTransparency = 1.000
				Topsec.Size = UDim2.new(1, 0, 0, 27)
				Sectiontitle.Name = "Sectiontitle"
				Sectiontitle.Parent = Topsec
				Sectiontitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sectiontitle.BackgroundTransparency = 1.000
				Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
				Sectiontitle.Font = Enum.Font.GothamBold
				Sectiontitle.Text = Section_Name
				Sectiontitle.TextSize = 14.000
				Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]
				table.insert(UpdateCallBack["Section Text Color"],function() 
					Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]
				end)
				Linesec.Name = "Linesec"
				Linesec.Parent = Topsec
				Linesec.AnchorPoint = Vector2.new(0.5, 1)
				Linesec.BorderSizePixel = 0
				Linesec.Position = UDim2.new(0.5, 0, 1, -2)
				Linesec.Size = UDim2.new(1, -10, 0, 2)
				Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
				table.insert(UpdateCallBack["Section Underline Color"],function() 
					Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
				end)
				UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.51, 0.02), NumberSequenceKeypoint.new(1.00, 1.00)}
				UIGradient.Parent = Linesec
				SectionList.Name = "SectionList"
				SectionList.Parent = Section
				SectionList.SortOrder = Enum.SortOrder.LayoutOrder
				SectionList.Padding = UDim.new(0, 5)
				SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					Section.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 5)
				end)
				local Setting_Section_Function = {}
					function Setting_Section_Function.CreateColorPicker(Setting)
						local _G=setmetatable({},{
							__index=function(Self,Key) 
								if Key=="Cungroi" then 
									return SettingsRac[Setting.Type].Rainbow
								end
							end,
							__newindex=function(Self,Key,Value) 
								if Key=="Cungroi" then 
									SettingsRac[Setting.Type].Rainbow=Value
								end
							end
						})
						local H,S,V
						local Title = Setting.Title or "Color Picker"
						local Default = SettingsRac[Setting.Type].Color or Color3.fromRGB(255, 255, 255)
						local Type = Setting.Type
						local ColorPick = Instance.new("Frame")
						local ColorPickCorner = Instance.new("UICorner")
						local ColorPickBg = Instance.new("Frame")
						local ColorpickBGCorner = Instance.new("UICorner")
						local ColorpickTitle = Instance.new("TextLabel")
						local ColorVal = Instance.new("Frame")
						local ColorValCorner = Instance.new("UICorner")
						local ColorValButton = Instance.new("TextButton")
						local Hue = Instance.new("Frame")
						local HueGra = Instance.new("UIGradient")
						local Frame = Instance.new("Frame")
						local UICorner = Instance.new("UICorner")
						local Concac = Instance.new("Frame")
						local RFrame = Instance.new("Frame")
						local RText = Instance.new("TextLabel")
						local RBox = Instance.new("TextBox")
						local GFrame = Instance.new("Frame")
						local GText = Instance.new("TextLabel")
						local GBox = Instance.new("TextBox")
						local BFrame = Instance.new("Frame")
						local BText = Instance.new("TextLabel")
						local BBox = Instance.new("TextBox")
						local UIListLayout = Instance.new("UIListLayout")
						local HexFrame = Instance.new("Frame")
						local HexText = Instance.new("TextLabel")
						local HexBox = Instance.new("TextBox")
						local Linesec = Instance.new("Frame")
						local UIGradient = Instance.new("UIGradient")
						local CungroiF = Instance.new("Frame")
						local CungroiFF = Instance.new("Frame")
						local cungroitext = Instance.new("TextLabel")
						local checkbox = Instance.new("ImageLabel")
						local check = Instance.new("ImageLabel")
						local Cungroitog = Instance.new("TextButton")
						local Color = Instance.new("ImageLabel")
						local SelectorColor = Instance.new("Frame")
						local UICorner_2 = Instance.new("UICorner")
						local HoithoF = Instance.new("Frame")
						local HoithoF_2 = Instance.new("Frame")
						local hoithotext = Instance.new("TextLabel")
						local checkbox_2 = Instance.new("ImageLabel")
						local check_2 = Instance.new("ImageLabel")
						local Hoithoitog = Instance.new("TextButton")
						local Frame_2 = Instance.new("Frame")
						local UIListLayout_2 = Instance.new("UIListLayout")
						local Cor1 = Instance.new("Frame")
						local UICorner_3 = Instance.new("UICorner")
						local BCor1 = Instance.new("TextButton")
						local Cor2 = Instance.new("Frame")
						local UICorner_4 = Instance.new("UICorner")
						local BCor2 = Instance.new("TextButton")
						ColorPick.Name = "ColorPick"
						ColorPick.Parent = Section
						ColorPick.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						ColorPick.BackgroundTransparency = 1.000
						ColorPick.ClipsDescendants = true
						ColorPick.Position = UDim2.new(0, 0, 0.112280704, 0)
						ColorPick.Size = UDim2.new(1, 0, 0, 35)
						ColorPickCorner.CornerRadius = UDim.new(0, 4)
						ColorPickCorner.Name = "ColorPickCorner"
						ColorPickCorner.Parent = ColorPick
						ColorPickBg.Name = "Background1"
						ColorPickBg.Parent = ColorPick
						ColorPickBg.AnchorPoint = Vector2.new(0.5, 0.5)
						ColorPickBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						ColorPickBg.Position = UDim2.new(0.5, 0, 0.5, 0)
						ColorPickBg.Size = UDim2.new(1, -10, 1, 0)
						table.insert(UpdateCallBack["Background 1 Color"],function() 
							ColorPickBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						end)
						ColorPickBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						table.insert(UpdateCallBack["Background 1 Transparency"],function() 
							ColorPickBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						end)
						ColorpickBGCorner.CornerRadius = UDim.new(0, 4)
						ColorpickBGCorner.Name = "ColorpickBGCorner"
						ColorpickBGCorner.Parent = ColorPickBg
						ColorpickTitle.Name = "TextColor"
						ColorpickTitle.Parent = ColorPickBg
						ColorpickTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						ColorpickTitle.BackgroundTransparency = 1.000
						ColorpickTitle.Position = UDim2.new(0, 10, 0, 0)
						ColorpickTitle.Size = UDim2.new(1, -10, 0, 35)
						ColorpickTitle.Font = Enum.Font.GothamBlack
						ColorpickTitle.Text = Title
						ColorpickTitle.TextSize = 14.000
						ColorpickTitle.TextXAlignment = Enum.TextXAlignment.Left
						ColorpickTitle.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							ColorpickTitle.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						ColorVal.Name = "ColorVal"
						ColorVal.Parent = ColorPick
						ColorVal.AnchorPoint = Vector2.new(1, 0)
						ColorVal.BackgroundColor3 = SettingsRac[Type].Color
						ColorVal.Position = UDim2.new(1, -10, 0, 5)
						ColorVal.Size = UDim2.new(0, 150, 0, 25)
						ColorValCorner.CornerRadius = UDim.new(0, 4)
						ColorValCorner.Name = "ColorValCorner"
						ColorValCorner.Parent = ColorVal
						ColorValButton.Name = "ColorValButton"
						ColorValButton.Parent = ColorVal
						ColorValButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						ColorValButton.BackgroundTransparency = 1.000
						ColorValButton.Size = UDim2.new(1, 0, 1, 0)
						ColorValButton.Font = Enum.Font.SourceSans
						ColorValButton.Text = ""
						ColorValButton.TextColor3 = Color3.fromRGB(0, 0, 0)
						ColorValButton.TextSize = 14.000
						Hue.Name = "Hue"
						Hue.Parent = ColorPick
						Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Hue.BorderSizePixel = 0
						Hue.Position = UDim2.new(0, 460, 0, 40)
						Hue.Size = UDim2.new(0, 25, 0, 200)
						HueGra.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(235, 7, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 9, 189)), ColorSequenceKeypoint.new(0.49, Color3.fromRGB(0, 193, 196)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.84, Color3.fromRGB(255, 247, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
						HueGra.Rotation = 90
						HueGra.Name = "HueGra"
						HueGra.Parent = Hue
						Frame.Parent = Hue
						Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Frame.Position = UDim2.new(0, 0, 1, 0)
						Frame.Size = UDim2.new(1, 0, 0, 2)
						UICorner.CornerRadius = UDim.new(0, 4)
						UICorner.Parent = Hue
						Concac.Name = "Concac"
						Concac.Parent = ColorPick
						Concac.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Concac.BackgroundTransparency = 1.000
						Concac.Position = UDim2.new(0, 495, 0, 40)
						Concac.Size = UDim2.new(0, 115, 0, 100)
						RFrame.Name = "RFrame"
						RFrame.Parent = Concac
						RFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						RFrame.BackgroundTransparency = 1.000
						RFrame.Size = UDim2.new(1, 0, 0, 25)
						RFrame.LayoutOrder = 0
						RText.Name = "RText"
						RText.Parent = RFrame
						RText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						RText.BackgroundTransparency = 1.000
						RText.Size = UDim2.new(0, 25, 0, 25)
						RText.Font = Enum.Font.GothamBold
						RText.Text = "R:"
						RText.TextColor3 = Color3.fromRGB(115, 115, 115)
						RText.TextSize = 14.000
						RText.TextXAlignment = Enum.TextXAlignment.Left
						RBox.Name = "RBox"
						RBox.Parent = RFrame
						RBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						RBox.BackgroundTransparency = 1.000
						RBox.Position = UDim2.new(0, 25, 0, 0)
						RBox.Size = UDim2.new(1, -25, 1, 0)
						RBox.ClearTextOnFocus = false
						RBox.Font = Enum.Font.GothamBold
						RBox.Text = "255"
						RBox.TextColor3 = Color3.fromRGB(255, 255, 255)
						RBox.TextSize = 14.000
						RBox.TextXAlignment = Enum.TextXAlignment.Left
						GFrame.Name = "GFrame"
						GFrame.Parent = Concac
						GFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						GFrame.BackgroundTransparency = 1.000
						GFrame.Size = UDim2.new(1, 0, 0, 25)
						GFrame.LayoutOrder = 1
						GText.Name = "GText"
						GText.Parent = GFrame
						GText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						GText.BackgroundTransparency = 1.000
						GText.Size = UDim2.new(0, 25, 0, 25)
						GText.Font = Enum.Font.GothamBold
						GText.Text = "G:"
						GText.TextColor3 = Color3.fromRGB(115, 115, 115)
						GText.TextSize = 14.000
						GText.TextXAlignment = Enum.TextXAlignment.Left
						GBox.Name = "GBox"
						GBox.Parent = GFrame
						GBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						GBox.BackgroundTransparency = 1.000
						GBox.Position = UDim2.new(0, 25, 0, 0)
						GBox.Size = UDim2.new(1, -25, 1, 0)
						GBox.ClearTextOnFocus = false
						GBox.Font = Enum.Font.GothamBold
						GBox.Text = "255"
						GBox.TextColor3 = Color3.fromRGB(255, 255, 255)
						GBox.TextSize = 14.000
						GBox.TextXAlignment = Enum.TextXAlignment.Left
						BFrame.Name = "BFrame"
						BFrame.Parent = Concac
						BFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						BFrame.BackgroundTransparency = 1.000
						BFrame.Size = UDim2.new(1, 0, 0, 25)
						BFrame.LayoutOrder = 2
						BText.Name = "BText"
						BText.Parent = BFrame
						BText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						BText.BackgroundTransparency = 1.000
						BText.Size = UDim2.new(0, 25, 0, 25)
						BText.Font = Enum.Font.GothamBold
						BText.Text = "B:"
						BText.TextColor3 = Color3.fromRGB(115, 115, 115)
						BText.TextSize = 14.000
						BText.TextXAlignment = Enum.TextXAlignment.Left
						BBox.Name = "BBox"
						BBox.Parent = BFrame
						BBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						BBox.BackgroundTransparency = 1.000
						BBox.Position = UDim2.new(0, 25, 0, 0)
						BBox.Size = UDim2.new(1, -25, 1, 0)
						BBox.ClearTextOnFocus = false
						BBox.Font = Enum.Font.GothamBold
						BBox.Text = "255"
						BBox.TextColor3 = Color3.fromRGB(255, 255, 255)
						BBox.TextSize = 14.000
						BBox.TextXAlignment = Enum.TextXAlignment.Left
						UIListLayout.Parent = Concac
						UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
						HexFrame.Name = "HexFrame"
						HexFrame.Parent = Concac
						HexFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HexFrame.BackgroundTransparency = 1.000
						HexFrame.Size = UDim2.new(1, 0, 0, 25)
						HexFrame.LayoutOrder = 3
						HexText.Name = "HexText"
						HexText.Parent = HexFrame
						HexText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HexText.BackgroundTransparency = 1.000
						HexText.Size = UDim2.new(0, 25, 0, 25)
						HexText.Font = Enum.Font.GothamBold
						HexText.Text = "#"
						HexText.TextColor3 = Color3.fromRGB(115, 115, 115)
						HexText.TextSize = 14.000
						HexText.TextXAlignment = Enum.TextXAlignment.Left
						HexBox.Name = "HexBox"
						HexBox.Parent = HexFrame
						HexBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HexBox.BackgroundTransparency = 1.000
						HexBox.Position = UDim2.new(0, 25, 0, 0)
						HexBox.Size = UDim2.new(1, -25, 1, 0)
						HexBox.ClearTextOnFocus = false
						HexBox.Font = Enum.Font.GothamBold
						HexBox.Text = "FFFFFF"
						HexBox.TextColor3 = Color3.fromRGB(255, 255, 255)
						HexBox.TextSize = 14.000
						HexBox.TextXAlignment = Enum.TextXAlignment.Left
						Linesec.Name = "Linesec"
						Linesec.Parent = Concac
						Linesec.AnchorPoint = Vector2.new(0.5, 1)
						Linesec.BorderSizePixel = 0
						Linesec.Position = UDim2.new(0.5, 0, 1, -2)
						Linesec.Size = UDim2.new(1, -10, 0, 2)
						Linesec.LayoutOrder = 4
						Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
						table.insert(UpdateCallBack["Section Underline Color"],function() 
							Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
						end)
						UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.30, 0.25), NumberSequenceKeypoint.new(0.70, 0.25), NumberSequenceKeypoint.new(1.00, 1.00)}
						UIGradient.Parent = Linesec
						CungroiF.Name = "CungroiF"
						CungroiF.Parent = ColorPick
						CungroiF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						CungroiF.BackgroundTransparency = 1.000
						CungroiF.Position = UDim2.new(0, 495, 0, 145)
						CungroiF.Size = UDim2.new(0, 115, 0, 25)
						CungroiFF.Name = "CungroiFF"
						CungroiFF.Parent = CungroiF
						CungroiFF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						CungroiFF.BackgroundTransparency = 1.000
						CungroiFF.Size = UDim2.new(1, 0, 0, 25)
						CungroiFF.LayoutOrder = 4
						cungroitext.Name = "TextColor"
						cungroitext.Parent = CungroiFF
						cungroitext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						cungroitext.BackgroundTransparency = 1.000
						cungroitext.Size = UDim2.new(0, 85, 0, 25)
						cungroitext.Font = Enum.Font.GothamBold
						cungroitext.Text = "Rainbow"
						cungroitext.TextSize = 14.000
						cungroitext.TextXAlignment = Enum.TextXAlignment.Left
						cungroitext.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							cungroitext.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						checkbox.Name = "Setting_checkbox"
						checkbox.Parent = CungroiFF
						checkbox.AnchorPoint = Vector2.new(1, 0.5)
						checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						checkbox.BackgroundTransparency = 1.000
						checkbox.Position = UDim2.new(1, -5, 0.5, 0)
						checkbox.Size = UDim2.new(0, 25, 0, 25)
						checkbox.Image = "rbxassetid://4552505888"
						checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
						table.insert(UpdateCallBack["Toggle Border Color"],function() 
							checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
						end)
						check.Name = "Setting_check"
						check.Parent = checkbox
						check.AnchorPoint = Vector2.new(0, 1)
						check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						check.BackgroundTransparency = 1.000
						check.Position = UDim2.new(0, 0, 1, 0)
						check.Image = "rbxassetid://4555411759"
						check.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
						table.insert(UpdateCallBack["Toggle Checked Color"],function() 
							check.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
						end)
						Cungroitog.Name = "Cungroitog"
						Cungroitog.Parent = CungroiFF
						Cungroitog.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Cungroitog.BackgroundTransparency = 1.000
						Cungroitog.Size = UDim2.new(1, 0, 1, 0)
						Cungroitog.Font = Enum.Font.SourceSans
						Cungroitog.Text = ""
						Cungroitog.TextColor3 = Color3.fromRGB(0, 0, 0)
						Cungroitog.TextSize = 14.000
						Color.Name = "Color"
						Color.Parent = ColorPick
						Color.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
						Color.BorderSizePixel = 0
						Color.Position = UDim2.new(0, 10, 0, 40)
						Color.Size = UDim2.new(0, 440, 0, 200)
						Color.Image = "rbxassetid://4155801252"
						SelectorColor.Name = "SelectorColor"
						SelectorColor.Parent = Color
						SelectorColor.AnchorPoint = Vector2.new(0.5, 0.5)
						SelectorColor.BackgroundColor3 = Color3.fromRGB(203, 203, 203)
						SelectorColor.BorderColor3 = Color3.fromRGB(70, 70, 70)
						SelectorColor.Position = UDim2.new(1, 0, 0, 0)
						SelectorColor.Size = UDim2.new(0, 4, 0, 4)
						UICorner_2.CornerRadius = UDim.new(0, 4)
						UICorner_2.Parent = Color
						HoithoF.Name = "HoithoF"
						HoithoF.Parent = ColorPick
						HoithoF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HoithoF.BackgroundTransparency = 1.000
						HoithoF.Position = UDim2.new(0, 495, 0, 175)
						HoithoF.Size = UDim2.new(0, 115, 0, 25)
						HoithoF.LayoutOrder = 5
						HoithoF_2.Name = "HoithoF"
						HoithoF_2.Parent = HoithoF
						HoithoF_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HoithoF_2.BackgroundTransparency = 1.000
						HoithoF_2.Size = UDim2.new(1, 0, 1, 25)
						hoithotext.Name = "TextColor"
						hoithotext.Parent = HoithoF_2
						hoithotext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						hoithotext.BackgroundTransparency = 1.000
						hoithotext.Size = UDim2.new(0, 85, 0, 25)
						hoithotext.Font = Enum.Font.GothamBold
						hoithotext.Text = "Breathing"
						hoithotext.TextSize = 14.000
						hoithotext.TextXAlignment = Enum.TextXAlignment.Left
						hoithotext.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							hoithotext.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						checkbox_2.Name = "setting_checkbox"
						checkbox_2.Parent = HoithoF_2
						checkbox_2.AnchorPoint = Vector2.new(1, 0)
						checkbox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						checkbox_2.BackgroundTransparency = 1.000
						checkbox_2.Position = UDim2.new(1, -5, 0, 0)
						checkbox_2.Size = UDim2.new(0, 25, 0, 25)
						checkbox_2.Image = "rbxassetid://4552505888"
						checkbox_2.ImageColor3 = Color3.fromRGB(131, 181, 255)
						checkbox_2.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
						table.insert(UpdateCallBack["Toggle Border Color"],function() 
							checkbox_2.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
						end)
						check_2.Name = "setting_check"
						check_2.Parent = checkbox_2
						check_2.AnchorPoint = Vector2.new(0, 1)
						check_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						check_2.BackgroundTransparency = 1.000
						check_2.Position = UDim2.new(0, 0, 1, 0)
						check_2.Image = "rbxassetid://4555411759"
						check_2.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
						table.insert(UpdateCallBack["Toggle Checked Color"],function() 
							check_2.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
						end)
						Hoithoitog.Name = "Hoithoitog"
						Hoithoitog.Parent = HoithoF_2
						Hoithoitog.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Hoithoitog.BackgroundTransparency = 1.000
						Hoithoitog.Size = UDim2.new(1, 0, 0, 25)
						Hoithoitog.Font = Enum.Font.SourceSans
						Hoithoitog.Text = ""
						Hoithoitog.TextColor3 = Color3.fromRGB(0, 0, 0)
						Hoithoitog.TextSize = 14.000
						Frame_2.Parent = HoithoF_2
						Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Frame_2.BackgroundTransparency = 1.000
						Frame_2.Position = UDim2.new(0, 0, 0, 30)
						Frame_2.Size = UDim2.new(1, 0, 0, 25)
						UIListLayout_2.Parent = Frame_2
						UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
						UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
						UIListLayout_2.Padding = UDim.new(0, 5)
						Cor1.Name = "Cor1"
						Cor1.Parent = Frame_2
						Cor1.BackgroundColor3 =SettingsRac[Type].Breathing.Color1
						Cor1.Selectable = true
						Cor1.Size = UDim2.new(0, 25, 0, 25)
						UICorner_3.CornerRadius = UDim.new(1, 0)
						UICorner_3.Parent = Cor1
						BCor1.Name = "BCor1"
						BCor1.Parent = Cor1
						BCor1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						BCor1.BackgroundTransparency = 1.000
						BCor1.Size = UDim2.new(1, 0, 1, 0)
						BCor1.Font = Enum.Font.SourceSans
						BCor1.Text = ""
						BCor1.TextColor3 = Color3.fromRGB(0, 0, 0)
						BCor1.TextSize = 14.000
						Cor2.Name = "Cor2"
						Cor2.Parent = Frame_2
						Cor2.BackgroundColor3 = SettingsRac[Type].Breathing.Color2
						Cor2.Selectable = true
						Cor2.Size = UDim2.new(0, 25, 0, 25)
						UICorner_4.CornerRadius = UDim.new(1, 0)
						UICorner_4.Parent = Cor2
						BCor2.Name = "BCor2"
						BCor2.Parent = Cor2
						BCor2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						BCor2.BackgroundTransparency = 1.000
						BCor2.Size = UDim2.new(1, 0, 1, 0)
						BCor2.Font = Enum.Font.SourceSans
						BCor2.Text = ""
						BCor2.TextColor3 = Color3.fromRGB(0, 0, 0)
						BCor2.TextSize = 14.000
						local vandogbucu = false
						ColorValButton.MouseButton1Click:Connect(function()
							vandogbucu = not vandogbucu
							local CSize = vandogbucu and UDim2.new(1, 0, 0, 255) or UDim2.new(1, 0, 0, 35)
							TweenService:Create(ColorPick, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {Size = CSize}):Play()
						end)
						ColorValButton.MouseButton1Click:Connect(function()
							Library_Function.ButtonEffect()
						end)
						local userInputService = game:GetService("UserInputService")
						local runService = game:GetService("RunService")
						local plr = game.Players.LocalPlayer
						local mouse = plr:GetMouse()
						local colorInput, hueInput = nil,nil
						local nguvail = true
						local cungroival = 0
						local function cum(...)
							if nguvail then
								return wait(...)
							else
								wait()
								return false
							end
						end
						local function RBGToText(color)
							return {math.floor(color.r*255),math.floor(color.g*255),math.floor(color.b*255)}
						end
						local function Color3FromHex(hex)
							hex = hex:gsub("#", ""):upper():gsub("0X", "")
							return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
						end
						local function Color3ToHex(color)
							local r, g, b = string.format("%X", math.floor(color.R * 255)), string.format("%X", math.floor(color.G * 255)), string.format("%X", math.floor(color.B * 255))
							if #r < 2 then
								r = "0" .. r
							end
							if #g < 2 then
								g = "0" .. g
							end
							if #b < 2 then
								b = "0" .. b
							end
							return string.format("%s%s%s", r, g, b)
						end
						H, S, V = 1,1,1
						local function LayCaiLonHon(a,b) 
							if a>b then return a,b else return b,a end
						end
						local function Cong(a,b) 
							if (a+b)>255 then 
								local lon,be = LayCaiLonHon(a,b)
								local delta = 255-lon
								local lon2,be2 = LayCaiLonHon(delta,be)
								return (lon2-be2)
							else
								return (a+b)
							end
						end
						function CongColor(a,b) 
							local Color1,Color2=a,b
							local SQRT = math.sqrt
							local NewColor={}
							NewColor.R = 255 - SQRT(((255-Color1.R)^2 + (255-Color2.R)^2)/2)
							NewColor.G = 255 - SQRT(((255-Color1.G)^2 + (255-Color2.G)^2)/2)
							NewColor.B = 255 - SQRT(((255-Color1.B)^2 + (255-Color2.B)^2)/2)
							return Color3.new(NewColor.R,NewColor.G,NewColor.B)
						end
						local function UpdateColor(concac)
							local NewColor = concac or Color3.fromHSV(H, S, V)
							if not NewColor then S, H, V = concac:ToHSV() end
							HexBox.Text = Color3ToHex(NewColor)
							Color.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
							if concac then
								Color.BackgroundColor3 = concac
								SelectorColor.Position = UDim2.new(concac and select(3, Color3.toHSV(concac)))
							end
							local pos = 1 - (Color3.toHSV(NewColor))
							local scaley = Hue.Frame.Position.Y.Scale
							if scaley ~= pos and not ((pos == 0 or pos == 1) and (scaley == 1 or scaley == 0)) then
								Hue.Frame.Position = UDim2.fromScale(0,pos)
							end
							RBox.Text, GBox.Text, BBox.Text = RBGToText(NewColor)[1],RBGToText(NewColor)[2],RBGToText(NewColor)[3]
							ColorVal.BackgroundColor3 = NewColor
							local Types = {}
							getgenv().UIColor[Type] = NewColor
						end
						UpdateColor(SettingsRac[Type].Color)
						local function setcungroi(stage)
							if colorInput then
								colorInput = (colorInput:Disconnect() and nil) or nil
							end
							if hueInput then
								hueInput = (hueInput:Disconnect() and nil) or nil
							end
							if stage then 
								pcall(function()
									local kietthongminh = 1 / 255
									while cum() and _G.Cungroi do
										cungroival = kietthongminh + cungroival
										if cungroival > 1 then
											cungroival = 0
										end
										H = cungroival
										UpdateColor(Color3.fromHSV(cungroival, 1, 1))
									end
								end)
							end
						end
						local csize = _G.Cungroi and UDim2.new(1,-4,1,-4) or UDim2.new(0,0,0,0)
						local  pos = _G.Cungroi and UDim2.new(.5,0,.5,0) or UDim2.new(0,0,1,0)
						local apos = _G.Cungroi and Vector2.new(.5,.5) or Vector2.new(0,1)
						check.Size=csize
						check.Position=pos
						check.AnchorPoint = apos
						spawn(function() 
							setcungroi(_G.Cungroi)
						end)
						Cungroitog.MouseButton1Click:Connect(function() Library_Function.ButtonEffect() end)
						Cungroitog.MouseButton1Click:Connect(function()
							_G.Cungroi = not _G.Cungroi
							csize = _G.Cungroi and UDim2.new(1,-4,1,-4) or UDim2.new(0,0,0,0)
							pos = _G.Cungroi and UDim2.new(.5,0,.5,0) or UDim2.new(0,0,1,0)
							apos = _G.Cungroi and Vector2.new(.5,.5) or Vector2.new(0,1)
							game.TweenService:Create(check,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = csize, Position = pos, AnchorPoint = apos}):Play()
							setcungroi(_G.Cungroi)
						end)
						HexBox.FocusLost:Connect(function()
							if #HexBox.Text > 5 then
								local occho, rac = pcall(Color3FromHex, HexBox.Text)
								UpdateColor((occho and rac))
							end
						end)
						RBox.FocusLost:Connect(function()
							if tonumber(RBox.Text) > 255 then 
								RBox.Text = 255
							elseif tonumber(RBox.Text) < 0 then
								RBox.Text = 0
							end
							local occho, rac = pcall(Color3.fromRGB, tonumber(RBox.Text),tonumber(BBox.Text),tonumber(GBox.Text))
							UpdateColor((occho and rac))
						end)
						GBox.FocusLost:Connect(function()
							if tonumber(GBox.Text) > 255 then 
								GBox.Text = 255
							elseif tonumber(GBox.Text) < 0 then
								GBox.Text = 0
							end
							local occho, rac = pcall(Color3.fromRGB, tonumber(RBox.Text),tonumber(BBox.Text),tonumber(GBox.Text))
							UpdateColor((occho and rac))
						end)
						BBox.FocusLost:Connect(function()
							if tonumber(BBox.Text) > 255 then 
								BBox.Text = 255
							elseif tonumber(BBox.Text) < 0 then
								BBox.Text = 0
							end
							local occho, rac = pcall(Color3.fromRGB, tonumber(RBox.Text),tonumber(BBox.Text),tonumber(GBox.Text))
							UpdateColor((occho and rac))
						end)
						H = 1 - (math.clamp(Hue.Frame.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
						S = (math.clamp(Color.SelectorColor.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
						V = 1 - (math.clamp(Color.SelectorColor.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
						Color.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if colorInput then
									colorInput:Disconnect()
								end
								djtmemay = true
								colorInput = runService.RenderStepped:Connect(function()
									local colorX = (math.clamp(mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
									local colorY = (math.clamp(mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
									SelectorColor.Position = UDim2.fromScale(colorX, colorY)
									S = colorX
									V = 1 - colorY
									UpdateColor()
								end)
							end
						end)
						Color.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if colorInput then
									djtmemay = false
									colorInput:Disconnect()
								end
							end
						end)
						Hue.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if hueInput then
									hueInput:Disconnect()
								end
								djtmemay = true
								hueInput = runService.RenderStepped:Connect(function()
									local hueY = math.clamp(mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y
									Hue.Frame.Position = UDim2.fromScale(0,hueY)
									H = 1 - hueY
									UpdateColor()
								end)
							end
						end)
						Hue.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if hueInput then
									djtmemay = false
									hueInput:Disconnect()
								end
							end
						end)
						BCor1.MouseButton1Click:Connect(function()
							Library_Function.ButtonEffect()
						end)
						BCor2.MouseButton1Click:Connect(function()
							Library_Function.ButtonEffect()
						end)
						BCor1.MouseButton1Click:Connect(function()
							Cor1.BackgroundColor3 = ColorVal.BackgroundColor3
							SettingsRac[Type].Breathing.Color1=ColorVal.BackgroundColor3
						end)
						BCor2.MouseButton1Click:Connect(function()
							Cor2.BackgroundColor3 = ColorVal.BackgroundColor3
							SettingsRac[Type].Breathing.Color2=ColorVal.BackgroundColor3
						end)
						Hoithoitog.MouseButton1Click:Connect(function() Library_Function.ButtonEffect() end)
						local vanmeo = false
						spawn(function() 
							while wait() do 
								if SettingsRac[Type].Breathing.Toggle then 
									UpdateColor(ColorVal.BackgroundColor3)
								end
							end
						end)
						local function cacrac() 
							local co2, co1 = Cor2.BackgroundColor3, Cor1.BackgroundColor3
							local csize = SettingsRac[Type].Breathing.Toggle and UDim2.new(1,-4,1,-4) or UDim2.new(0,0,0,0)
							local pos = SettingsRac[Type].Breathing.Toggle and UDim2.new(.5,0,.5,0) or UDim2.new(0,0,1,0)
							local apos = SettingsRac[Type].Breathing.Toggle and Vector2.new(.5,.5) or Vector2.new(0,1)
							game.TweenService:Create(check_2,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = csize, Position = pos, AnchorPoint = apos}):Play()
							if SettingsRac[Type].Breathing.Toggle then 
							   local ab = game.TweenService:Create(ColorVal,TweenInfo.new(2),{BackgroundColor3 = co1})
							   local ab1 = game.TweenService:Create(Color,TweenInfo.new(2),{BackgroundColor3 = co1})
								ab:Play()
								ab1:Play()
								ab.Completed:Connect(function()
									if SettingsRac[Type].Breathing.Toggle then 
									  local  ac = game.TweenService:Create(ColorVal,TweenInfo.new(2),{BackgroundColor3 = co2})
									   local ac1 = game.TweenService:Create(Color,TweenInfo.new(2),{BackgroundColor3 = co2})
										ac:Play()
										ac1:Play()
										if SettingsRac[Type].Breathing.Toggle then 
											ac.Completed:Connect(function()
												ab:Play()
												ab1:Play()
											end)
										end
									end
								end)
							end
						end
						spawn(function() 
							cacrac()
						end)
						Hoithoitog.MouseButton1Click:Connect(function()
							SettingsRac[Type].Breathing.Toggle = not SettingsRac[Type].Breathing.Toggle 
							cacrac()
						end)
					end
					function Setting_Section_Function.CreateBox(Setting)
						local TitleText = tostring(Setting.Title) or ""
						local Placeholder = tostring(Setting.Placeholder) or ""
						local Default = getgenv().UIColor[Setting.Type] or ""
						local BoxFrame = Instance.new("Frame")
						local BoxCorner = Instance.new("UICorner")
						local BoxBG = Instance.new("Frame")
						local ButtonCorner = Instance.new("UICorner")
						local Boxtitle = Instance.new("TextLabel")
						local BoxCor = Instance.new("Frame")
						local ButtonCorner_2 = Instance.new("UICorner")
						local Boxxxx = Instance.new("TextBox")
						local Lineeeee = Instance.new("Frame")
						BoxFrame.Name = "BoxFrame"
						BoxFrame.Parent = Section
						BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						BoxFrame.BackgroundTransparency = 1.000
						BoxFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
						BoxFrame.Size = UDim2.new(1, 0, 0, 60)
						BoxCorner.CornerRadius = UDim.new(0, 4)
						BoxCorner.Name = "BoxCorner"
						BoxCorner.Parent = BoxFrame
						BoxBG.Name = "Background1"
						BoxBG.Parent = BoxFrame
						BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
						BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
						BoxBG.Size = UDim2.new(1, -10, 1, 0)
						BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						table.insert(UpdateCallBack["Background 1 Color"],function() 
							BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						end)
						BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						table.insert(UpdateCallBack["Background 1 Transparency"],function() 
							BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						end)
						ButtonCorner.CornerRadius = UDim.new(0, 4)
						ButtonCorner.Name = "ButtonCorner"
						ButtonCorner.Parent = BoxBG
						Boxtitle.Name = "TextColor"
						Boxtitle.Parent = BoxBG
						Boxtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Boxtitle.BackgroundTransparency = 1.000
						Boxtitle.Position = UDim2.new(0, 10, 0, 0)
						Boxtitle.Size = UDim2.new(1, -10, 0.5, 0)
						Boxtitle.Font = Enum.Font.GothamBlack
						Boxtitle.Text = TitleText
						Boxtitle.TextSize = 14.000
						Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
						Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						BoxCor.Name = "Background2"
						BoxCor.Parent = BoxBG
						BoxCor.AnchorPoint = Vector2.new(1, 0.5)
						BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						BoxCor.ClipsDescendants = true
						BoxCor.Position = UDim2.new(1, -5, 0, 40)
						BoxCor.Size = UDim2.new(1, -10, 0, 25)
						table.insert(UpdateCallBack["Text Color"],function() 
							BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						end)
						ButtonCorner_2.CornerRadius = UDim.new(0, 4)
						ButtonCorner_2.Name = "ButtonCorner"
						ButtonCorner_2.Parent = BoxCor
						Boxxxx.Name = "TextColorPlaceholder"
						Boxxxx.Parent = BoxCor
						Boxxxx.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Boxxxx.BackgroundTransparency = 1.000
						Boxxxx.Position = UDim2.new(0, 5, 0, 0)
						Boxxxx.Size = UDim2.new(1, -5, 1, 0)
						Boxxxx.Font = Enum.Font.GothamBold
						Boxxxx.PlaceholderText = Placeholder
						Boxxxx.Text = ""
						Boxxxx.TextSize = 14.000
						Boxxxx.TextXAlignment = Enum.TextXAlignment.Left
						Boxxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Boxxxx.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Placeholder Text Color"],function() 
							Boxxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						end)
						table.insert(UpdateCallBack["Text Color"],function() 
							Boxxxx.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						Lineeeee.Name = "Setting_Lineeeee"
						Lineeeee.Parent = BoxCor
						Lineeeee.BackgroundTransparency = 1.000
						Lineeeee.Position = UDim2.new(0, 0, 1, -2)
						Lineeeee.Size = UDim2.new(1, 0, 0, 6)
						Lineeeee.BackgroundColor3 = getgenv().UIColor["Textbox Highlight Color"]
						table.insert(UpdateCallBack["Textbox Highlight Color"],function() 
							Lineeeee.BackgroundColor3 = getgenv().UIColor["Textbox Highlight Color"]
						end)
						Boxxxx.Focused:Connect(function() 
							TweenService:Create(Lineeeee,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundTransparency = 0}):Play()
						end)
						Boxxxx.Focused:Connect(function() 
							Library_Function.ButtonEffect()
						end)
						Boxxxx.FocusLost:Connect(function()
							TweenService:Create(Lineeeee,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundTransparency = 1}):Play()
							if Boxxxx.Text ~= '' then
								getgenv().UIColor[Setting.Type] = Boxxxx.Text
								if Setting.Type == "Background Image" then
									Library_Function.ReloadMain(Boxxxx.Text)
								end
							end
						end)
						local textbox_function = {}
						if Default then
							Boxxxx.Text = Default
							getgenv().UIColor[Setting.Type] = Default
						end
						function textbox_function.SetValue(Value)
							Boxxxx.Text = Value
							getgenv().UIColor[Setting.Type]=Value
						end 
						return textbox_function;
					end
					function Setting_Section_Function.CreateSlider(Setting)
						local TitleText = tostring(Setting.Title) or ""
						local Min_Value = tonumber(Setting.Min) or 0
						local Max_Value = tonumber(Setting.Max) or 100
						local Precise = Setting.Precise or false
						local DefaultValue = getgenv().UIColor[Setting.Type] or 0
						local Callback = function(v) getgenv().UIColor[Setting.Type]=v end
						local SizeChia = 600;
						local SliderFrame = Instance.new("Frame")
						local SliderCorner = Instance.new("UICorner")
						local SliderBG = Instance.new("Frame")
						local SliderBGCorner = Instance.new("UICorner")
						local SliderTitle = Instance.new("TextLabel")
						local SliderBar = Instance.new("Frame")
						local SliderButton = Instance.new("TextButton")
						local SliderBarCorner = Instance.new("UICorner")
						local Bar = Instance.new("Frame")
						local BarCorner = Instance.new("UICorner")
						local Sliderboxframe = Instance.new("Frame")
						local Sliderbox = Instance.new("UICorner")
						local Sliderbox_2 = Instance.new("TextBox")
						SliderFrame.Name = TitleText..'buda'
						SliderFrame.Parent = Section
						SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						SliderFrame.BackgroundTransparency = 1.000
						SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
						SliderFrame.Size = UDim2.new(1, 0, 0, 50)
						SliderCorner.CornerRadius = UDim.new(0, 4)
						SliderCorner.Name = "SliderCorner"
						SliderCorner.Parent = SliderFrame
						SliderBG.Name = "Background1"
						SliderBG.Parent = SliderFrame
						SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
						SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
						SliderBG.Size = UDim2.new(1, -10, 1, 0)
						SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						table.insert(UpdateCallBack["Background 1 Color"],function() 
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
						end)
						SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						table.insert(UpdateCallBack["Background 1 Transparency"],function() 
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
						end)
						SliderBGCorner.CornerRadius = UDim.new(0, 4)
						SliderBGCorner.Name = "SliderBGCorner"
						SliderBGCorner.Parent = SliderBG
						SliderTitle.Name = "TextColor"
						SliderTitle.Parent = SliderBG
						SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						SliderTitle.BackgroundTransparency = 1.000
						SliderTitle.Position = UDim2.new(0, 10, 0, 0)
						SliderTitle.Size = UDim2.new(1, -10, 0, 25)
						SliderTitle.Font = Enum.Font.GothamBlack
						SliderTitle.Text = TitleText
						SliderTitle.TextSize = 14.000
						SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
						SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						SliderBar.Name = "SliderBar"
						SliderBar.Parent = SliderFrame
						SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
						SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
						SliderBar.Size = UDim2.new(0, 600, 0, 6)
						SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						table.insert(UpdateCallBack["Background 2 Color"],function() 
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						end)
						SliderButton.Name = "SliderButton "
						SliderButton.Parent = SliderBar
						SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						SliderButton.BackgroundTransparency = 1.000
						SliderButton.Size = UDim2.new(1, 0, 1, 0)
						SliderButton.Font = Enum.Font.GothamBold
						SliderButton.Text = ""
						SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
						SliderButton.TextSize = 14.000
						SliderBarCorner.CornerRadius = UDim.new(1, 0)
						SliderBarCorner.Name = "SliderBarCorner"
						SliderBarCorner.Parent = SliderBar
						Bar.Name = "Bar"
						Bar.BorderSizePixel = 0
						Bar.Parent = SliderBar
						Bar.Size = UDim2.new(0, 0, 1, 0)
						Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
						table.insert(UpdateCallBack["Slider Line Color"],function() 
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
						end)
						BarCorner.CornerRadius = UDim.new(1, 0)
						BarCorner.Name = "BarCorner"
						BarCorner.Parent = Bar
						Sliderboxframe.Name = "Background2"
						Sliderboxframe.Parent = SliderFrame
						Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
						Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
						Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
						Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						table.insert(UpdateCallBack["Background 2 Color"],function() 
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
						end)
						Sliderbox.CornerRadius = UDim.new(0, 4)
						Sliderbox.Name = "Sliderbox"
						Sliderbox.Parent = Sliderboxframe
						Sliderbox_2.Name = "TextColor"
						Sliderbox_2.Parent = Sliderboxframe
						Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						Sliderbox_2.BackgroundTransparency = 1.000
						Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
						Sliderbox_2.Font = Enum.Font.GothamBold
						Sliderbox_2.Text = ""
						Sliderbox_2.TextSize = 14.000
						Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
						table.insert(UpdateCallBack["Text Color"],function() 
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
						end)
						SliderButton.MouseEnter:Connect(function()
							TweenService:Create(Bar,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]}):Play()
						end)
						SliderButton.MouseLeave:Connect(function()
							TweenService:Create(Bar,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundColor3 = getgenv().UIColor["Slider Line Color"]}):Play()
						end)
						local mouse = game.Players.LocalPlayer:GetMouse()
						if DefaultValue then 
							if DefaultValue <= Min_Value then DefaultValue = Min_Value elseif DefaultValue >= Max_Value then DefaultValue = Max_Value end
							Bar.Size = UDim2.new(1 - ((Max_Value - DefaultValue) / (Max_Value - Min_Value)),0, 0, 6)
							Sliderbox_2.Text = DefaultValue
							Callback(DefaultValue)
						end
						SliderButton.MouseButton1Down:Connect(function()
							local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
							pcall(function()
								Callback(value)
								Sliderbox_2.Text = value
							end)
							Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
							moveconnection = mouse.Move:Connect(function()   
								local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
								pcall(function()
									Callback(value)
									Sliderbox_2.Text = value
								end)
								Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
							end)
							releaseconnection = uis.InputEnded:Connect(function(Mouse)
								if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
									local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
									pcall(function()
										Callback(value)
										Sliderbox_2.Text = value
									end)
									Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									moveconnection:Disconnect()
									releaseconnection:Disconnect()
								end
							end)
						end)
						local function GetSliderValue(Value)
							if tonumber(Value) <= Min_Value then
								Bar.Size = UDim2.new(0,(0 * SizeChia), 0, 6)
								Sliderbox_2.Text = Min_Value
								Callback(tonumber(Min_Value))
							elseif tonumber(Value) >= Max_Value then
								Bar.Size = UDim2.new(0,(Max_Value  /  Max_Value * SizeChia), 0, 6)
								Sliderbox_2.Text = Max_Value
								Callback(tonumber(Max_Value))
							else
								Bar.Size = UDim2.new(1 - ((Max_Value - Value) / (Max_Value - Min_Value)),0, 0, 6)
								Callback(tonumber(Value))
							end
						end
						Sliderbox_2.FocusLost:Connect(function()
							GetSliderValue(Sliderbox_2.Text)
						end)
						local slider_function = {}
						function slider_function.SetValue(Value)
							GetSliderValue(Value)
						end
						return slider_function
					end
				return Setting_Section_Function
			end
			return Setting_Function
		end
		local CustomColorUI = Library.CreateCustomColor()
		local CCMain = CustomColorUI.CreateSection("Main")
		CCMain.CreateColorPicker({Title = "Border Color", Type = "Border Color"})
		CCMain.CreateColorPicker({Title = "Click Effect Color", Type = "Click Effect Color"})
		CCMain.CreateColorPicker({Title = "Setting Icon Color", Type = "Setting Icon Color"})
		CCMain.CreateBox({Title = 'Logo Image', Placeholder = 'URL Here (PNG only), Recommended 128x128', Type = "Logo Image"})
		local CCSearch = CustomColorUI.CreateSection("Search")
		CCSearch.CreateColorPicker({Title = "Search Icon Color", Type = "Search Icon Color"})
		CCSearch.CreateColorPicker({Title = "Search Icon Highlight Color", Type = "Search Icon Highlight Color"})
		local CCText = CustomColorUI.CreateSection("Text")
		CCText.CreateColorPicker({Title = "GUI Text Color", Type = "GUI Text Color"})
		CCText.CreateColorPicker({Title = "Text Color", Type = "Text Color"})
		CCText.CreateColorPicker({Title = "Placeholder Text Color", Type = "Placeholder Text Color"})
		CCText.CreateColorPicker({Title = "Title Text Color", Type = "Title Text Color"})
		local CCBackground = CustomColorUI.CreateSection("Background")
		CCBackground.CreateColorPicker({Title = "Background 1 Color", Type = "Background 1 Color"})
		CCBackground.CreateSlider({Title = 'Background 1 Transparency', Type = "Background 1 Transparency", Min = 0, Max = 1, Default = 0, Precise = true})
		CCBackground.CreateColorPicker({Title = "Background 2 Color", Type = "Background 2 Color"})
		CCBackground.CreateColorPicker({Title = "Background 3 Color", Type = "Background 3 Color"})
		CCBackground.CreateBox({Title = 'Background Image', Placeholder = 'URL Here (WEBM / PNG only), Recommended 1280x720', Type = "Background Image"})
		local CCPage = CustomColorUI.CreateSection("Page")
		CCPage.CreateColorPicker({Title = "Page Selected Color", Type = "Page Selected Color"})
		local CCSection = CustomColorUI.CreateSection("Section")
		CCSection.CreateColorPicker({Title = "Section Text Color", Type = "Section Text Color"})
		CCSection.CreateColorPicker({Title = "Section Underline Color", Type = "Section Underline Color"})
		local CCToggle = CustomColorUI.CreateSection("Toggle")
		CCToggle.CreateColorPicker({Title = "Toggle Border Color", Type = "Toggle Border Color"})
		CCToggle.CreateColorPicker({Title = "Toggle Checked Color", Type = "Toggle Checked Color"})
		CCToggle.CreateColorPicker({Title = "Toggle Desc Color", Type = "Toggle Desc Color"})
		local CCButton = CustomColorUI.CreateSection("Button")
		CCButton.CreateColorPicker({Title = "Button Color", Type = "Button Color"})
		local CCButton = CustomColorUI.CreateSection("Label")
		CCButton.CreateColorPicker({Title = "Label Color", Type = "Label Color"})
		local CCDropdown = CustomColorUI.CreateSection("Dropdown")
		CCDropdown.CreateColorPicker({Title = "Dropdown Icon Color", Type = "Dropdown Icon Color"})
		CCDropdown.CreateColorPicker({Title = "Dropdown Selected Color", Type = "Dropdown Selected Color"})
		local CCTextbox = CustomColorUI.CreateSection("Textbox")
		CCTextbox.CreateColorPicker({Title = "Textbox Highlight Color", Type = "Textbox Highlight Color"})
		local CCBox = CustomColorUI.CreateSection("Box")
		CCBox.CreateColorPicker({Title = "Box Highlight Color", Type = "Box Highlight Color"})
		local CCSlider = CustomColorUI.CreateSection("Slider")
		CCSlider.CreateColorPicker({Title = "Slider Line Color", Type = "Slider Line Color"})
		CCSlider.CreateColorPicker({Title = "Slider Highlight Color", Type = "Slider Highlight Color"})
		local CCAnimation = CustomColorUI.CreateSection("Animation")
		CCAnimation.CreateSlider({Title = 'Tween Animation 1 Speed', Type = "Tween Animation 1 Speed", Min = 0, Max = 0.75, Default = 0.25, Precise = true})
		CCAnimation.CreateSlider({Title = 'Tween Animation 2 Speed', Type = "Tween Animation 2 Speed", Min = 0, Max = 1, Default = 0.5, Precise = true})
		CCAnimation.CreateSlider({Title = 'Tween Animation 3 Speed', Type = "Tween Animation 3 Speed", Min = 0, Max = 0.5, Default = 0.1, Precise = true})
		local Main_Function = {}
		local LayoutOrderBut = -1
		local LayoutOrder = -1
		local PageCounter = 1
		function Main_Function.CreatePage(Setting)
			local Page_Name = tostring(Setting.Page_Name) 
			local Page_Title = tostring(Setting.Page_Title)
			LayoutOrder = LayoutOrder + 1
			LayoutOrderBut = LayoutOrderBut + 1
			--Control 
			local PageName = Instance.new("Frame")
			local Frame = Instance.new("Frame")
			local TabNameCorner = Instance.new("UICorner")
			local Line = Instance.new("Frame")
			local InLine = Instance.new("Frame")
			local LineCorner = Instance.new("UICorner")
			local TabTitleContainer = Instance.new("Frame")
			local TabTitle = Instance.new("TextLabel")
			local PageButton = Instance.new("TextButton")
			PageName.Name = Page_Name.."_Control"
			PageName.Parent = ControlList
			PageName.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			PageName.BackgroundTransparency = 1.000
			PageName.Size = UDim2.new(1, -10, 0, 25)
			PageName.LayoutOrder = LayoutOrderBut
			Frame.Parent = PageName
			Frame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Frame.BackgroundTransparency = 1.000
			Frame.Position = UDim2.new(0, 5, 0, 0)
			Frame.Size = UDim2.new(1, -5, 1, 0)
			TabNameCorner.CornerRadius = UDim.new(0, 4)
			TabNameCorner.Name = "TabNameCorner"
			TabNameCorner.Parent = Frame
			Line.Name = "Line"
			Line.Parent = Frame
			Line.AnchorPoint = Vector2.new(0, 0.5)
			Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Line.BackgroundTransparency = 1.000
			Line.Position = UDim2.new(0, 0, 0.5, 0)
			Line.Size = UDim2.new(0, 14, 1, 0)
			InLine.Name = "PageInLine"
			InLine.Parent = Line
			InLine.AnchorPoint = Vector2.new(0.5, 0.5)
			InLine.BorderSizePixel = 0
			InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
			InLine.Size = UDim2.new(1, -10, 0, 0)
			InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
			table.insert(UpdateCallBack["Page Selected Color"],function() 
				InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
			end)
			LineCorner.Name = "LineCorner"
			LineCorner.Parent = InLine
			TabTitleContainer.Name = "TabTitleContainer"
			TabTitleContainer.Parent = Frame
			TabTitleContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TabTitleContainer.BackgroundTransparency = 1.000
			TabTitleContainer.Position = UDim2.new(0, 15, 0, 0)
			TabTitleContainer.Size = UDim2.new(1, -15, 1, 0)
			TabTitle.Name = "GUITextColor"
			TabTitle.Parent = TabTitleContainer
			TabTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TabTitle.BackgroundTransparency = 1.000
			TabTitle.Size = UDim2.new(1, 0, 1, 0)
			TabTitle.Font = Enum.Font.GothamBold
			TabTitle.Text = Page_Name
			TabTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
			TabTitle.TextSize = 14.000
			TabTitle.TextXAlignment = Enum.TextXAlignment.Left
			TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
			table.insert(UpdateCallBack["GUI Text Color"],function() 
				TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
			end)
			PageButton.Name = "PageButton"
			PageButton.Parent = PageName
			PageButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			PageButton.BackgroundTransparency = 1.000
			PageButton.Size = UDim2.new(1, 0, 1, 0)
			PageButton.Font = Enum.Font.SourceSans
			PageButton.Text = ""
			PageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			PageButton.TextSize = 14.000
			-- Container
			local PageContainer = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local PageTitle = Instance.new("TextLabel")
			local PageList = Instance.new("ScrollingFrame")
			local Pagelistlayout = Instance.new("UIListLayout")
			local CurrentPage = PageCounter
			PageCounter = PageCounter + 1
			PageContainer.Name = "Page" .. CurrentPage
			PageContainer.Parent = MainPage
			PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
			PageContainer.Position = UDim2.new(0, 190, 0, 30)
			PageContainer.Size = UDim2.new(0, 435, 0, 325)
			PageContainer.LayoutOrder = LayoutOrder
			table.insert(UpdateCallBack["Background 1 Color"],function() 
				PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
			end)
			PageContainer.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
			table.insert(UpdateCallBack["Background 1 Transparency"],function() 
				PageContainer.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
			end)
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = PageContainer
			PageTitle.Name = "GUITextColor"
			PageTitle.Parent = PageContainer
			PageTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			PageTitle.BackgroundTransparency = 1.000
			PageTitle.Position = UDim2.new(0, 5, 0, 0)
			PageTitle.Size = UDim2.new(1, 0, 0, 25)
			PageTitle.Font = Enum.Font.GothamBold
			PageTitle.Text = Page_Title
			PageTitle.TextSize = 16.000
			PageTitle.TextXAlignment = Enum.TextXAlignment.Left
			PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
			table.insert(UpdateCallBack["GUI Text Color"],function() 
				PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
			end)
			PageList.Name = "PageList"
			PageList.Parent = PageContainer
			PageList.Active = true
			PageList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			PageList.BackgroundTransparency = 1.000
			PageList.BorderColor3 = Color3.fromRGB(27, 42, 53)
			PageList.BorderSizePixel = 0
			PageList.Position = UDim2.new(0, 5, 0, 30)
			PageList.Size = UDim2.new(1, -10, 1, -30)
			PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			PageList.ScrollBarThickness = 5
			PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			Pagelistlayout.Name = "Pagelistlayout"
			Pagelistlayout.Parent = PageList
			Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
			Pagelistlayout.Padding = UDim.new(0, 5)
			Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y + 5)
			end)
			local PageSearch = Instance.new("Frame")
			local PageSearchCorner = Instance.new("UICorner")
			local SearchFrame = Instance.new("Frame")
			local SearchIcon = Instance.new("ImageLabel")
			local active = Instance.new("TextButton")
			local Bucu = Instance.new("TextBox")
			PageSearch.Name = "Background2"
			PageSearch.Parent = PageContainer
			PageSearch.AnchorPoint = Vector2.new(1, 0)
			PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
			PageSearch.Position = UDim2.new(1, -5, 0, 5)
			PageSearch.Size = UDim2.new(0, 20, 0, 20)
			PageSearch.ClipsDescendants = true
			table.insert(UpdateCallBack["Background 2 Color"],function() 
				PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
			end)
			PageSearchCorner.CornerRadius = UDim.new(0, 2)
			PageSearchCorner.Name = "PageSearchCorner"
			PageSearchCorner.Parent = PageSearch
			SearchFrame.Name = "SearchFrame"
			SearchFrame.Parent = PageSearch
			SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchFrame.BackgroundTransparency = 1.000
			SearchFrame.Size = UDim2.new(0, 20, 0, 20)
			SearchIcon.Name = "SearchIcon"
			SearchIcon.Parent = SearchFrame
			SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchIcon.BackgroundTransparency = 1.000
			SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
			SearchIcon.Size = UDim2.new(0, 16, 0, 16)
			SearchIcon.Image = "rbxassetid://8154282545"
			SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]
			table.insert(UpdateCallBack["Search Icon Color"],function() 
				SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]
			end)
			active.Name = "active"
			active.Parent = SearchFrame
			active.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			active.BackgroundTransparency = 1.000
			active.Size = UDim2.new(1, 0, 1, 0)
			active.Font = Enum.Font.SourceSans
			active.Text = ""
			active.TextColor3 = Color3.fromRGB(0, 0, 0)
			active.TextSize = 14.000
			Bucu.Name = "TextColorPlaceholder"
			Bucu.Parent = PageSearch
			Bucu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Bucu.BackgroundTransparency = 1.000
			Bucu.Position = UDim2.new(0, 30, 0, 0)
			Bucu.Size = UDim2.new(1, -30, 1, 0)
			Bucu.Font = Enum.Font.GothamBold
			Bucu.Text = ""
			Bucu.TextSize = 14.000
			Bucu.TextXAlignment = Enum.TextXAlignment.Left
			Bucu.PlaceholderText = "Search Section name"
			Bucu.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
			Bucu.TextColor3 = getgenv().UIColor["Text Color"]
			table.insert(UpdateCallBack["Placeholder Text Color"],function() 
				Bucu.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
			end)
			table.insert(UpdateCallBack["Text Color"],function() 
				Bucu.TextColor3 = getgenv().UIColor["Text Color"]
			end)
			local cummmed = false 
			active.MouseEnter:Connect(function()
				TweenService:Create(SearchIcon,TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]}):Play()
			end)
			active.MouseLeave:Connect(function()
				TweenService:Create(SearchIcon,TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]),{ImageColor3 = getgenv().UIColor["Search Icon Color"]}):Play()
			end)
			active.MouseButton1Click:Connect(function()
				Library_Function.ButtonEffect()
			end)
			Bucu.Focused:Connect(function()
				Library_Function.ButtonEffect()
			end)
			active.MouseButton1Click:Connect(function()
				cummmed = not cummmed
				local size = cummmed and UDim2.new(0,175,0,20) or  UDim2.new(0,20,0,20)
				game.TweenService:Create(PageSearch,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = size}):Play()
			end)
			local function succac()
				for i,v in next, PageList:GetChildren() do 
					if not v:IsA('UIListLayout') then 
						v.Visible = false
					end
				end
			end
			local function ra()
				for a, b in pairs(PageList:GetChildren()) do
					if not b:IsA('UIListLayout') then 
						if string.find(string.lower(b.Name),string.lower(Bucu.Text)) then 
							b.Visible = true
						end
					end
				end
			end
			Bucu:GetPropertyChangedSignal("Text"):Connect(function()
				succac()
				ra()
			end)
			for i,v in pairs(ControlList:GetChildren()) do
				if not (v:IsA('UIListLayout')) then
					if i == 2 then 
						v.Frame.Line.PageInLine.Size = UDim2.new(1, -10, 1, -10)
						oldlay = v.LayoutOrder
						oldobj = v
					end
				end
			end
			PageButton.MouseButton1Click:Connect(function()
				spawn(function()
					Library_Function.ButtonEffect()
				end)
				if tostring(UIPage.CurrentPage) == PageContainer.Name then 
					return
				end
				for i,v in pairs(MainPage:GetChildren()) do
					if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
						v.Visible = false
					end
				end
				PageContainer.Visible = true 
				UIPage:JumpTo(PageContainer)
				for i,v in next, ControlList:GetChildren() do
					if not (v:IsA('UIListLayout')) then
						if v.Name == Page_Name.."_Control" then 
							if v.LayoutOrder > oldlay  then 
								oldobj.Active = false 
								TweenService:Create(oldobj.Frame.Line.PageInLine,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = UDim2.new(1,-10,0,0),Position = UDim2.new(0.5, 0, 1, 0), AnchorPoint = Vector2.new(.5,1)}):Play()
								v.Frame.Line.PageInLine.Position = UDim2.new(0.5, 0, 0, 0)
								v.Frame.Line.PageInLine.AnchorPoint = Vector2.new(.5,0)
								wait(getgenv().UIColor["Tween Animation 1 Speed"])
								TweenService:Create(v.Frame.Line.PageInLine,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = UDim2.new(1,-10,1,-10),Position = UDim2.new(0.5, 0, .5, 0), AnchorPoint = Vector2.new(.5,.5)}):Play()
								v.Active = true
								oldobj = v
								oldlay = v.LayoutOrder
							else
								oldobj.Active = false 
								TweenService:Create(oldobj.Frame.Line.PageInLine,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = UDim2.new(1,-10,0,0),Position = UDim2.new(0.5, 0, 0, 0), AnchorPoint = Vector2.new(.5,0)}):Play()
								v.Frame.Line.PageInLine.Position = UDim2.new(0.5, 0, 1, 0)
								v.Frame.Line.PageInLine.AnchorPoint = Vector2.new(.5,1)
								wait(getgenv().UIColor["Tween Animation 1 Speed"])
								TweenService:Create(v.Frame.Line.PageInLine,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = UDim2.new(1,-10,1,-10),Position = UDim2.new(0.5, 0, .5, 0), AnchorPoint = Vector2.new(.5,.5)}):Play()
								v.Active = true
								oldobj = v
								oldlay = v.LayoutOrder
							end
						end
					end
				end
			end)
			local Page_Function = {}
				function Page_Function.CreateSection(Section_Name)
					local Section = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Topsec = Instance.new("Frame")
					local Sectiontitle = Instance.new("TextLabel")
					local Linesec = Instance.new("Frame")
					local UIGradient = Instance.new("UIGradient")
					local SectionList = Instance.new("UIListLayout")
					Section.Name = Section_Name.."_Dot"
					Section.Parent = PageList
					Section.Size = UDim2.new(0, 415, 0, 100)
					Section.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
					table.insert(UpdateCallBack["Background 3 Color"],function() 
						Section.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
					end)
					Section.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
					table.insert(UpdateCallBack["Background 1 Transparency"],function() 
						Section.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
					end)
					UICorner.CornerRadius = UDim.new(0, 4)
					UICorner.Parent = Section
					Topsec.Name = "Topsec"
					Topsec.Parent = Section
					Topsec.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					Topsec.BackgroundTransparency = 1.000
					Topsec.Size = UDim2.new(0, 415, 0, 30)
					Sectiontitle.Name = "Sectiontitle"
					Sectiontitle.Parent = Topsec
					Sectiontitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					Sectiontitle.BackgroundTransparency = 1.000
					Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
					Sectiontitle.Font = Enum.Font.GothamBold
					Sectiontitle.Text = Section_Name
					Sectiontitle.TextSize = 14.000
					Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]
					table.insert(UpdateCallBack["Section Text Color"],function() 
						Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]
					end)
					Linesec.Name = "Linesec"
					Linesec.Parent = Topsec
					Linesec.AnchorPoint = Vector2.new(0.5, 1)
					Linesec.BorderSizePixel = 0
					Linesec.Position = UDim2.new(0.5, 0, 1, -2)
					Linesec.Size = UDim2.new(1, -10, 0, 2)
					Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					table.insert(UpdateCallBack["Section Underline Color"],function() 
						Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					end)
					UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.51, 0.02), NumberSequenceKeypoint.new(1.00, 1.00)}
					UIGradient.Parent = Linesec
					SectionList.Name = "SectionList"
					SectionList.Parent = Section
					SectionList.SortOrder = Enum.SortOrder.LayoutOrder
					SectionList.Padding = UDim.new(0, 5)
					SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						Section.Size = UDim2.new(1, -5, 0, SectionList.AbsoluteContentSize.Y + 5)
					end)
					local Section_Function = {}
					   function Section_Function.CreateToggle(Setting, Callback)
							local Title = tostring(Setting.Title)
							local Desc = Setting.Desc
							local Default = Setting.Default
							if Default == nil then Default = false end
							local Callback = Callback or function() end
							local ToggleFrame = Instance.new("Frame")
							local TogFrame1 = Instance.new("Frame")
							local checkbox = Instance.new("ImageLabel")
							local check = Instance.new("ImageLabel")
							local ToggleDesc = Instance.new("TextLabel")
							local ToggleTitle = Instance.new("TextLabel")
							local ToggleBg = Instance.new("Frame")
							local ToggleCorner = Instance.new("UICorner")
							local ToggleButton = Instance.new("TextButton")
							local ToggleList = Instance.new("UIListLayout")
							ToggleFrame.Name = "ToggleFrame"
							ToggleFrame.Parent = Section
							ToggleFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ToggleFrame.BackgroundTransparency = 1.000
							ToggleFrame.Position = UDim2.new(0, 0, 0.300000012, 0)
							ToggleFrame.Size = UDim2.new(1, 0, 0, 0)
							ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
							TogFrame1.Name = "TogFrame1"
							TogFrame1.Parent = ToggleFrame
							TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
							TogFrame1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TogFrame1.BackgroundTransparency = 1.000
							TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
							TogFrame1.Size = UDim2.new(1, -10, 0, 0)
							TogFrame1.AutomaticSize = Enum.AutomaticSize.Y
							checkbox.Name = "checkbox"
							checkbox.Parent = TogFrame1
							checkbox.AnchorPoint = Vector2.new(1, 0.5)
							checkbox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							checkbox.BackgroundTransparency = 1.000
							checkbox.Position = UDim2.new(1, -5, 0.5, 3)
							checkbox.Size = UDim2.new(0, 25, 0, 25)
							checkbox.Image = "rbxassetid://4552505888"
							checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
							table.insert(UpdateCallBack["Toggle Border Color"],function() 
								checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
							end)
							check.Name = "check"
							check.Parent = checkbox
							check.AnchorPoint = Vector2.new(0, 1)
							check.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							check.BackgroundTransparency = 1.000
							check.Position = UDim2.new(0, 0, 1, 0)
							check.Image = "rbxassetid://4555411759"
							check.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
							table.insert(UpdateCallBack["Toggle Checked Color"],function() 
								check.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
							end)
							local cac = 5
							if Desc then
								cac = 0
								ToggleDesc.Name = "ToggleDesc"
								ToggleDesc.Parent = TogFrame1
								ToggleDesc.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								ToggleDesc.BackgroundTransparency = 1.000
								ToggleDesc.Position = UDim2.new(0, 15, 0, 20)
								ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
								ToggleDesc.Font = Enum.Font.GothamBlack
								ToggleDesc.Text = Desc
								ToggleDesc.TextSize = 13.000
								ToggleDesc.TextWrapped = true
								ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
								ToggleDesc.RichText = true
								ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
								ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
								table.insert(UpdateCallBack["Toggle Desc Color"],function() 
									ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
								end)
							else
								ToggleDesc.Text = ''
							end
							ToggleTitle.Name = "TextColor"
							ToggleTitle.Parent = TogFrame1
							ToggleTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ToggleTitle.BackgroundTransparency = 1.000
							ToggleTitle.Position = UDim2.new(0, 10, 0, cac)
							ToggleTitle.Size = UDim2.new(1, -10, 0, 20)
							ToggleTitle.Font = Enum.Font.GothamBlack
							ToggleTitle.Text = Title
							ToggleTitle.TextSize = 14.000
							ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
							ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
							ToggleTitle.RichText = true
							ToggleTitle.AutomaticSize = Enum.AutomaticSize.Y
							ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							ToggleBg.Name = "Background1"
							ToggleBg.Parent = TogFrame1
							ToggleBg.Size = UDim2.new(1, 0, 1, 6)
							ToggleBg.ZIndex = 0
							ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							table.insert(UpdateCallBack["Background 1 Color"],function() 
								ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							end)
							ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							ToggleCorner.CornerRadius = UDim.new(0, 4)
							ToggleCorner.Name = "ToggleCorner"
							ToggleCorner.Parent = ToggleBg
							ToggleButton.Name = "ToggleButton"
							ToggleButton.Parent = TogFrame1
							ToggleButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ToggleButton.BackgroundTransparency = 1.000
							ToggleButton.Size = UDim2.new(1, 0, 1, 6)
							ToggleButton.Font = Enum.Font.SourceSans
							ToggleButton.Text = ""
							ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
							ToggleButton.TextSize = 14.000
							ToggleList.Name = "ToggleList"
							ToggleList.Parent = ToggleFrame
							ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
							ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
							ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
							ToggleList.Padding = UDim.new(0, 5)
							local function ChangeStage(val)
								local csize = val and UDim2.new(1,-4,1,-4) or UDim2.new(0,0,0,0)
								local pos = val and UDim2.new(.5,0,.5,0) or UDim2.new(0,0,1,0)
								local apos = val and Vector2.new(.5,.5) or Vector2.new(0,1)
								game.TweenService:Create(check,TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),{Size = csize, Position = pos, AnchorPoint = apos}):Play()
								Callback(val)
							end
							if Callback then ChangeStage(Default) end 
							ToggleButton.MouseButton1Click:Connect(function()
								Library_Function.ButtonEffect()
							end)
							local function ButtonClick() 
								Default = not Default
								ChangeStage(Default)
							end
							ToggleButton.MouseButton1Down:Connect(function()
								ButtonClick()
							end)
							local tog_func = {}
									function tog_func.SetStage(value)
										if value ~= Default then 
											ButtonClick()
										end
									end
							return tog_func
						end
						function Section_Function.CreateButton(Setting, Callback)
							local Title = Setting.Title
							local Callback = Callback or function() end
							local ButtonFrame = Instance.new("Frame")
							local ButtonBG = Instance.new("Frame")
							local ButtonCorner = Instance.new("UICorner")
							local ButtonTitle = Instance.new("TextLabel")
							local Button = Instance.new("TextButton")
							ButtonFrame.Name = Title..'dot'
							ButtonFrame.Parent = Section
							ButtonFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ButtonFrame.BackgroundTransparency = 1.000
							ButtonFrame.Position = UDim2.new(0, 0, 0.300000012, 0)
							ButtonFrame.Size = UDim2.new(1, 0, 0, 25)
							ButtonBG.Name = "ButtonBG"
							ButtonBG.Parent = ButtonFrame
							ButtonBG.AnchorPoint = Vector2.new(0.5, 0.5)
							ButtonBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							ButtonBG.Size = UDim2.new(1, -10, 1, 0)
							ButtonBG.BackgroundColor3 = getgenv().UIColor["Button Color"]
							table.insert(UpdateCallBack["Button Color"],function() 
								ButtonBG.BackgroundColor3 = getgenv().UIColor["Button Color"]
							end)
							ButtonBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								ButtonBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							ButtonCorner.CornerRadius = UDim.new(0, 4)
							ButtonCorner.Name = "ButtonCorner"
							ButtonCorner.Parent = ButtonBG
							ButtonTitle.Name = "TextColor"
							ButtonTitle.Parent = ButtonBG
							ButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ButtonTitle.BackgroundTransparency = 1.000
							ButtonTitle.Position = UDim2.new(0, 10, 0, 0)
							ButtonTitle.Size = UDim2.new(1, -10, 1, 0)
							ButtonTitle.Font = Enum.Font.GothamBlack
							ButtonTitle.Text = Title
							ButtonTitle.TextSize = 14.000
							ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
							ButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								ButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							Button.Name = "Button"
							Button.Parent = ButtonBG
							Button.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Button.BackgroundTransparency = 1.000
							Button.Size = UDim2.new(1, 0, 1, 0)
							Button.Font = Enum.Font.SourceSans
							Button.Text = ""
							Button.TextColor3 = Color3.fromRGB(0, 0, 0)
							Button.TextSize = 14.000
							Button.MouseButton1Click:Connect(function()
								Library_Function.ButtonEffect()
							end)
							Button.MouseButton1Down:Connect(function()
								Callback()
							end)
						end
						function Section_Function.CreateLabel(Setting)
							local Title = tostring(Setting.Title)
							local LabelFrame = Instance.new("Frame")
							local LabelBG = Instance.new("Frame")
							local LabelCorner = Instance.new("UICorner")
							local LabelTitle = Instance.new("TextLabel")
							LabelFrame.Name = "LabelFrame"
							LabelFrame.Parent = Section
							LabelFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							LabelFrame.BackgroundTransparency = 1.000
							LabelFrame.Position = UDim2.new(0, 0, 0, 0)
							LabelFrame.Size = UDim2.new(1, 0, 0, 0)
							LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
							LabelBG.Name = "LabelBG"
							LabelBG.Parent = LabelFrame
							LabelBG.AnchorPoint = Vector2.new(0.5, 0)
							LabelBG.Position = UDim2.new(0.5, 0, 0, 0)
							LabelBG.Size = UDim2.new(1, -10, 0, -10)
							LabelBG.BackgroundColor3 = getgenv().UIColor["Label Color"]
							LabelBG.AutomaticSize = Enum.AutomaticSize.Y
							table.insert(UpdateCallBack["Label Color"],function() 
								LabelBG.BackgroundColor3 = getgenv().UIColor["Label Color"]
							end)
							LabelBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								LabelBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							LabelCorner.CornerRadius = UDim.new(0, 4)
							LabelCorner.Name = "LabelCorner"
							LabelCorner.Parent = LabelBG
							LabelTitle.Name = "TextColor"
							LabelTitle.Parent = LabelBG
							LabelTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							LabelTitle.BackgroundTransparency = 1.000
							LabelTitle.Position = UDim2.new(0, 10, 0, 3)
							LabelTitle.Size = UDim2.new(1, -20, 1, 0)
							LabelTitle.Font = Enum.Font.GothamBlack
							LabelTitle.Text = Title
							LabelTitle.TextSize = 14.000
							LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
							LabelTitle.AutomaticSize = Enum.AutomaticSize.Y
							LabelTitle.TextWrapped = true
							LabelTitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								LabelTitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							local label_func = {}
								function label_func.SetText(text)
									LabelTitle.Text = text
								end
								function label_func.SetColor(color)
									LabelTitle.TextColor3 = color
								end
							return label_func
						end
						function Section_Function.CreateDropdown(Setting, Callback)
							local Title = tostring(Setting.Title)
							local List = Setting.List
							local Search = Setting.Search or false
							local Selected = Setting.Selected or false
							local Default = Setting.Default
							local Callback = Callback or function() end
							local IndexTable = Setting.IndexTable
							local pairs = Setting.SortPairs or pairs
							local DropdownFrame = Instance.new("Frame")
							local Dropdownbg = Instance.new("Frame")
							local Dropdowncorner = Instance.new("UICorner")
							local Topdrop = Instance.new("Frame")
							local UICorner = Instance.new("UICorner")
							local ImgDrop = Instance.new("ImageLabel")
							local DropdownButton = Instance.new("TextButton")
							local Dropdownlisttt = Instance.new("Frame")
							local DropdownScroll = Instance.new("ScrollingFrame")
							local ScrollContainer = Instance.new("Frame")
							local ScrollContainerList = Instance.new("UIListLayout")
							local Dropdowntitle; 
							if Search then 
								Dropdowntitle = Instance.new("TextBox")
								DropdownButton.Visible = false
							else
								Dropdowntitle = Instance.new("TextLabel")
							end
							DropdownFrame.Name = Title.."DropdownFrame"
							DropdownFrame.Parent = Section
							DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							DropdownFrame.BackgroundTransparency = 1.000
							DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
							DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
							Dropdownbg.Name = "Background1"
							Dropdownbg.Parent = DropdownFrame
							Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
							Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
							Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
							Dropdownbg.ClipsDescendants = true
							Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							table.insert(UpdateCallBack["Background 1 Color"],function() 
								Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							end)
							Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							Dropdowncorner.CornerRadius = UDim.new(0, 4)
							Dropdowncorner.Name = "Dropdowncorner"
							Dropdowncorner.Parent = Dropdownbg
							Topdrop.Name = "Background2"
							Topdrop.Parent = Dropdownbg
							Topdrop.Size = UDim2.new(1, 0, 0, 25)
							Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							table.insert(UpdateCallBack["Background 2 Color"],function() 
								Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							end)
							Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							UICorner.CornerRadius = UDim.new(0, 4)
							UICorner.Parent = Topdrop
							Dropdowntitle.Name = "TextColorPlaceholder"
							Dropdowntitle.Parent = Topdrop
							Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Dropdowntitle.BackgroundTransparency = 1.000
							Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
							Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
							Dropdowntitle.Font = Enum.Font.GothamBlack
							Dropdowntitle.Text = ''
							Dropdowntitle.TextSize = 14.000
							Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
							Dropdowntitle.ClipsDescendants = true
							local Sel = Instance.new("IntValue",Dropdowntitle)
							Sel.Value=-1
							if Default and table.find(List,Default) then 
								Sel.Value=table.find(List,Default)
							end
							if not Selected then
								if Search then
									Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
									Dropdowntitle.PlaceholderText = Title..': '..tostring(Default); 
									table.insert(UpdateCallBack["Placeholder Text Color"],function() 
										Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
									end)
								else
									Dropdowntitle.Text = Title..': '..tostring(Default); 
								end
							else
								if Search then
									Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
									Dropdowntitle.PlaceholderText = Title..': '..tostring(Default); 
									table.insert(UpdateCallBack["Placeholder Text Color"],function() 
										Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
									end)
								else
									Dropdowntitle.Text = Title..': '..tostring(Default); 
								end
							end
							Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							ImgDrop.Name = "ImgDrop"
							ImgDrop.Parent = Topdrop
							ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
							ImgDrop.BackgroundTransparency = 1.000
							ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
							ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
							ImgDrop.Size = UDim2.new(0, 15, 0, 15)
							ImgDrop.Image = "rbxassetid://6954383209"
							ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
							table.insert(UpdateCallBack["Dropdown Icon Color"],function() 
								ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
							end)
							DropdownButton.Name = "DropdownButton"
							DropdownButton.Parent = Topdrop
							DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							DropdownButton.BackgroundTransparency = 1.000
							DropdownButton.Size = UDim2.new(1, 0, 1, 0)
							DropdownButton.Font = Enum.Font.GothamBold
							DropdownButton.Text = ""
							DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							DropdownButton.TextSize = 14.000
							Dropdownlisttt.Name = "Dropdownlisttt"
							Dropdownlisttt.Parent = Dropdownbg
							Dropdownlisttt.BackgroundTransparency = 1.000
							Dropdownlisttt.BorderSizePixel = 0
							Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
							Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
							Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							DropdownScroll.Name = "DropdownScroll"
							DropdownScroll.Parent = Dropdownlisttt
							DropdownScroll.Active = true
							DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							DropdownScroll.BackgroundTransparency = 1.000
							DropdownScroll.BorderSizePixel = 0
							DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
							DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
							DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
							DropdownScroll.ScrollBarThickness = 5
							DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
							ScrollContainer.Name = "ScrollContainer"
							ScrollContainer.Parent = DropdownScroll
							ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ScrollContainer.BackgroundTransparency = 1.000
							ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
							ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
							ScrollContainerList.Name = "ScrollContainerList"
							ScrollContainerList.Parent = ScrollContainer
							ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
							ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
								DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
							end)
							local isbusy = false
							local found = {}
							local searchtable = {}
							local function edit()
								for i in pairs(found) do
									found[i] = nil
								end
								for h, l in pairs(ScrollContainer:GetChildren()) do
									if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
										l.Visible = false
									end
								end
								Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
							end
							local function SearchDropdown()
								local Results = {}
								for i, v in pairs(searchtable) do
									if string.find(v, Dropdowntitle.Text) then
										table.insert(found, v)
									end
								end
								for a, b in pairs(ScrollContainer:GetChildren()) do
									for c, d in pairs(found) do
										if d == b.Name then
											b.Visible = true
										end
									end
								end
							end
							local function clear_object_in_list()
								for i,v in next, ScrollContainer:GetChildren() do 
									if v:IsA('Frame') then 
										v:Destroy()
									end
								end
							end
							local ListNew = List
							local function refreshlist()
								clear_object_in_list()
								searchtable = {}
								for i, v in pairs(ListNew) do
									if not Selected then 
									table.insert(searchtable, string.lower(v))
									else 
										table.insert(searchtable, string.lower(i))
									end 
								end
								if not Selected then 
									for i,v in pairs (ListNew) do
										local Dropval = Instance.new("Frame")
										local DropvalCorner = Instance.new("UICorner")
										local Line = Instance.new("Frame")
										local InLine = Instance.new("Frame")
										local LineCorner = Instance.new("UICorner")
										local Dropvalcontainer = Instance.new("Frame")
										local Dropvalbutton = Instance.new("TextButton")
										Dropval.Name = string.lower(v)
										Dropval.Parent = ScrollContainer
										Dropval.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropval.BackgroundTransparency = 1.000
										Dropval.Size = UDim2.new(1, 0, 0, 25)
										DropvalCorner.CornerRadius = UDim.new(0, 4)
										DropvalCorner.Name = "DropvalCorner"
										DropvalCorner.Parent = Dropval
										Line.Name = "Line"
										Line.Parent = Dropval
										Line.AnchorPoint = Vector2.new(0, 0.5)
										Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Line.BackgroundTransparency = 1.000
										Line.Position = UDim2.new(0, 0, 0.5, 0)
										Line.Size = UDim2.new(0, 14, 1, 0)
										InLine.Name = "InLine"
										InLine.Parent = Line
										InLine.AnchorPoint = Vector2.new(0.5, 0.5)
										InLine.BorderSizePixel = 0
										InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
										InLine.Size = UDim2.new(1, -10, 1, -10)
										InLine.BackgroundTransparency = 1
										InLine.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
										table.insert(UpdateCallBack["Dropdown Selected Color"],function() 
											InLine.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
										end)
										LineCorner.Name = "LineCorner"
										LineCorner.Parent = InLine
										Dropvalcontainer.Name = "Dropvalcontainer"
										Dropvalcontainer.Parent = Dropval
										Dropvalcontainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropvalcontainer.BackgroundTransparency = 1.000
										Dropvalcontainer.Position = UDim2.new(0, 15, 0, 0)
										Dropvalcontainer.Size = UDim2.new(1, -15, 1, 0)
										Dropvalbutton.Name = "TextColor"
										Dropvalbutton.Parent = Dropvalcontainer
										Dropvalbutton.Active = false
										Dropvalbutton.BackgroundTransparency = 1.000
										Dropvalbutton.Selectable = false
										Dropvalbutton.Size = UDim2.new(1, 0, 1, 0)
										Dropvalbutton.Font = Enum.Font.GothamBold
										Dropvalbutton.Text = v
										Dropvalbutton.TextSize = 14.000
										Dropvalbutton.TextWrapped = true
										Dropvalbutton.TextXAlignment = Enum.TextXAlignment.Left
										Dropvalbutton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropvalbutton.TextColor3 = getgenv().UIColor["Text Color"]
										table.insert(UpdateCallBack["Text Color"],function() 
											Dropvalbutton.TextColor3 = getgenv().UIColor["Text Color"]
										end)
										if Search then
											if Sel.Value == i then
												InLine.BackgroundTransparency = 0;
											end
										else
											if Sel.Value == i then
												InLine.BackgroundTransparency = 0;
											end
										end
										Dropvalbutton.MouseButton1Click:Connect(function()
											if Search then
												Dropdowntitle.PlaceholderText = Title..': '..v
												Sel.Value=i
											else
												Dropdowntitle.Text = Title..': '..v
												Sel.Value=i
											end
											refreshlist()
											if Callback then 
												Callback(v,i)
											end
										end)
										Dropvalbutton.MouseButton1Click:Connect(function()
											Library_Function.ButtonEffect()
										end)
									end
								else
									for i,v in pairs (ListNew) do
										local linetran = v and 0 or 1
										local Dropval = Instance.new("Frame")
										local DropvalCorner = Instance.new("UICorner")
										local Line = Instance.new("Frame")
										local InLine = Instance.new("Frame")
										local LineCorner = Instance.new("UICorner")
										local Dropvalcontainer = Instance.new("Frame")
										local Dropvalbutton = Instance.new("TextButton")
										Dropval.Name = string.lower(i)
										Dropval.Parent = ScrollContainer
										Dropval.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropval.BackgroundTransparency = 1.000
										Dropval.Size = UDim2.new(1, 0, 0, 25)
										DropvalCorner.CornerRadius = UDim.new(0, 4)
										DropvalCorner.Name = "DropvalCorner"
										DropvalCorner.Parent = Dropval
										Line.Name = "Line"
										Line.Parent = Dropval
										Line.AnchorPoint = Vector2.new(0, 0.5)
										Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Line.BackgroundTransparency = 1
										Line.Position = UDim2.new(0, 0, 0.5, 0)
										Line.Size = UDim2.new(0, 14, 1, 0)
										InLine.Name = "InLine"
										InLine.Parent = Line
										InLine.AnchorPoint = Vector2.new(0.5, 0.5)
										InLine.BorderSizePixel = 0
										InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
										InLine.Size = UDim2.new(1, -10, 1, -10)
										InLine.BackgroundTransparency = linetran
										InLine.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
										table.insert(UpdateCallBack["Dropdown Selected Color"],function() 
											InLine.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
										end)
										LineCorner.Name = "LineCorner"
										LineCorner.Parent = InLine
										Dropvalcontainer.Name = "Dropvalcontainer"
										Dropvalcontainer.Parent = Dropval
										Dropvalcontainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropvalcontainer.BackgroundTransparency = 1.000
										Dropvalcontainer.Position = UDim2.new(0, 15, 0, 0)
										Dropvalcontainer.Size = UDim2.new(1, -15, 1, 0)
										Dropvalbutton.Name = "TextColor"
										Dropvalbutton.Parent = Dropvalcontainer
										Dropvalbutton.Active = false
										Dropvalbutton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										Dropvalbutton.BackgroundTransparency = 1.000
										Dropvalbutton.Selectable = false
										Dropvalbutton.Size = UDim2.new(1, 0, 1, 0)
										Dropvalbutton.Font = Enum.Font.GothamBold
										Dropvalbutton.Text = i
										Dropvalbutton.TextSize = 14.000
										Dropvalbutton.TextWrapped = true
										Dropvalbutton.TextXAlignment = Enum.TextXAlignment.Left
										Dropvalbutton.TextColor3 = getgenv().UIColor["Text Color"]
										table.insert(UpdateCallBack["Text Color"],function() 
											Dropvalbutton.TextColor3 = getgenv().UIColor["Text Color"]
										end)
										Dropvalbutton.MouseButton1Click:Connect(function()
											Library_Function.ButtonEffect()
										end)
										Dropvalbutton.MouseButton1Click:Connect(function()
											v = not v 
											local linetran = v and 0 or 1
											TweenService:Create(InLine,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundTransparency = linetran}):Play()
											if Callback then
												Callback(i,v)
												ListNew[i] = v
											end
										end)
									end
								end
							end
							if Search then
								Dropdowntitle.Changed:Connect(function()
									edit()
									SearchDropdown()
								end)
							end
							if typeof(Default) ~= 'table' then
								Callback(Default)
								if Search then
									Dropdowntitle.PlaceholderText = Title..': '..tostring(Default)
								else
									Dropdowntitle.Text = Title..': '..tostring(Default)
								end
							elseif Selected then
								for i,v in next, Default do
									ListNew[i] = v
									Callback(i,v)
								end
								Dropdowntitle.Text = ''
								Dropdowntitle.PlaceholderText = Title..': '
							end
							DropdownButton.MouseButton1Click:Connect(function()
								refreshlist()
								isbusy = not isbusy
								local listsize = isbusy and UDim2.new(1, 0,0, 170) or UDim2.new(1, 0,0, 0)
								local mainsize = isbusy and UDim2.new(1, 0,0, 200) or UDim2.new(1, 0,0, 25)
								local DropCRotation = isbusy and 90 or 0
								TweenService:Create(Dropdownlisttt,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = listsize}):Play()
								TweenService:Create(DropdownFrame,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = mainsize}):Play()
								TweenService:Create(ImgDrop,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Rotation = DropCRotation}):Play()
							end)
							DropdownButton.MouseButton1Click:Connect(function()
								Library_Function.ButtonEffect()
							end)
							if Search then
								Dropdowntitle.Focused:Connect(function()
									refreshlist()
									isbusy = not isbusy
									local listsize = isbusy and UDim2.new(1, 0,0, 170) or UDim2.new(1, 0,0, 0)
									local mainsize = isbusy and UDim2.new(1, 0,0, 200) or UDim2.new(1, 0,0, 25)
									local DropCRotation = isbusy and 90 or 0
									TweenService:Create(Dropdownlisttt,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = listsize}):Play()
									TweenService:Create(DropdownFrame,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = mainsize}):Play()
									TweenService:Create(ImgDrop,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Rotation = DropCRotation}):Play()
								end)
								Dropdowntitle.Focused:Connect(function()
									Library_Function.ButtonEffect()
								end)
							end
							local dropdown_function = {rf=refreshlist}
							function dropdown_function:ClearText()
								if not Selected then
									if Search then
										Dropdowntitle.PlaceholderText = Title..': '
									else
										Dropdowntitle.Text = Title..': ' 
									end
								else
									Dropdowntitle.Text = Title..': '
								end
							end
							function dropdown_function:GetNewList(List)
								refreshlist()
								isbusy = false
								local listsize = isbusy and UDim2.new(1, 0,0, 170) or UDim2.new(1, 0,0, 0)
								local mainsize = isbusy and UDim2.new(1, 0,0, 200) or UDim2.new(1, 0,0, 25)
								local DropCRotation = isbusy and 90 or 0
								TweenService:Create(Dropdownlisttt,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = listsize}):Play()
								TweenService:Create(DropdownFrame,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Size = mainsize}):Play()
								TweenService:Create(ImgDrop,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{Rotation = DropCRotation}):Play()
								ListNew = {}
								ListNew = List
								for i,v in next, ListNew do
									if Selected then
										Callback(i,v)
									end
								end
							end
							return dropdown_function
						end
						function Section_Function.CreateBind(Setting, Callback)
							local TitleText = tostring(Setting.Title) or ""
							local KeyCode = Setting.Key
							local Default = Setting.Default or Setting.Key
							local Type = tostring(Default):match("UserInputType") and "UserInputType" or "KeyCode"
							local Callback = Callback or function() end
							KeyCode = tostring(KeyCode):gsub("Enum.UserInputType.", "")
							KeyCode = tostring(KeyCode):gsub("Enum.KeyCode.", "")
							local BindFrame = Instance.new("Frame")
							local BindCorner = Instance.new("UICorner")
							local BindBG = Instance.new("Frame")
							local ButtonCorner = Instance.new("UICorner")
							local BindButtonTitle = Instance.new("TextLabel")
							local Button = Instance.new("TextButton")
							local BindCor = Instance.new("Frame")
							local ButtonCorner_2 = Instance.new("UICorner")
							local Bindkey = Instance.new("TextButton")
							BindFrame.Name = TitleText.."bguvl"
							BindFrame.Parent = Section
							BindFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							BindFrame.BackgroundTransparency = 1.000
							BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							BindFrame.Size = UDim2.new(1, 0, 0, 35)
							BindCorner.CornerRadius = UDim.new(0, 4)
							BindCorner.Name = "BindCorner"
							BindCorner.Parent = BindFrame
							BindBG.Name = "Background1"
							BindBG.Parent = BindFrame
							BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
							BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							BindBG.Size = UDim2.new(1, -10, 1, 0)
							BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							table.insert(UpdateCallBack["Background 1 Color"],function() 
								BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							end)
							BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							ButtonCorner.CornerRadius = UDim.new(0, 4)
							ButtonCorner.Name = "ButtonCorner"
							ButtonCorner.Parent = BindBG
							BindButtonTitle.Name = "TextColor"
							BindButtonTitle.Parent = BindBG
							BindButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							BindButtonTitle.BackgroundTransparency = 1.000
							BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
							BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
							BindButtonTitle.Font = Enum.Font.GothamBlack
							BindButtonTitle.Text = TitleText
							BindButtonTitle.TextSize = 14.000
							BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
							BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							BindCor.Name = "Background2"
							BindCor.Parent = BindBG
							BindCor.AnchorPoint = Vector2.new(1, 0.5)
							BindCor.Position = UDim2.new(1, -5, 0.5, 0)
							BindCor.Size = UDim2.new(0, 150, 0, 25)
							BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							table.insert(UpdateCallBack["Background 2 Color"],function() 
								BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							end)
							ButtonCorner_2.CornerRadius = UDim.new(0, 4)
							ButtonCorner_2.Name = "ButtonCorner"
							ButtonCorner_2.Parent = BindCor
							Bindkey.Name = "Bindkey"
							Bindkey.Parent = BindCor
							Bindkey.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Bindkey.BackgroundTransparency = 1.000
							Bindkey.Size = UDim2.new(1, 0, 1, 0)
							Bindkey.Font = Enum.Font.GothamBold
							Bindkey.Text = tostring(Default):gsub("Enum.KeyCode.", "");
							Bindkey.TextSize = 14.000
							Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							local WhitelistedType = {
								[Enum.UserInputType.MouseButton1] = "Mouse1";
								[Enum.UserInputType.MouseButton2] = "Mouse2";
								[Enum.UserInputType.MouseButton3] = "Mouse3";
							};
							Bindkey.MouseButton1Click:Connect(function()
								Library_Function.ButtonEffect()
							end)
							Bindkey.MouseButton1Click:Connect(function()
								local Connection;
								Bindkey.Text = "...";
								Connection = game:GetService("UserInputService").InputBegan:Connect(function(i)
									if WhitelistedType[i.UserInputType] then
										Bindkey.Text = WhitelistedType[i.UserInputType];
										spawn(function()
											wait(0.1)
											Default = i.UserInputType;
											Type = "UserInputType";
										end);
									elseif i.KeyCode ~= Enum.KeyCode.Unknown then
										Bindkey.Text = tostring(i.KeyCode):gsub("Enum.KeyCode.", "");
										spawn(function()
											wait(0.1)
											Default = i.KeyCode;
											Type = "KeyCode";
										end);
									end;
									Connection:Disconnect();
								end);
							end);
							game:GetService("UserInputService").InputBegan:Connect(function(i)
								if (Default == i.UserInputType or Default == i.KeyCode) then
									Callback(Default);
								end;
							end);
						end
						function Section_Function.CreateBox(Setting, Callback)
							local TitleText = tostring(Setting.Title) or ""
							local Placeholder = tostring(Setting.Placeholder) or ""
							local Default = Setting.Default or false
							local Number_Only = Setting.Number or false 
							local Callback = Callback or function() end
							local BoxFrame = Instance.new("Frame")
							local BoxCorner = Instance.new("UICorner")
							local BoxBG = Instance.new("Frame")
							local ButtonCorner = Instance.new("UICorner")
							local Boxtitle = Instance.new("TextLabel")
							local BoxCor = Instance.new("Frame")
							local ButtonCorner_2 = Instance.new("UICorner")
							local Boxxx = Instance.new("TextBox")
							local Lineeeee = Instance.new("Frame")
							local UICorner = Instance.new("UICorner")
							BoxFrame.Name = "BoxFrame"
							BoxFrame.Parent = Section
							BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							BoxFrame.BackgroundTransparency = 1.000
							BoxFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							BoxFrame.Size = UDim2.new(1, 0, 0, 60)
							BoxCorner.CornerRadius = UDim.new(0, 4)
							BoxCorner.Name = "BoxCorner"
							BoxCorner.Parent = BoxFrame
							BoxBG.Name = "Background1"
							BoxBG.Parent = BoxFrame
							BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
							BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							BoxBG.Size = UDim2.new(1, -10, 1, 0)
							BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							table.insert(UpdateCallBack["Background 1 Color"],function() 
								BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							end)
							BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							ButtonCorner.CornerRadius = UDim.new(0, 4)
							ButtonCorner.Name = "ButtonCorner"
							ButtonCorner.Parent = BoxBG
							Boxtitle.Name = "TextColor"
							Boxtitle.Parent = BoxBG
							Boxtitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Boxtitle.BackgroundTransparency = 1.000
							Boxtitle.Position = UDim2.new(0, 10, 0, 0)
							Boxtitle.Size = UDim2.new(1, -10, 0.5, 0)
							Boxtitle.Font = Enum.Font.GothamBlack
							Boxtitle.Text = TitleText
							Boxtitle.TextSize = 14.000
							Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
							Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							BoxCor.Name = "Background2"
							BoxCor.Parent = BoxBG
							BoxCor.AnchorPoint = Vector2.new(1, 0.5)
							BoxCor.ClipsDescendants = true
							BoxCor.Position = UDim2.new(1, -5, 0, 40)
							BoxCor.Size = UDim2.new(1, -10, 0, 25)
							BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							table.insert(UpdateCallBack["Background 2 Color"],function() 
								BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							end)
							ButtonCorner_2.CornerRadius = UDim.new(0, 4)
							ButtonCorner_2.Name = "ButtonCorner"
							ButtonCorner_2.Parent = BoxCor
							Boxxx.Name = "TextColorPlaceholder"
							Boxxx.Parent = BoxCor
							Boxxx.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Boxxx.BackgroundTransparency = 1.000
							Boxxx.Position = UDim2.new(0, 5, 0, 0)
							Boxxx.Size = UDim2.new(1, -5, 1, 0)
							Boxxx.Font = Enum.Font.GothamBold
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ""
							Boxxx.TextSize = 14.000
							Boxxx.TextXAlignment = Enum.TextXAlignment.Left
							Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
							Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Placeholder Text Color"],function() 
								Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
							end)
							table.insert(UpdateCallBack["Text Color"],function() 
								Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							Lineeeee.Name = "TextNSBoxLineeeee"
							Lineeeee.Parent = BoxCor
							Lineeeee.BackgroundTransparency = 1.000
							Lineeeee.Position = UDim2.new(0, 0, 1, -2)
							Lineeeee.Size = UDim2.new(1, 0, 0, 6)
							Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
							table.insert(UpdateCallBack["Box Highlight Color"],function() 
								Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
							end)
							UICorner.CornerRadius = UDim.new(1, 0)
							UICorner.Parent = Lineeeee
							Boxxx.Focused:Connect(function() 
								TweenService:Create(Lineeeee,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundTransparency = 0}):Play()
							end)
							Boxxx.Focused:Connect(function() 
								Library_Function.ButtonEffect()
							end)
							if Number_Only then 
								Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
									if tonumber(Boxxx.Text) then 
									else 
										Boxxx.PlaceholderText = Placeholder
										Boxxx.Text = ''
									end
								end)
							end
							Boxxx.FocusLost:Connect(function()
								TweenService:Create(Lineeeee,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundTransparency = 1}):Play()
								if Boxxx.Text ~= '' then
									Callback(Boxxx.Text)
								end
							end)
							local textbox_function = {}
							if Default then
								Boxxx.Text = Default
								Callback(Default)
							end
							function textbox_function.SetValue(Value)
								Boxxx.Text = Value
								Callback(Value)
							end 
							return textbox_function;
						end
						function Section_Function.CreateSlider(Setting, Callback)
							local TitleText = tostring(Setting.Title) or ""
							local Min_Value = tonumber(Setting.Min) or 0
							local Max_Value = tonumber(Setting.Max) or 100
							local Precise = Setting.Precise or false
							local DefaultValue = tonumber(Setting.Default) or 0
							local Callback = Callback or function() end
							local SizeChia = 400;
							local Callback = Callback or function() end
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = TitleText..'buda'
							SliderFrame.Parent = Section
							SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 4)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							table.insert(UpdateCallBack["Background 1 Color"],function() 
								SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							end)
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							table.insert(UpdateCallBack["Background 1 Transparency"],function() 
								SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							end)
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(0, 400, 0, 6)
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							table.insert(UpdateCallBack["Background 2 Color"],function() 
								SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							end)
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							table.insert(UpdateCallBack["Slider Line Color"],function() 
								Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							end)
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							table.insert(UpdateCallBack["Background 2 Color"],function() 
								Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							end)
							Sliderbox.CornerRadius = UDim.new(0, 4)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							table.insert(UpdateCallBack["Text Color"],function() 
								Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							end)
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar,TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]),{BackgroundColor3 = getgenv().UIColor["Slider Line Color"]}):Play()
							end)
							local mouse = game.Players.LocalPlayer:GetMouse()
							if DefaultValue then 
								if DefaultValue <= Min_Value then DefaultValue = Min_Value elseif DefaultValue >= Max_Value then DefaultValue = Max_Value end
								Bar.Size = UDim2.new(1 - ((Max_Value - DefaultValue) / (Max_Value - Min_Value)),0, 0, 6)
								Sliderbox_2.Text = DefaultValue
								Callback(DefaultValue)
							end
							SliderButton.MouseButton1Down:Connect(function()
								local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
								pcall(function()
									Callback(value)
									Sliderbox_2.Text = value
								end)
								Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
								moveconnection = mouse.Move:Connect(function()   
									local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
									pcall(function()
										Callback(value)
										Sliderbox_2.Text = value
									end)
									Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
								end)
								releaseconnection = uis.InputEnded:Connect(function(Mouse)
									if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
										local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
										pcall(function()
											Callback(value)
											Sliderbox_2.Text = value
										end)
										Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
										moveconnection:Disconnect()
										releaseconnection:Disconnect()
									end
								end)
							end)
							local function GetSliderValue(Value)
								if tonumber(Value) <= Min_Value then
									Bar.Size = UDim2.new(0,(0 * SizeChia), 0, 6)
									Sliderbox_2.Text = Min_Value
									Callback(tonumber(Min_Value))
								elseif tonumber(Value) >= Max_Value then
									Bar.Size = UDim2.new(0,(Max_Value  /  Max_Value * SizeChia), 0, 6)
									Sliderbox_2.Text = Max_Value
									Callback(tonumber(Max_Value))
								else
									Bar.Size = UDim2.new(1 - ((Max_Value - Value) / (Max_Value - Min_Value)),0, 0, 6)
									Callback(tonumber(Value))
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
							local slider_function = {}
							function slider_function.SetValue(Value)
								GetSliderValue(Value)
							end
							return slider_function
						end
					return Section_Function
				end
			return Page_Function
		end
		return Main_Function
	end
	return Library
