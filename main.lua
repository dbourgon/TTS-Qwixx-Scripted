--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onload()
    --[[ print("Onload!") --]]
	--[[ red, yellow, green, blue --]]
	
	
	scores = {1,3,6,10,15,21,28,36,45,55,66,78}
	
	whiteText = getObjectFromGUID("3a6a35")
	whiteZones = {"c36e28","837c2c","72ae81","74582f"}
	whiteZoneObjNum = {0, 0, 0, 0}
	whiteFailZone = {"decaa6", 0}
	whiteRowTotal = {0,0,0,0}
	whiteScore = 0
	
	orangeText = getObjectFromGUID("23b3b5")
	orangeZones = {"883b58","7b6c61","df1ffc","58ff13"}
	orangeZoneObjNum = {0, 0, 0, 0}
	orangeFailZone = {"c7e221", 0}
	orangeRowTotal = {0,0,0,0}
	orangeScore = 0
	
	greenText = getObjectFromGUID("b5de13")
	greenZones = {"75e3fd","b5eb46","7d9df0","1cc647"}
	greenZoneObjNum = {0, 0, 0, 0}
	greenFailZone = {"919724", 0}
	greenRowTotal = {0,0,0,0}
	greenScore = 0
	
	pinkText = getObjectFromGUID("bb9870")
	pinkZones = {"b21db9","bca22b","9482dc","ef5181"}
	pinkZoneObjNum = {0, 0, 0, 0}
	pinkFailZone = {"0094f5", 0}
	pinkRowTotal = {0,0,0,0}
	pinkScore = 0

	function getScore(objNum)
		if objNum > 12 then return 78
		elseif objNum == 0 then return 0
		else
			return scores[objNum]
		end
	end
	
	function addScore(zone, zones, zoneObjNum, rowTotal, failZone)
		local x=0
		for i,z in ipairs(zones) do
			if z == zone.guid then
				zoneObjNum[i] = zoneObjNum[i]+1
			end
		end
		for ii,s in ipairs(zoneObjNum) do
			rowTotal[ii] = getScore(s)
			x = x + rowTotal[ii]
		end	

		if failZone[1] == zone.guid then
			failZone[2] = failZone[2] + 1
		end
		x = x - (5*failZone[2])

		return x
			
		
	end
	
	function subScore(zone, zones, zoneObjNum, rowTotal, failZone)
		local x = 0
		for i,z in ipairs(zones) do
			if z == zone.guid then
				zoneObjNum[i] = zoneObjNum[i]-1
			end
		end
		for ii,s in ipairs(zoneObjNum) do
			rowTotal[ii] = getScore(s)
			x = x + rowTotal[ii]
		end

		if failZone[1] == zone.guid then
			failZone[2] = failZone[2] - 1
		end
		x = x - (5*failZone[2])

		return x
	end
	
	function onObjectEnterScriptingZone( zone, enter_object )
		if enter_object.getName() == "scoreToken" then
			whiteScore = addScore(zone, whiteZones, whiteZoneObjNum, whiteRowTotal, whiteFailZone)
			whiteText.TextTool.setValue(tostring(whiteScore))
			
			orangeScore = addScore(zone, orangeZones, orangeZoneObjNum, orangeRowTotal, orangeFailZone)
			orangeText.TextTool.setValue(tostring(orangeScore))
			
			greenScore = addScore(zone, greenZones, greenZoneObjNum, greenRowTotal, greenFailZone)
			greenText.TextTool.setValue(tostring(greenScore))
			
			pinkScore = addScore(zone, pinkZones, pinkZoneObjNum, pinkRowTotal, pinkFailZone)
			pinkText.TextTool.setValue(tostring(pinkScore))
		end
	end
	
	function onObjectLeaveScriptingZone( zone, enter_object )
		if enter_object.getName() == "scoreToken" then
			whiteScore = subScore(zone, whiteZones, whiteZoneObjNum, whiteRowTotal, whiteFailZone)
			whiteText.TextTool.setValue(tostring(whiteScore))
			
			orangeScore = subScore(zone, orangeZones, orangeZoneObjNum, orangeRowTotal, orangeFailZone)
			orangeText.TextTool.setValue(tostring(orangeScore))
			
			greenScore = subScore(zone, greenZones, greenZoneObjNum, greenRowTotal, greenFailZone)
			greenText.TextTool.setValue(tostring(greenScore))
			
			pinkScore = subScore(zone, pinkZones, pinkZoneObjNum, pinkRowTotal, pinkFailZone)
			pinkText.TextTool.setValue(tostring(pinkScore))
		end
	end
	
end

--[[ The Update function. This is called once per frame. --]]
function update ()
    --[[ print("Update loop!") --]]
end
