SimulateTasks = function(routines)
	
	for _,v in ipairs(routines) do
		threads[v] = 0;
	end;
	
	wait = function(dt)
		threads[coroutine.running()] = clock()+dt;
		coroutine.yield();
	end;
	
	while true do
		
		local currentclock = clock();
		
		for i = 1, #routines do
		
			if threads[routines[i]] < currentclock then
				coroutine.resume(routines[i]);
			end;
			
			if coroutine.status(routines[i]) == 'dead' then
				routines[i] = nil;
			end;
			
		end;
		
		if #routines == 0 then
			break;
		end;
		
	end;
	
	threads = {};
	
end;
