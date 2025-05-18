global SpellAttackCooldown := false
global ShieldRechargeCooldown := false ; convalescence cooldown so cast it when on low

noShieldColor := 0x1C892B ; hardcoded colors xD both of them means that shield is on low
noShieldColor2 := 0x1D892A

PixelX := 994 ; pixel pos x to track (1920x1080 resolution)
PixelY := 360 ; pixel pos y to track (1920x1080 resolution)

SetTimer, CheckHp, 700  ; loop every 700 miliseconds to check player hp

CheckHp:
    WinGetActiveTitle, activeWindowTitle
    if (!InStr(activeWindowTitle, "Path of Exile 2")) { ; if outside of poe do nothing
       return
    }

    PixelGetColor, color, PixelX, PixelY, RGB ;

    if (color = noShieldColor || color = noShieldColor2) {
       if (!ShieldRechargeCooldown) {
            SetTimer, ResetShieldRechargeCooldown, -16000
            ShieldRechargeCooldown := true
            Send, {sc02C}
       }
       Send, q
    }
return

~XButton1:: ; mouse 4 click
    if (SpellAttackCooldown) {
        return
    }
    SpellAttackCooldown := true
    SetTimer, ResetSpellAttackCooldown, -8000

    Sleep, 500 ; my spell rotation starts
    Send, {sc013}
    Sleep, 500
    Send, {sc013}
    Send, 2
    Sleep, 1050
    Send, {sc02D}
    Sleep, 500
    Click, right
return

~XButton2:: ; mouse 5 click
    if (SpellAttackCooldown) {
        return
    }
    SpellAttackCooldown := true
    SetTimer, ResetSpellAttackCooldown, -8000

    Sleep, 500 ; my spell rotation starts
    Send, {sc013}
    Sleep, 500
    Send, {sc013}
    Send, 2
    Sleep, 1050
    Send, {sc02D}
    Sleep, 500
    Click, right
return

ResetSpellAttackCooldown:
    global SpellAttackCooldown
    SpellAttackCooldown := false
return

ResetShieldRechargeCooldown:
    global ShieldRechargeCooldown
    ShieldRechargeCooldown := false
return