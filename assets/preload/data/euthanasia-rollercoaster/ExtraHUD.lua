						--feature--
local noteBop = false; --the note boping when pressed
local emote = true; --- bf do animation. press SPACE to emote  [default: true]
local playOpponent = false; -- play as opponent [default: false]
local healthdrain = false; --- everytime opponent hit notes your health get drained like boyfriend do to opponent [default: true]
-- more coming
						--Config--
	daemote = ""  -- put the name of bf animation. [leave blank for hey/peace sign. if the bf is not the original one it will not playing]
	
						--settings--
local Fullstat = true;
local songBarr = false;
local statSong = false; 
local bopHead = false; 
local hideP2Notes = true; 
local sideHealthbar = true; 
local camfollow = false;     -- maybe doesnt work properly on some mod/song --


					   --Extras--
local funnybf = false; --- thing that make bf squishable [default: false]

-----------------------------------[[Settings Info]]---------------------------------------
--[[ camfollow = the camara follow the direction of notes [default: false]
	
   	 songBarr : a bar that will show up showing the song and bpm [default: true]
	 
	 statSong : show the stats of song like difficulty and song name [!!WILL FORCE TIME BAR TYPE TO TIME ELAPSED!!] [cant detect different/custom difficulty] [default: true]
	 
	 bopHead : chars bopping on the beat [default: false]
	 
	 hideP2Notes : hide the opponent notes [default: false]
	 
	 sideHealthbar : make the healthbar on right side [osu healthbar thing] [default: false]
	 
	 Fullstat : show how many you have sicks,goods,bads,and shits [default: false]        
																															]]--
																															
--[[                    Credits                    
	bopHead : Form BBPanzu
	playOpponent + sick notes hud : Form Plotsh
	funnybf/ squishable bf : Form 4k_funny
	
	the rest : Form Moch/Mochaama(myself lol)
												]]--
	

				--the thing lolollolololol--
--form bbpanzu
local dadsingL = 4
local bfsingL = 4
realAnimdad = 'idle'
realAnimbf = 'idle'
function getAnim(char,prop)
	prop = prop or 'name'
	return getProperty(char .. '.animation.curAnim.' .. prop)
