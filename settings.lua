function courseplay:change_ai_state(self, change_by)
	self.ai_mode = self.ai_mode + change_by

	if self.ai_mode == 9 or self.ai_mode == 0 then
		self.ai_mode = 1
	end
end

function courseplay:call_player(self)
	if self.wants_courseplayer then --edit for more sites
		self.wants_courseplayer = false
	else
		self.wants_courseplayer = true
	end
end

function courseplay:start_stop_player(self)
	local tractor = self.courseplayers[1]
	if tractor.forced_to_stop then --edit for more sites
		tractor.forced_to_stop = false
	else
		tractor.forced_to_stop = true
	end
end

function courseplay:send_player_home(self)
	local tractor = self.courseplayers[1]
	tractor.loaded = true
end

function courseplay:switch_player_side(self)
	if self.grainTankCapacity == 0 then
		local tractor = self.courseplayers[1]
		if tractor == nil then
			return
		end

		tractor.ai_state = 10

		if self.forced_side == nil then
			self.forced_side = "left"
		elseif self.forced_side == "left" then
			self.forced_side = "right"
		else
			self.forced_side = nil
		end
	end
end

function courseplay:switch_hud_page(self, change_by)
	self.showHudInfoBase = self.showHudInfoBase + change_by

	if self.showHudInfoBase < self.min_hud_page then --edit for more sites
		self.showHudInfoBase = 8
	end

	if self.showHudInfoBase > 8 then --edit for more sites
		self.showHudInfoBase = self.min_hud_page
	end
end


function courseplay:change_combine_offset(self, change_by)
	local previousOffset = self.combine_offset
	
	self.auto_combine_offset = false
	self.combine_offset = roundCustom(self.combine_offset, 1) + change_by
	if self.combine_offset < 0.1 and self.combine_offset > -0.1 then
		self.combine_offset = 0.0
		self.auto_combine_offset = true
	end
	
	courseplay:debug("manual combine_offset change: prev " .. previousOffset .. " // new " .. self.combine_offset .. " // auto = " .. tostring(self.auto_combine_offset), 2)
end

function courseplay:change_tipper_offset(self, change_by)
	self.tipper_offset = roundCustom(self.tipper_offset, 1) + change_by
	if self.tipper_offset > -0.1 and self.tipper_offset < 0.1 then
		self.tipper_offset = 0.0
	end
end


function courseplay:changeCPWpOffsetX(self, change_by)
	self.WpOffsetX = self.WpOffsetX + change_by
end

function courseplay:changeCPWpOffsetZ(self, change_by)
	self.WpOffsetZ = self.WpOffsetZ + change_by
end

function courseplay:changeWorkWidth(self, change_by)
	self.toolWorkWidht = self.toolWorkWidht + change_by
	self.workWidthChanged = self.timer + 2000
	if self.toolWorkWidht < 0.1 then
		self.toolWorkWidht = 0.1
	end
end

function courseplay:change_WaypointMode(self, change_by)
	self.waypointMode = self.waypointMode + change_by
	if self.waypointMode == 6 then
		self.waypointMode = 1
	end
	courseplay:RefreshSigns(self)
end


function courseplay:change_required_fill_level_for_drive_on(self, change_by)
	self.required_fill_level_for_drive_on = self.required_fill_level_for_drive_on + change_by

	if self.required_fill_level_for_drive_on < 0 then
		self.required_fill_level_for_drive_on = 0
	end

	if self.required_fill_level_for_drive_on > 100 then
		self.required_fill_level_for_drive_on = 100
	end
end


function courseplay:change_required_fill_level(self, change_by)
	self.required_fill_level_for_follow = self.required_fill_level_for_follow + change_by

	if self.required_fill_level_for_follow < 0 then
		self.required_fill_level_for_follow = 0
	end

	if self.required_fill_level_for_follow > 100 then
		self.required_fill_level_for_follow = 100
	end
end


function courseplay:change_turn_radius(self, change_by)
	self.turn_radius = self.turn_radius + change_by;
	self.turnRadiusAutoMode = false;

	if self.turn_radius < 0.5 then
		self.turn_radius = 0;
	end;
	
	if self.turn_radius <= 0 then
		self.turnRadiusAutoMode = true;
		self.turn_radius = self.autoTurnRadius
	end;
end


function courseplay:change_turn_speed(self, change_by)
	local speed = self.turn_speed * 3600
	speed = speed + change_by
	if speed < 5 then
		speed = 5
	end
	self.turn_speed = speed / 3600
end

function courseplay:change_wait_time(self, change_by)
	local speed = self.waitTime

	speed = speed + change_by

	if speed < 0 then
		speed = 0
	end
	self.waitTime = speed
end

function courseplay:change_field_speed(self, change_by)
	local speed = self.field_speed * 3600
	speed = speed + change_by
	if speed < 5 then
		speed = 5
	end
	self.field_speed = speed / 3600
end

function courseplay:change_max_speed(self, change_by)
	if not self.use_speed then
		local speed = self.max_speed * 3600;
		speed = speed + change_by;
		if speed < 5 then
			speed = 5;
		end
		self.max_speed = speed / 3600;
	end;
end

function courseplay:change_unload_speed(self, change_by)
	local speed = self.unload_speed * 3600;
	speed = speed + change_by;
	if speed < 3 then
		speed = 3;
	end
	self.unload_speed = speed / 3600;
