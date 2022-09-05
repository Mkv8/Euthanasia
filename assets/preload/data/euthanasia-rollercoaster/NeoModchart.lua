function setActorX(val, i)
	setPropertyFromGroup("strumLineNotes", i, "x", val)
end
function setActorY(val, i)
	setPropertyFromGroup("strumLineNotes", i, "y", val)
end
function getActorX(i)
	return getPropertyFromGroup("strumLineNotes", i, "x")
end
function getActorY(i)
	return getPropertyFromGroup("strumLineNotes", i, "y")
end
function setActorAngle(val, i)
	setPropertyFromGroup("strumLineNotes", i, "angle", val)
end
function setActorScale(val, i)
	setPropertyFromGroup("strumLineNotes", i, "scale.x", val)
	setPropertyFromGroup("strumLineNotes", i, "scale.y", val)
end
function setActorAlpha(val, i)
	setPropertyFromGroup("strumLineNotes", i, "alpha", val)
end
function getActorAngle(i)
	return getPropertyFromGroup("strumLineNotes", i, "angle")
end
function getActorAlpha(i)
	return getPropertyFromGroup("strumLineNotes", i, "alpha")
end
function tweenAngle(id, angle, time)
	noteTweenAngle("strumAngle"..id, id, angle, time)
end
function tweenPosX(id, x, time)
	noteTweenX("strumX"..id, id, x, time, 'linear')
end
function tweenPosY(id, y, time)
	noteTweenY("strumY"..id, id, y, time, 'linear')
end

local shouldSort = true

function onCreate()
	for i=0,7 do
		_G['defaultStrum'..i..'X'] = 0
		_G['defaultStrum'..i..'Y'] = 0
	end

	setProperty('songLengthOffset', -24000)

	-- Incase the script loaded after the countdown, normally it would be 0
	if getProperty("startedCountdown") then
		for i=0,3 do
			local ri = i
			_G["defaultOpponentStrumX"..ri] = getPropertyFromGroup("opponentStrums", ri, "x")
			_G["defaultOpponentStrumY"..ri] = getPropertyFromGroup("opponentStrums", ri, "y")
			_G['defaultStrum'..i..'X'] = _G["defaultOpponentStrumX"..ri]
			_G['defaultStrum'..i..'Y'] = _G["defaultOpponentStrumY"..ri]
		end
		for i=4,7 do
			local ri = i-4
			_G["defaultPlayerStrumX"..ri] = getPropertyFromGroup("playerStrums", ri, "x")
			_G["defaultPlayerStrumY"..ri] = getPropertyFromGroup("playerStrums", ri, "y")
			_G['defaultStrum'..i..'X'] = _G["defaultPlayerStrumX"..ri]
			_G['defaultStrum'..i..'Y'] = _G["defaultPlayerStrumY"..ri]
		end
	end
end

function onCountdownStarted()
	for i=0,3 do
		local ri = i
		_G['defaultStrum'..i..'X'] = _G["defaultOpponentStrumX"..ri]
		_G['defaultStrum'..i..'Y'] = _G["defaultOpponentStrumY"..ri]
	end
	for i=4,7 do
		local ri = i-4
		_G['defaultStrum'..i..'X'] = _G["defaultPlayerStrumX"..ri]
		_G['defaultStrum'..i..'Y'] = _G["defaultPlayerStrumY"..ri]
	end
end

local isDead = false

function onGameOver()
	isDead = true
end

local songPos = 0

function onUpdate(elapsed)
	if isDead then return end
	songPos = getSongPosition()
	update(elapsed)
end

