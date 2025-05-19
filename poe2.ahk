global SpellAttackCooldown := false
global ShieldRechargeCooldown := false ; convalescence cooldown so cast it when on low

noShieldColorThresholdDigit := "7" ; color is not constant so should be enough to validate first digit of that

PixelX := 171 ; pixel shield pos x to track (1920x1080 resolution)
PixelY := 886 ; pixel shield pos y to track (1920x1080 resolution)

SetTimer, CheckHp, 700  ; loop every 700 miliseconds to check player shield

CheckHp:
    WinGetActiveTitle, activeWindowTitle
    if (!InStr(activeWindowTitle, "Path of Exile 2")) { ; if outside of poe do nothing
       return
    }

    PixelGetColor, color, PixelX, PixelY, RGB ;
    firstColorDigit := SubStr(color, 3, 1)

    if (firstColorDigit < noShieldColorThresholdDigit) {
       if (!ShieldRechargeCooldown) {
            SetTimer, ResetShieldRechargeCooldown, -16000
            ShieldRechargeCooldown := true
            Send, {sc02C}
       }
       Send, {sc010}
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
    Sleep, 600
    Send, {sc021}
    Sleep, 1000
    Send, {Ctrl}
return

~XButton2:: ; mouse 5 click
    if (SpellAttackCooldown) {
        return
    }
    SpellAttackCooldown := true
    SetTimer, ResetSpellAttackCooldown, -8000

    Sleep, 500 ; my spell rotation starts
    Send, {sc013}
    Sleep, 600
    Send, {sc021}
    Sleep, 1000
    Send, {Ctrl}
return

ResetSpellAttackCooldown:
    global SpellAttackCooldown
    SpellAttackCooldown := false
return

ResetShieldRechargeCooldown:
    global ShieldRechargeCooldown
    ShieldRechargeCooldown := false
return