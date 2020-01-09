/*                                                                                                             
Thirdperson camera plugin for custom starwarsrp
*/

if CLIENT then		
	local conZ = 5
	local conX = 0
	hook.Add("CreateMove", "altKeyPressed", function(cmd)
		if input.WasMousePressed(MOUSE_WHEEL_DOWN) then
			conZ = conZ + 10
		elseif input.WasMousePressed(MOUSE_WHEEL_UP) then
			conZ = conZ - 10
		end

		if conZ < ThirdPersonConfig["MinDistance"] then conZ = ThirdPersonConfig["MinDistance"] end
		if conZ > ThirdPersonConfig["MaxDistance"] then conZ = ThirdPersonConfig["MaxDistance"] end
	end)

	hook.Add("CalcView","SimpleTP.Camera.View",function(ply, camPos, angles, fov)
		if  IsValid(ply) then			
			local conY = -15;
			
			ply.camera_ang = angles

			local camTr  = util.TraceLine( {
				start = camPos ,
				endpos = camPos + (ply.camera_ang:Forward( ) * 9999999),
				filter = ply,
			} )
			
			local dist = 200;
			local trace = {};
				
			local trace = util.TraceHull({
				start = camPos,
				endpos = camPos - ply.camera_ang:Forward() * (100 + conZ) - ply.camera_ang:Right() * (conX) - ply.camera_ang:Up() * (conY),
				filter = {ply:GetActiveWeapon(), ply},
				mins = Vector(-6, -4, -4),
				maxs = Vector(6, 4, 4),
			})
			
			local pos;
			if(trace.Hit)then
				pos = trace.HitPos;
			else
				pos = camPos - ply.camera_ang:Forward() * (100 + conZ);
				pos = pos - ply.camera_ang:Right() * (conX);
				pos = pos - ply.camera_ang:Up() * (conY);
			end
			
			local view = {};
			view.fov = fov;
			view.drawviewer = true;
			view.origin = pos;
			view.angles = ply.camera_ang;
			
			return view;
		end
	end)
end