local stepEvents = {
	{305, "Sway", "5.194243530999999", ""},
	{306, "Jump", "", ""},
	{310, "Jump", "", ""},
	{314, "Jump", "", ""},
	{318, "Jump", "", ""},
	{322, "Jump", "", ""},
	{326, "Jump", "", ""},
	{330, "Jump", "", ""},
	{334, "Jump", "", ""},
	{338, "Jump", "", ""},
	{342, "Jump", "", ""},
	{346, "Jump", "", ""},
	{350, "Jump", "", ""},
	{354, "Jump", "", ""},
	{358, "Jump", "", ""},
	{362, "Jump", "", ""},
	{366, "Jump", "", ""},
	{370, "Jump", "", ""},
	{374, "Jump", "", ""},
	{378, "Jump", "", ""},
	{382, "Jump", "", ""},
	{386, "Jump", "", ""},
	{390, "Jump", "", ""},
	{394, "Jump", "", ""},
	{398, "Jump", "", ""},
	{402, "Jump", "", ""},
	{406, "Jump", "", ""},
	{410, "Jump", "", ""},
	{414, "Jump", "", ""},
	{418, "Jump", "", ""},
	{422, "Jump", "", ""},
	{426, "Jump", "", ""},
	{430, "Jump", "", ""},
	{433, "Jump", "", ""},
	{435, "Jump", "", ""},
	{437, "Jump", "", ""},
	{439, "Jump", "", ""},
	{445, "Jump", "", ""},
	{449, "Jump", "", ""},
	{451, "Jump", "", ""},
	{453, "Jump", "", ""},
	{453, "Jump", "", ""},
	{455, "Jump", "", ""},
	{462, "Jump", "", ""},
	{466, "Jump", "", ""},
	{470, "Jump", "", ""},
	{474, "Jump", "", ""},
	{478, "Jump", "", ""},
	{482, "Jump", "", ""},
	{486, "Jump", "", ""},
	{490, "Jump", "", ""},
	{494, "Jump", "", ""},
	{498, "Jump", "", ""},
	{502, "Jump", "", ""},
	{506, "Jump", "", ""},
	{510, "Jump", "", ""},
	{514, "Jump", "", ""},
	{518, "Jump", "", ""},
	{522, "Jump", "", ""},
	{526, "Jump", "", ""},
	{530, "Jump", "", ""},
	{534, "Jump", "", ""},
	{538, "Jump", "", ""},
	{542, "Jump", "", ""},
	{546, "Jump", "", ""},
	{550, "Jump", "", ""},
	{554, "Jump", "", ""},
	{558, "Jump", "", ""},
	{562, "Jump", "", ""},
	{566, "Jump", "", ""},
	{570, "Jump", "", ""},
	{574, "Jump", "", ""},
	{578, "Jump", "", ""},
	{582, "Jump", "", ""},
	{586, "Jump", "", ""},
	{590, "Jump", "", ""},
	{594, "Jump", "", ""},
	{598, "Jump", "", ""},

	{602, "Jump", "", ""},
	{606, "Jump", "", ""},
	{610, "Jump", "", ""},
	{614, "Jump", "", ""},
	{618, "Jump", "", ""},

	{622, "Jump", "", ""},
	{626, "Jump", "", ""},
	{630, "Jump", "", ""},
	{634, "Jump", "", ""},
	{638, "Jump", "", ""},

	{642, "Jump", "", ""},
	{646, "Jump", "", ""},
	{650, "Jump", "", ""},
	{654, "Jump", "", ""},
	{658, "Jump", "", ""},

	{662, "Jump", "", ""},
	{666, "Jump", "", ""},
	{670, "Jump", "", ""},
	{674, "Jump", "", ""},
	{678, "Jump", "", ""},

	{682, "Jump", "", ""},
	{686, "Jump", "", ""},
	{690, "Jump", "", ""},
	{694, "Jump", "", ""},
	{698, "Jump", "", ""},

	{702, "Jump", "", ""},
	{706, "Jump", "", ""},
	{710, "Jump", "", ""},

	{712, "End Sway", "", ""},
	{713, "Return Notes", "", ""},
	{1307, "Glitch", "", ""},
	{1314, "Glitch Small", "", ""},
	{1324, "Glitch", "", ""},
	{1332, "Glitch", "", ""},
	{1335, "Glitch Long", "3", "2"},
	{1360, "Glitch Long", "30", "15"},
	{1371, "Glitch Long", "30", "30"},
	{1398, "Glitch", "", ""},
	{1400, "Glitch", "", ""},
	{1402, "Glitch", "", ""},
	{1404, "Glitch", "", ""},
	{1406, "Glitch", "", ""},
	{1408, "Glitch", "", ""},
	{1449, "Glitch Long", "30", "15"},
	{1482, "Glitch", "", ""},
	{1483, "Glitch", "", ""},
	{1484, "Glitch", "", ""},
	{1485, "Glitch", "", ""},
	{1486, "Glitch", "", ""},
	{1487, "Glitch", "", ""},
	{1488, "Glitch", "", ""},
	{1489, "Glitch", "", ""},
	{1490, "Glitch", "", ""},
	{1491, "Glitch", "", ""},
	{1492, "Glitch", "", ""},
	{1493, "Glitch", "", ""},
	{1494, "Glitch", "", ""},
	{1495, "Glitch", "", ""},
	{1505, "Glitch Long", "30", "20"},
	{1522, "Glitch", "", ""},
	{1524, "Glitch", "", ""},
	{1526, "Glitch", "", ""},
	{1526, "Glitch", "", ""},
	{1532, "Glitch", "", ""},
	{1536, "Glitch", "", ""},
	{1540, "Glitch Long", "30", "2"},
	{1544, "Glitch Long", "40", "2"},
	{1550, "Glitch Long", "40", "45"},
	{2175, "Return Song Time", "", ""},
}

