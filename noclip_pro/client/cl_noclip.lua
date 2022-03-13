local NoClipActive = false
local NoClipEntity
local timer

Citizen.CreateThread(function()
    while true do 
        if IsControlJustPressed(1, Config.Controls.openKey) then
            if NoClipActive then
                TriggerEvent('admin:toggleNoClip')

            else
                timer = 5000
                TriggerServerEvent('admin:noClip')
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()

     
    local index = 1
    local CurrentSpeed = Config.Speeds[index].speed
    local FollowCamMode = true

    while true do
        while NoClipActive do
            if not IsHudHidden() and Config.EnableHUD and timer > 0 then
                timer = timer - 10
                RenderScale(scaleform, index, FollowCamMode)          
            end

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
            else
                NoClipEntity = PlayerPedId()
            end

            local yoff = 0.0
            local zoff = 0.0

            DisableControls()

            if IsDisabledControlJustPressed(1, Config.Controls.camMode) then
                timer = 2000
                FollowCamMode = not FollowCamMode
            end

            if IsDisabledControlJustPressed(1, Config.Controls.changeSpeed) then
                timer = 2000
                if index ~= #Config.Speeds then
                    index = index+1
                    CurrentSpeed = Config.Speeds[index].speed
                else
                    CurrentSpeed = Config.Speeds[1].speed
                    index = 1
                end
               
            end
         
			if IsDisabledControlPressed(0, Config.Controls.goForward) then
                if Config.FrozenPosition then
                    yoff = -Config.Offsets.y
                else 
                    yoff = Config.Offsets.y
                end
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goBackward) then
                if Config.FrozenPosition then
                    yoff = Config.Offsets.y
                else
                    yoff = -Config.Offsets.y
                end
			end

            if not FollowCamMode and IsDisabledControlPressed(0, Config.Controls.turnLeft) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+Config.Offsets.h)
			end
			
            if not FollowCamMode and IsDisabledControlPressed(0, Config.Controls.turnRight) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-Config.Offsets.h)
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goUp) then
                zoff = Config.Offsets.z
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goDown) then
                zoff = -Config.Offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
            local heading = GetEntityHeading(NoClipEntity)
            SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
            if Config.FrozenPosition then
                SetEntityRotation(NoClipEntity, 0.0, 0.0, 180.0, 0, false)
            else 
                SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
            end
            if(FollowCamMode) then
                SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
            else
                SetEntityHeading(NoClipEntity, heading);
            end
            if Config.FrozenPosition then
                SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, not NoClipActive, not NoClipActive, not NoClipActive)
            else 
                SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, NoClipActive, NoClipActive, NoClipActive)
            end

            SetEntityAlpha(NoClipEntity, 51, 0)
            if(NoClipEntity ~= PlayerPedId()) then
                SetEntityAlpha(PlayerPedId(), 51, 0)
            end
            
            SetEntityCollision(NoClipEntity, false, false)
            FreezeEntityPosition(NoClipEntity, true)
            SetEntityInvincible(NoClipEntity, true)
            SetEntityVisible(NoClipEntity, false, false);
            SetEveryoneIgnorePlayer(PlayerPedId(), true);
            Citizen.Wait(0)
            
            ResetEntityAlpha(NoClipEntity)
            if(NoClipEntity ~= PlayerPedId()) then
                ResetEntityAlpha(PlayerPedId())
            end

            SetEntityCollision(NoClipEntity, true, true)
            FreezeEntityPosition(NoClipEntity, false)
            SetEntityInvincible(NoClipEntity, false)
            SetEntityVisible(NoClipEntity, true, false);
            SetEveryoneIgnorePlayer(PlayerPedId(), false);

        
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('admin:toggleNoClip')
AddEventHandler('admin:toggleNoClip', function()
    NoClipActive = not NoClipActive
    if Config.FrozenPosition then SetEntityHeading(NoClipEntity, GetEntityHeading(NoClipEntity)+180) end      
end)

function DisableControls()
    DisableControlAction(0, 0xB238FE0B, true) --disable controls here
    DisableControlAction(0, 0x3C0A40F2, true) --disable controls here
end

