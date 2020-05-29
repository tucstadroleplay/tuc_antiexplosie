-------------------------------------------
---			TUCSTAD ROLEPLAY			---
---			MADE BY JESSE				---
-------------------------------------------

AddEventHandler('explosionEvent', function(sender, ev)
    print(GetPlayerName(sender), json.encode(ev))
    if ev.ownerNetId == 0 then
        CancelEvent()
    end
    if ev.posX == 0.0 and ev.posY == 0.0 then
        CancelEvent()
    end
end)