local longGlitch = 0.0
local longSpeed = 1

local swaying = false
local swayingOffset = 0

function update(elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)

	if shouldSort then
		table.sort(stepEvents, function(a,b) return a[1] < b[1] end)
		shouldSort = false
	end

	while (0 < #stepEvents and curStep >= stepEvents[0+1][0+1]) do
		local event = table.remove(stepEvents, 1)
		triggerEvent(event[1+1], event[2+1], event[3+1])
	end

	if swaying then
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat+swayingOffset) * 0.503), i)
		end
	end

	if longGlitch > 0 then
		longGlitch = longGlitch - elapsed * longSpeed
		if longGlitch < 0 then
			longGlitch = 0
		end
		for i = 0,4 do
			setActorX(_G['defaultPlayerStrumX'..i] + math.random() * longGlitch, i+4)
			setActorY(_G['defaultPlayerStrumY'..i] + math.random() * longGlitch, i+4)
		end
	end

	if jumpNote > 0 then
		jumpNote = jumpNote - elapsed*10
		if jumpNote < 0 then
			jumpNote = 0
		end
		setActorX(getActorX(0+4) - 10*jumpNote, 0+4)
		setActorX(getActorX(1+4) - 10*jumpNote * 0.5, 1+4)
		setActorX(getActorX(2+4) + 10*jumpNote * 0.5, 2+4)
		setActorX(getActorX(3+4) + 10*jumpNote, 3+4)
	end
end

function onEvent(name, v1, v2)
	if name == "Glitch" then
		for i = 0,4 do
			setActorX(_G['defaultPlayerStrumX'..i] + math.random() * 30, i+4)
			setActorY(_G['defaultPlayerStrumY'..i] + math.random() * 30, i+4)
			--tweenPosX(i+4, _G['defaultPlayerStrumX'..i], 0.3)
			tweenPosY(i+4, _G['defaultPlayerStrumY'..i], 0.3)
		end
		longGlitch = 0
	elseif name == "Glitch Small" then
		for i = 0,4 do
			setActorX(_G['defaultPlayerStrumX'..i] + math.random() * 10, i+4)
			setActorY(_G['defaultPlayerStrumY'..i] + math.random() * 10, i+4)
			--tweenPosX(i+4, _G['defaultPlayerStrumX'..i], 0.3)
			tweenPosY(i+4, _G['defaultPlayerStrumY'..i], 0.3)
		end
		longGlitch = 0
	elseif name == "Glitch Long" then
		local val = tonumber(v1)
		local speed = tonumber(v2)
		longGlitch = val
		longSpeed = speed
	elseif name == "Sway" then
		swaying = true
		local val = tonumber(v1)
		local currentBeat = (songPos / 1000)*(bpm/60)
		print(currentBeat)
		swayingOffset = val
	elseif name == "Jump" then
		jumpNote = 3
	elseif name == "End Sway" then
		swaying = false
		jumpNote = -1
	elseif name == "Return Notes" then
		for i = 0,4 do
			--setActorX(_G['defaultPlayerStrumX'..i] + math.random() * 10, i+4)
			--setActorY(_G['defaultPlayerStrumY'..i] + math.random() * 10, i+4)
			tweenPosX(i+4, _G['defaultPlayerStrumX'..(i)], 0.3)
			tweenPosY(i+4, _G['defaultPlayerStrumY'..(i)], 0.3)
		end
	elseif name == "Return Song Time" then
		runHaxeCode([[
			FlxTween.tween(PlayState.instance, {songLengthOffset: 0}, 3);
		]])
	end
end