end
----------------------
--form Plotsh
cmoffset = -4
cmy = 20
tnhx = -10
---------------------
function onCreate()
	if camfollow then
		addLuaScript('ExtraScript/folchar') -- preventing a crash happen
	end
	if playOpponent then
		addLuaScript('ExtraScript/Opponent')
	end
	if statSong then
		if downscroll then
			makeLuaText('sogn', songName, 0, 5, 695);
			makeLuaText('stor', '', 0,1146, 695);
		else
			makeLuaText('sogn', songName, 0, 5, 2);
			makeLuaText('stor', '', 0, 1146, 2);
		end
		setTextSize('sogn', 19);
		setTextSize('stor', 20);
		setTextAlignment('sogn', 'left');
		setTextAlignment('stor', 'right');
		setTextColor('sogn', 'E5E7E9');
		addLuaText('sogn');
		addLuaText('stor');
	
		if isStoryMode then
			setTextString('stor','(StoryMode)');
		else
			setTextString('stor','(FreePlay)');
		end
   
		if playOpponent then
			if difficulty == 0 then 
				setTextString('sogn',songName .. ' - Easy (Opponent)');
			elseif difficulty == 1 then
				setTextString('sogn',songName .. ' - Normal (Opponent)');
			elseif difficulty == 2 then
				setTextString('sogn',songName .. ' - Hard (Opponent)');
			elseif difficulty == 3 then
				setTextString('sogn',songName .. ' - Custom (Opponent)');
			end
		else
			if difficulty == 0 then 
				setTextString('sogn',songName .. ' - Easy');
			elseif difficulty == 1 then
				setTextString('sogn',songName .. ' - Normal');
			elseif difficulty == 2 then
				setTextString('sogn',songName .. ' - Hard');
			elseif difficulty == 3 then
				setTextString('sogn',songName .. ' - Custom');
			end
		end
	end
 

	if sideHealthbar then
		makeLuaText("youv", 'Opponent -->' ,  2090, 10, 300);
		makeLuaText("youe", 'You -->' ,  2200, 10, 365);

		setTextSize('youe', 40);
		addLuaText('youe');
		setTextSize('youv', 40);
		addLuaText('youv');
	end

	if Fullstat then
		makeLuaText("tnh", '', 250, tnhx, 259);
		makeLuaText("cm", '', 200, -getProperty('tnh.x') + cmoffset, getProperty('tnh.y') + cmy);
		makeLuaText("sick", 'Sicks!: 0', 200, getProperty('cm.x'), getProperty('cm.y') + 30);
		makeLuaText("good", 'Goods: 0', 200, getProperty('cm.x'), getProperty('sick.y') + 30);
		makeLuaText("bad", 'Bads: 0', 200, getProperty('cm.x'), getProperty('good.y') + 30);
		makeLuaText("shit", 'Shits: 0', 200, getProperty('cm.x'), getProperty('bad.y') + 30);

		addLuaText('tnh');
		setTextSize('sick', 20);
		addLuaText("sick");
		setTextAlignment('sick', 'left')
		setTextSize('good', 20);
		addLuaText("good");
		setTextAlignment('good', 'left')
		setTextSize('bad', 20);
		addLuaText("bad");
		setTextAlignment('bad', 'left')
		setTextSize('shit', 20);
		addLuaText("shit");
		setTextAlignment('shit', 'left')
	end

	if songBarr then
		makeLuaSprite('wot','extraimage/songbarAlt',420, -200);
		scaleObject('wot', 0.8, 0.65);
		setObjectCamera('wot','other');
		addLuaSprite('wot',true);
		makeLuaText('wtf2',"Playing:", 0, 10, getProperty('wot.y')+0);
		addLuaText('wtf2');
		setObjectCamera('wtf2','other');
		setTextSize('wtf2', 30);
		makeLuaText('wtf', songName .. " | " .. curBpm , 0, 20, getProperty('wot.y') + 0);
		setTextSize('wtf', 25);
		setObjectCamera('wtf','other');
		addLuaText('wtf');
		setTextAlignment('wtf', 'left')
		setProperty('wot.alpha', 1* 0)
		setProperty('tnh.alpha',0)
		setProperty('sogn.alpha',0)
	end

 	if statSong then
		if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Song Name' or getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Disabled' or getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Time Elapsed' then
			setTextSize('timeTxt', 30);
			setPropertyFromClass('ClientPrefs', 'timeBarType', 'Time Left')
		end
	end
end

woosh = -69420
function onCreatePost()
	if hideP2Notes then
		for i = 0, getProperty('opponentStrums.length')-1 do
			setPropertyFromGroup('opponentStrums',i,'visible',false)
			setPropertyFromGroup('opponentStrums',i,'y', woosh)
			setPropertyFromGroup('opponentStrums',i,'x', woosh)
		end
	end
	if sideHealthbar then
		setProperty('scoreTxt.alpha', 1*1)
		setProperty('healthBar.angle', 1*90)
		setProperty('healthBar.x', 1* 930)
		setProperty('healthBar.y', 1* 350)
		setProperty('iconP1.alpha', 1* 0)
		setProperty('iconP2.alpha', 1* 0)
		setTextSize('scoreTxt', 26)	
		setProperty('timeTxt.x',1 * 760)
	end

	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)
	if downscroll then
		setProperty('scoreTxt.y', 1*690)
		setProperty('timeTxt.y', getProperty('iconP1.y')+ 5)
		setProperty('timeTxt.x', getProperty('scoreTxt.x')+ 440)
	end
	if not downscroll then
		setProperty('scoreTxt.y', 1*20)
		setProperty('timeTxt.y', getProperty('iconP1.y')+ 100)
	end
end