end

function courseplay:change_RulMode(self, change_by)
	self.RulMode = self.RulMode + change_by
	if self.RulMode == 4 then
		self.RulMode = 1
	end
end

function courseplay:switch_mouse_right_key_enabled(self)
	self.mouse_right_key_enabled = not self.mouse_right_key_enabled
end

function courseplay:switch_search_combine(self)
	self.search_combine = not self.search_combine
end

function courseplay:switch_realistic_driving(self)
	self.realistic_driving = not self.realistic_driving
end


function courseplay:switch_use_speed(self)
	self.use_speed = not self.use_speed
end

function courseplay:switch_combine(self, change_by)
	local combines = courseplay:find_combines(self)

	local selected_combine_number = self.selected_combine_number + change_by

	if selected_combine_number < 0 then
		selected_combine_number = 0
	end

	if selected_combine_number > table.getn(combines) then
		selected_combine_number = table.getn(combines)
	end

	self.selected_combine_number = selected_combine_number

	if self.selected_combine_number == 0 then
		self.saved_combine = nil
	else
		self.saved_combine = combines[self.selected_combine_number]
	end
end


function courseplay:change_selected_course(self, change_by)

	local selected_course_number = self.selected_course_number
	selected_course_number = selected_course_number + change_by

	self.cp.courseListPrev = true;
	self.cp.courseListNext = true;

	local number_of_courses = 0
	for k, trigger in pairs(g_currentMission.courseplay_courses) do --TODO: table.getn ?
		number_of_courses = number_of_courses + 1
	end

	if selected_course_number >= number_of_courses - 4 then
		selected_course_number = number_of_courses - 5
	end

	if selected_course_number < 0 then
		selected_course_number = 0
	end
	
	if selected_course_number == 0 then 
		self.cp.courseListPrev = false;
	end;
	if selected_course_number == (number_of_courses - 5) then
		self.cp.courseListNext = false;
	end;

	self.selected_course_number = selected_course_number
end

function courseplay:change_num_ai_helpers(self, change_by)
	local num_helpers = g_currentMission.maxNumHirables
	num_helpers = num_helpers + change_by

	if num_helpers < 1 then
		num_helpers = 1
	end

	g_currentMission.maxNumHirables = num_helpers
end

function courseplay:change_DebugLevel(change_by)
	CPDebugLevel = CPDebugLevel + change_by
	if CPDebugLevel == 5 then
		CPDebugLevel = 0
	end
end


--Course generation
function courseplay:switchStartingCorner(self)
	--print("switchStartingCorner() called");

	self.cp.startingCorner = self.cp.startingCorner + 1;
	if self.cp.startingCorner > 4 then
		self.cp.startingCorner = 1;
	end;
	self.cp.hasStartingCorner = true;
	self.cp.hasStartingDirection = false;
	self.cp.startingDirection = 0;

	--print(string.format("hasStartingCorner = %s / startingCorner = %s", tostring(self.cp.hasStartingCorner), tostring(self.cp.startingCorner)));
	--print(string.format("hasStartingDirection = %s / startingDirection = %s", tostring(self.cp.hasStartingDirection), tostring(self.cp.startingDirection)));
	--print("----- ----- ----- -----");
end;

function courseplay:switchStartingDirection(self)
	--print("switchStartingDirection() called");
	-- corners: 1 = SW, 2 = NW, 3 = NE, 4 = SE
	-- directions: 1 = North, 2 = East, 3 = South, 4 = West

	local validDirections = {};
	if self.cp.hasStartingCorner then
		if self.cp.startingCorner == 1 then --SW
			validDirections[1] = 1; --N
			validDirections[2] = 2; --E
		elseif self.cp.startingCorner == 2 then --NW
			validDirections[1] = 2; --E
			validDirections[2] = 3; --S
		elseif self.cp.startingCorner == 3 then --NE
			validDirections[1] = 3; --S
			validDirections[2] = 4; --W
		elseif self.cp.startingCorner == 4 then --SE
			validDirections[1] = 4; --W
			validDirections[2] = 1; --N
		end;

		--would be easier with i=i+1, but more stored variables would be needed
		if self.cp.startingDirection == 0 then
			self.cp.startingDirection = validDirections[1];
		elseif self.cp.startingDirection == validDirections[1] then
			self.cp.startingDirection = validDirections[2];
		elseif self.cp.startingDirection == validDirections[2] then
			self.cp.startingDirection = validDirections[1];
		end;
		self.cp.hasStartingDirection = true;
	end;
	
	--print(string.format("hasStartingCorner = %s / startingCorner = %s", tostring(self.cp.hasStartingCorner), tostring(self.cp.startingCorner)));
	--print(string.format("hasStartingDirection = %s / startingDirection = %s", tostring(self.cp.hasStartingDirection), tostring(self.cp.startingDirection)));
	--print("----- ----- ----- -----");
end;

function courseplay:switchReturnToFirstPoint(self)
	--print("switchReturnToFirstPoint() called");
	self.cp.returnToFirstPoint = not self.cp.returnToFirstPoint;
	--print(string.format("returnToFirstPoint = %s", tostring(self.cp.returnToFirstPoint)));
	--print("----- ----- ----- -----");
end;