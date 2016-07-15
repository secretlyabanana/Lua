--[[
    multithreading in lua using a c function, replace Delay with whatever your c sleep function is.
    
    by secret6timb1.
]]--

local clock = os.clock;
local threads = {};

SimulateTasks = function(routines)
	
	for _,v in ipairs(routines) do
		threads[v] = 0;
	end;
	
	local lowestWait = 1;
	
	wait = function(dt)
		threads[coroutine.running()] = clock()+dt;
		
		if dt < lowestWait then
			lowestWait = dt;
		end;
		
		coroutine.yield();
		return true;
	end;
	
	while true do
		
		for i = 1, #routines do
		
			if threads[routines[i]] < clock() then
				coroutine.resume(routines[i]);
			end;
			
			if coroutine.status(routines[i]) == 'dead' then
				routines[i] = nil;
			end;
			
		end;
		
		if #routines == 0 then
			break;
		end;
		
		Delay(lowestWait*1000);
		
	end;
	
	threads = {};
	
end;