-- form 4k_funny
accel_x = 0
accel_x2 = 0
bounce = 0
bf_flip = 1
pos_x = 800
-------------
function onUpdate()
	if boyfriendName == 'bf' then
		if not isPixelStage then
			makeLuaSprite('wii', 'extraimage/bf-win', getProperty('iconP1.x'), getProperty('iconP1.y'))
			setObjectCamera('wii', 'hud')
			setObjectOrder('wii', getObjectOrder('iconP1') + 1)
			addLuaSprite('wii', true)
			setProperty('wii.flipX', true)
			setProperty('wii.visible', false)
			setProperty('wii.x', getProperty('iconP1.x'))
			setProperty('wii.angle', getProperty('iconP1.angle'))
			setProperty('wii.y', getProperty('iconP1.y'))
			setProperty('wii.scale.x', getProperty('iconP1.scale.x'))
			setProperty('wii.scale.y', getProperty('iconP1.scale.y'))
		end
	end


	if emote then
		if daemote == '' then
			if keyJustPressed('space') then
				triggerEvent('Hey!','BF', '0.6')
			end
		else
			if keyJustPressed('space') then
				triggerEvent('Play Animation',daemote, 'BF')
			end
		end
	end

	if botPlay then
		doTweenAlpha('tx','scoreTxt', 0, 0.3, 'linear')
	end

	if songBarr then
		setProperty('wtf.y', getProperty('wot.y') + 90)
		setProperty('wtf.x', getProperty('wot.x') + 70)
		setProperty('wtf2.y', getProperty('wot.y') + 10)
		setProperty('wtf2.x', getProperty('wot.x') + 60)
		setProperty('wtf.alpha', getProperty('wot.alpha'))
		setProperty('wtf2.alpha', getProperty('wot.alpha'))
		setProperty('stor.alpha', getProperty('sogn.alpha'))
	end

	if Fullstat then
		setTextString('sick', 'Sick!: ' .. getProperty('sicks'))
		setTextString('good', 'Goods: ' .. getProperty('goods'))
		setTextString('bad', 'Bads: ' .. getProperty('bads'))
		setTextString('shit', 'Shits: ' .. getProperty('shits'))
		setProperty('sick.alpha', getProperty('tnh.alpha'))
		setProperty('good.alpha', getProperty('tnh.alpha'))
		setProperty('bad.alpha', getProperty('tnh.alpha'))
		setProperty('shit.alpha', getProperty('tnh.alpha'))
	end

	if funnybf then
		if keyPressed("left") then
			bounce = (1 - math.abs(accel_x)/5)
			bf_flip = 1
		elseif keyPressed("up") then
			bounce = bounce*0.8 + 0.25
		elseif keyPressed("down") then
			bounce = bounce*0.7 + 0.25
		elseif keyPressed("right") then
			bounce = (1 - math.abs(accel_x)/5)
			bf_flip = -1
		else
			accel_x2 = accel_x2 + (1 - bounce)/5
			bounce = (bounce*0.8 + 0.2) + accel_x2
		end

		if keyPressed("left") then
			accel_x = accel_x*0.75 - 1*0.25
		elseif keyPressed("right") then
			accel_x = accel_x*0.75 + 1*0.25
		else
			accel_x = (accel_x)*0.8
		end

		pos_x = pos_x + accel_x*6
		setProperty('boyfriend.x', pos_x - 1/bounce * 150)
		setProperty('boyfriend.y', 100 + 1/bounce * 350)
		scaleObject('boyfriend', bf_flip/bounce, bounce)
	end

	if getProperty('health') > 1.6 then
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', false)
			setProperty('wii.visible', true)
		end
		setTextColor('scoreTxt', '00DB45')
	elseif getProperty('health') < 0.4 then
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', true)
			setProperty('wii.visible', false)
		end
		setTextColor('scoreTxt', 'FF0000')
	else
		setTextColor('scoreTxt', 'FFFFFF')
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', true)
			setProperty('wii.visible', false)
		end
	end
end

local stepEv = 0

