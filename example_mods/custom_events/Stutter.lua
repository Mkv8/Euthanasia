local noteStutter = 0

function onUpdate(elapsed)
    if noteStutter > 0 then
        noteStutter = noteStutter - elapsed
        if noteStutter < 0 then noteStutter = 0 end
    end

    for i = 0,getProperty("notes.length")-1 do
        setPropertyFromGroup("notes", i, "copyY", noteStutter <= 0)
    end
end

function onEvent(ev, v1, v2)
    if ev == "Stutter" then
        noteStutter = tonumber(v1)
    end
end