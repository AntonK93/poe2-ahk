global SpellAttackCooldown := false
global ShieldRechargeCooldown := false

shieldColor := 0x479954
noShieldColor := 0x1C892B
noShieldColor2 := 0x1D892A

SetTimer, CheckHp, 700  ; Проверяем хп каждые 800 миллисекунд

CheckHp:
    WinGetActiveTitle, activeWindowTitle
    if (!InStr(activeWindowTitle, "Path of Exile 2")) {
       return
    }

    ; Получаем текущий цвет пикселя
    PixelGetColor, color, 994, 360, RGB

    ; Если цвет изменился, выполняем действие
    if (color = noShieldColor || color = noShieldColor2) {
       if (!ShieldRechargeCooldown) {
            SetTimer, ResetShieldRechargeCooldown, -16000
            ShieldRechargeCooldown := true
            Send, z
       }
       Send, q
    }
return

~XButton1::
    if (SpellAttackCooldown) {
        return
    }
    SpellAttackCooldown := true
    SetTimer, ResetSpellAttackCooldown, -8000

    Sleep, 500
    Send, r
    Sleep, 500
    Send, f
    Send, 2
    Sleep, 1050
    Send, x
return

~XButton2::
    if (SpellAttackCooldown) {
        return
    }
    SpellAttackCooldown := true
    SetTimer, ResetSpellAttackCooldown, -8000

    Sleep, 500
    Send, r
    Sleep, 500
    Send, f
    Send, 2
    Sleep, 1050
    Send, x
return

ResetSpellAttackCooldown:
    global SpellAttackCooldown
    SpellAttackCooldown := false
return

ResetShieldRechargeCooldown:
    global ShieldRechargeCooldown
    ShieldRechargeCooldown := false
return