function onStepHit()
	if stepEv == 0 and curStep >= 1 then
		if songBarr then
			doTweenAlpha('wota', 'wot', 1 , 0.8, 'quadInOut')
			doTweenY('wote', 'wot', 0 , 0.8, 'quadInOut')
		end
		stepEv = stepEv + 1
	end

	if stepEv == 1 and curStep >= 10 then
		if sideHealthbar then
			doTweenAlpha('youz', 'youe', 0, 2, 'linear')
			doTweenAlpha('youx', 'youv', 0, 2, 'linear')
		end
		stepEv = stepEv + 1
	end

	if stepEv == 2 and curStep >= 25 then
		if songBarr then
			doTweenAlpha('wota', 'wot', 0 , 1, 'quadInOut')
			doTweenY('wote', 'wot', -200 , 0.8, 'quadInOut')
			doTweenAlpha('shog', 'sogn', 1 , 1, 'quadInOut')
			doTweenAlpha('shoge', 'tnh', 1 , 1, 'quadInOut')
		end
		stepEv = stepEv + 1
	end
end


function onBeatHit()
	if bopHead then
		if getAnim("dad") == "idle"..getProperty('dad.idleSuffix') then
			characterPlayAnim("dad","idle"..getProperty('dad.idleSuffix'),true)
		end
		if getAnim("boyfriend") == "idle"..getProperty('boyfriend.idleSuffix') then
			characterPlayAnim("boyfriend","idle"..getProperty('boyfriend.idleSuffix'),true)
		end
	end

	if getProperty('curBeat') % 1 == 0 then
		setProperty('timeTxt.angle',1*-10)
		doTweenAngle('ho','timeTxt', 0, 0.2, 'quadInOut')
		if getProperty('health') > 1.6 then
			setProperty('iconP1.angle',1*15)
			setProperty('iconP2.angle',1*0)
			doTweenAngle('re', 'iconP1', 0, 0.5, 'quintOut')
		elseif getProperty('health') < 0.4 then
			setProperty('iconP1.angle',1*0)
			setProperty('iconP2.angle',1*15)
			doTweenAngle('ree', 'iconP2', 0, 0.5, 'quintOut')
		else
			setProperty('iconP1.angle',1*15)
			setProperty('iconP2.angle',1*-15)
			doTweenAngle('re', 'iconP1', 0, 0.5, 'quintOut')
			doTweenAngle('ree', 'iconP2', 0, 0.5, 'quintOut')
		end
	end

	if getProperty('curBeat') % 2 == 0 then
		setProperty('timeTxt.angle',1*10)
		doTweenAngle('ho','timeTxt', 0, 0.2, 'quadInOut')
		if getProperty('health') > 1.6 then
			setProperty('iconP1.angle',1*-15)
			setProperty('iconP2.angle',1*0)
			doTweenAngle('re', 'iconP1', 0, 0.5, 'quintOut')
		elseif getProperty('health') < 0.4 then
			setProperty('iconP1.angle',1*0)
			setProperty('iconP2.angle',1*-15)
			doTweenAngle('ree', 'iconP2', 0, 0.5, 'quintOut')
		else
			setProperty('iconP1.angle',1*-15)
			setProperty('iconP2.angle',1*15)
			doTweenAngle('re', 'iconP1', 0, 0.5, 'quintOut')
			doTweenAngle('ree', 'iconP2', 0, 0.5, 'quintOut')
		end
	end

	if newBeat then
		if getProperty('curBeat')%  25 == 0 then
			for i = 4,7 do
				setPropertyFromGroup('strumLineNotes', i, 'angle', 0)
				noteTweenAngle("yez " .. i, i, 360, 0.2, "quadInOut")
			end
			for i = 0,3 do
				setPropertyFromGroup('strumLineNotes', i, 'angle', 0)
				noteTweenAngle("yezz " .. i, i, -360, 0.2, "quadInOut")
			end
		end
		if getProperty('curBeat')% 4 == 0 then
			triggerEvent('Add Camera Zoom', '-0.040', '-0.05')
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	newBeat = true
	if healthdrain then
		if getProperty('health') > 0.2 then
			setProperty('health',getProperty('health')-0.02)
		end
	end
end
