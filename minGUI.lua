-- Gui to Lua
-- Version: 3.2

-- Instances:

local Minimised = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local CloseBtn = Instance.new("TextButton")
local MaximiseBtn = Instance.new("ImageButton")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")

--Properties:

Minimised.Name = "Minimised"
Minimised.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Minimised.Enabled = false
Minimised.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Minimised.ResetOnSpawn = false

Frame.Parent = Minimised
Frame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Frame.BackgroundTransparency = 0.300
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.206434309, 0, 0.215675086, 0)
Frame.Size = UDim2.new(0, 304, 0, 54)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.031737078, 0, 0.205460727, 0)
TextLabel.Size = UDim2.new(0, 202, 0, 29)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = "Strong Simulator - @axur.e"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 20.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundTransparency = 1.000
CloseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(0.902266443, 0, 0.231161043, 0)
CloseBtn.Size = UDim2.new(0, 29, 0, 29)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(89, 89, 89)
CloseBtn.TextScaled = true
CloseBtn.TextSize = 14.000
CloseBtn.TextWrapped = true

MaximiseBtn.Name = "MaximiseBtn"
MaximiseBtn.Parent = Frame
MaximiseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MaximiseBtn.BackgroundTransparency = 1.000
MaximiseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
MaximiseBtn.BorderSizePixel = 0
MaximiseBtn.Position = UDim2.new(0.829999983, 0, 0.240999997, 0)
MaximiseBtn.Size = UDim2.new(0, 27, 0, 28)
MaximiseBtn.Image = "http://www.roblox.com/asset/?id=125183881079466"

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame_2.BackgroundTransparency = 0.300
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(-0.00080249185, 0, 0.781000018, 0)
Frame_2.Size = UDim2.new(0, 304, 0, 12)

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Minimised

-- Module Scripts:

local fake_module_scripts = {}

do -- Minimised.DragModule2
	local script = Instance.new('ModuleScript', Minimised)
	script.Name = "DragModule2"
	local function module_script()
		--[[
			@Author: Spynaz
			@Description: Enables dragging on GuiObjects. Supports both mouse and touch.
			
			For instructions on how to use this module, go to this link:
			https://devforum.roblox.com/t/simple-module-for-creating-draggable-gui-elements/230678
		--]]
		
		local UDim2_new = UDim2.new
		
		local UserInputService = game:GetService("UserInputService")
		
		local DraggableObject 		= {}
		DraggableObject.__index 	= DraggableObject
		
		-- Sets up a new draggable object
		function DraggableObject.new(Object)
			local self 			= {}
			self.Object			= Object
			self.DragStarted	= nil
			self.DragEnded		= nil
			self.Dragged		= nil
			self.Dragging		= false
			
			setmetatable(self, DraggableObject)
			
			return self
		end
		
		-- Enables dragging
		function DraggableObject:Enable()
			local object			= self.Object
			local dragInput			= nil
			local dragStart			= nil
			local startPos			= nil
			local preparingToDrag	= false
			
			-- Updates the element
			local function update(input)
				local delta 		= input.Position - dragStart
				local newPosition	= UDim2_new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				object.Position 	= newPosition
			
				return newPosition
			end
			
			self.InputBegan = object.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					preparingToDrag = true
					--[[if self.DragStarted then
						self.DragStarted()
					end
					
					dragging	 	= true
					dragStart 		= input.Position
					startPos 		= Element.Position
					--]]
					
					local connection 
					connection = input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag) then
							self.Dragging = false
							connection:Disconnect()
							
							if self.DragEnded and not preparingToDrag then
								self.DragEnded()
							end
							
							preparingToDrag = false
						end
					end)
				end
			end)
			
			self.InputChanged = object.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			
			self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
				if object.Parent == nil then
					self:Disable()
					return
				end
				
				if preparingToDrag then
					preparingToDrag = false
					
					if self.DragStarted then
						self.DragStarted()
					end
					
					self.Dragging	= true
					dragStart 		= input.Position
					startPos 		= object.Position
				end
				
				if input == dragInput and self.Dragging then
					local newPosition = update(input)
					
					if self.Dragged then
						self.Dragged(newPosition)
					end
				end
			end)
		end
		
		-- Disables dragging
		function DraggableObject:Disable()
			self.InputBegan:Disconnect()
			self.InputChanged:Disconnect()
			self.InputChanged2:Disconnect()
			
			if self.Dragging then
				self.Dragging = false
				
				if self.DragEnded then
					self.DragEnded()
				end
			end
		end
		
		return DraggableObject
		
	end
	fake_module_scripts[script] = module_script
end


-- Scripts:

local function YUYC_fake_script() -- CloseBtn.LocalScript 
	local script = Instance.new('LocalScript', CloseBtn)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	script.Parent.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
		game.Players.LocalPlayer.PlayerGui.Minimised:Destroy()
	end)
end
coroutine.wrap(YUYC_fake_script)()
local function UMODAU_fake_script() -- MaximiseBtn.LocalScript 
	local script = Instance.new('LocalScript', MaximiseBtn)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	script.Parent.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer.PlayerGui.Minimised.Enabled = false
		game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
	end)
end
coroutine.wrap(UMODAU_fake_script)()
local function HUHR_fake_script() -- Minimised.DragGUI 
	local script = Instance.new('LocalScript', Minimised)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local DraggableObject = require(script.Parent.DragModule2)
	local FrameDrag = DraggableObject.new(script.Parent.Frame)
	
	FrameDrag:Enable()
end
coroutine.wrap(HUHR_fake_script)()
