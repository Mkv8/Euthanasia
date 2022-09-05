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
	noteTweenX("strumX"..id, id, x, time)
end
function tweenPosY(id, y, time)
	noteTweenY("strumX"..id, id, y, time)
end

local shouldSort = true

function onCreate()
    for i=0,7 do
		_G['defaultStrum'..i..'X'] = 0
		_G['defaultStrum'..i..'Y'] = 0
	end

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
	--{126, "Glitch"}
}


function update(elapsed)
    if shouldSort then
		table.sort(stepEvents, function(a,b) return a[1] < b[1] end)
		shouldSort = false
	end

    while (0 < #stepEvents and curStep >= stepEvents[0+1][0+1]) do
		local event = table.remove(stepEvents, 1)[1+1]
		triggerEvent(event, "", "")
	end
end

function onEvent(name)
	if name == "Glitch" then
		for i = 0,4 do
            setActorX(_G['defaultPlayerStrumX'..i] + math.random() * 30, i)
            setActorY(_G['defaultPlayerStrumY'..i] + math.random() * 30, i)
            tweenPosX(i, _G['defaultPlayerStrumX'..i], 0.3)
            tweenPosY(i, _G['defaultPlayerStrumY'..i], 0.3)
        end
	end
end
