
local SelfModules = {
    Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}
DefaultConfig  = {
    Model="https://github.com/MuhXd/DoorSuff/blob/main/ScreechSpawner/ScreechDefault.rbxm?raw=true",
    Hurts = true,
}
local Screech = {}

Screech.Run = function(Model)
    
FakeScreech2 = Model.entity
  
		local v1 = script:FindFirstAncestor("MainUI");
		local l__LocalPlayer__2 = game.Players.LocalPlayer;
		local u1 = 0;
		local l__TweenService__2 = game:GetService("TweenService");
	
		p1 = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
		local v3 = FakeScreech2
			local v4 = math.random(-1, 1) * 2;
			if v4 < 0 then
				v4 = -1.1;
			end;
			u1 = u1 + 1;
			local l__unit__5 = (p1.finalCamCFrame.LookVector * Vector3.new(-1, 0, -1) + Vector3.new(0, v4, 0)).unit;
			local l__p__6 = p1.finalCamCFrame.p;
			v3:SetPrimaryPartCFrame(CFrame.new(l__p__6 + l__unit__5 * 4, l__p__6) * CFrame.new(0, 0.5, 0));
			v3.Parent = p1.cam;
			local v7 = {};
			for v8, v9 in pairs(v3.Animations:GetChildren()) do
				if v9:IsA("Animation") then
					v7[v9.Name] = v3.AnimationController:LoadAnimation(v9);
				end;
			end;
			local v10 = tick();
			v7.Idle:Play();
			delay(math.random(1, 10) / 5, function()
				v3.Root.Sound:Play();
			end);
			local v11 = tick();
			local v12 = 5 + math.random(1, 10) / 5;
			local u3 = false;
			local u4 = v3.PrimaryPart.CFrame;
			local u5 = true;
			local l__PointLight__6 = v3.Base.Attachment.PointLight;
			local u7 = 0;
			local u8 = false;
			local v13 = game:GetService("RunService"):BindToRenderStep("screechStuff" .. u1, 100, function(p4)
				if not u3 then
					v3.PrimaryPart.CFrame = u4;
					
				else
					game:GetService("RunService"):UnbindFromRenderStep("screechStuff" .. u1);
				end;

				if u5 then
					local v14 = (p1.finalCamCFrame.LookVector.unit - l__unit__5).Magnitude * 100;
					l__PointLight__6.Brightness = math.clamp(50 - v14, 0, 50) / 50;
					if v14 < 35 then
						u7 = u7 + p4;
					end;
					if u7 >= 0.1 then
						u8 = true;
					end;
				end;
			end);
							 Model.Debug.Spawned(FakeScreech2.Name)
			p1.camShaker:ShakeOnce(0.5, 12, 3, 1);
			for v15 = 1, 1000000 do
				task.wait();
				local l__p__16 = p1.finalCamCFrame.p;
				u4 = CFrame.new(l__p__16 + l__unit__5 * 3.5, l__p__16) * CFrame.new(0, 0.5, 0);
				if v11 + v12 < tick() then
					break;
				end;
				if u8 then
					break;
				end;
			end;
			local v17 = tick();
			local l__CFrame__18 = v3.PrimaryPart.CFrame;
			if u8 then
			v7.Caught:Play();
				Model.Debug.Looked(FakeScreech2.Name)
			p1.camShaker:ShakeOnce(8, 42, 0, 1);
	
		else
	v7.Attack:Play();
	Model.Debug.TimeOut(FakeScreech2.Name)
	if Model.Config.Hurts == true then
	game.Players.LocalPlayer.Character.Humanoid.Health = game.Players.LocalPlayer.Character.Humanoid.Health - 30
	end
	p1.camShaker:ShakeOnce(6, 42, 0, 1);
			end;
			v3.Root.Sound:Stop();
			l__PointLight__6.Brightness = 1;
			local v19, v20, v21 = CFrame.new(Vector3.new(0, 0, 0), l__unit__5):ToOrientation();
			if math.abs(p1.ax - math.deg(v20)) > 180 then
				p1.ax_t = p1.ax_t - 360;
			end;
			p1.ax_t = math.deg(v20);
			p1.ay_t = math.deg(v19);
			-- Removed: Bricks.Screech does not exist in this DOORS version
			u5 = false;
			for v22 = 1, 1000000 do
				task.wait();
				local l__p__23 = p1.finalCamCFrame.p;
				u4 = l__CFrame__18:Lerp(CFrame.new(l__p__23 + l__unit__5 * 3.5, l__p__23) * CFrame.new(0, 0.5, 0), (l__TweenService__2:GetValue((tick() - v17) / 0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In)));
				if v17 + 0.1 < tick() then
					break;
				end;
			end;
			local v24 = tick();
			for v25 = 1, 1000000 do
				task.wait();
				u4 = CFrame.new(p1.finalCamCFrame.Position + p1.finalCamCFrame.LookVector * 3, p1.finalCamCFrame.Position) * CFrame.new(0, 0.5, 0);
				if v24 + 2 < tick() then
					break;
				end;
			end;
			u3 = true;
			NameofModel = FakeScreech2.Name
			v3:Destroy();
				Model.Debug.Despawned(NameofModel)
		game:GetService("RunService"):UnbindFromRenderStep("screechStuff" .. u1);
end

	Screech.createEntity = function(configs)
      -- Prepare configs

    assert(typeof(configs) == "table")
    assert(configs.Model)

    for i, v in next, DefaultConfig do
        if configs[i] == nil then
            configs[i] = DefaultConfig[i]
        end
    end
    ModelTest = LoadCustomInstance(configs.Model)
    ModelTest.Parent = game.ReplicatedStorage
    return {
        entity = ModelTest,
        Config = configs,
        Debug = {
                    Looked = function() end,
                     Spawned = function() end,
                      TimeOut = function() end,
                      DeSpawned = function() end,
                }
    }
	end
return Screech
