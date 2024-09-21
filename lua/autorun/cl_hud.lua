--[[---------------------------------------------------------
   Name: noah-hudfivem
   Author : Noah
   Desc: Hud FiveM Like
   Version : 1.01
   Last update : 22/09/2024
-----------------------------------------------------------]]

Noah_HUD = Noah_HUD or {}
Noah_HUD.Config = Noah_HUD.Config or {}

----------------------- Configuration -----------------------

local blacklistWeapons = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["gmod_camera"] = true,
}

Noah_HUD.Config.Text = false  -- Affiche le texte
Noah_HUD.MilimalisteMode = true -- Mode minimaliste

----------------------- Fin Configuration -----------------------
surface.CreateFont("Noah_HUD:Font:1", {
    font = "Arial",
    size = 16,
    weight = 500,
    antialias = true
})

local MatHealth = Material("noah/hud/png/coeurs.png", "smooth")
local MatArmor = Material("noah/hud/png/armor.png", "smooth")
local MatMoney = Material("noah/hud/png/money.png", "smooth")
local MatJob = Material("noah/hud/png/user_suit.png", "smooth")
local MatSalary = Material("noah/hud/png/money_add.png", "smooth")
local MatHunger = Material("noah/hud/png/hunger.png", "smooth")
local MatGun = Material("noah/hud/png/gun.png", "smooth")

hook.Add("HUDPaint", "Noah:HUD:AllGamemode", function()
    local ply = LocalPlayer()
    local health = ply:Health()
    local armor = ply:Armor()
    local money = ply:getDarkRPVar("money")
    local job = ply:getDarkRPVar("job")
    local salary = ply:getDarkRPVar("salary")
    local hunger = ply:getDarkRPVar("Energy")

    local health = math.Clamp(health, 0, 100)
    local armor = math.Clamp(armor, 0, 100)
    local hunger = math.Clamp(hunger, 0, 100)

    // Draw le fond

    draw.RoundedBox(7, ScrW() - 210, 30, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 30, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 70, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 70, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 110, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 110, 35, 30, Color(44, 44, 44, 246))

    // Munition

    if !LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    draw.RoundedBox(7, ScrW() - 220, 1030, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 220, 1030, 35, 30, Color(44, 44, 44, 246))
    draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Noah_HUD:Font:1", ScrW() / 1.060, ScrH() - 36, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    // Affiche les informations

    draw.RoundedBox(9, ScrW() - 165, 40, health * 1, 9, Color(0, 138, 46))
    if Noah_HUD.Config.Text then
    draw.DrawText("" .. health, "Noah_HUD:Font:1", ScrW() - 165, 30, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    draw.RoundedBox(9, ScrW() - 165, 80, armor * 1, 9, Color(0, 102, 255))

    if Noah_HUD.Config.Text then
    draw.DrawText("" .. armor, "Noah_HUD:Font:1", ScrW() - 165, 70, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    draw.RoundedBox(9, ScrW() - 165, 120, health * 1, 9, Color(255, 102, 0))

    if Noah_HUD.Config.Text then
        draw.DrawText("" .. hunger, "Noah_HUD:Font:1", ScrW() - 165, 110, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    // Affiche les icones

    surface.SetMaterial(MatHealth)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 38, 16, 16)

    surface.SetMaterial(MatArmor)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 77, 16, 16)

    surface.SetMaterial(MatHunger)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 115, 16, 16)

    // icones minition 

    surface.SetMaterial(MatGun)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 209, 1035, 16, 16)
   
end)

local HideElement = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["DarkRP_HUD"] = true,
    ["DarkRP_EntityDisplay"] = true,
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_Agenda"] = true,
    ["DarkRP_LockdownHUD"] = true,    
    ["DarkRP_ArrestedHUD"] = true,   
    ["DarkRP_ChatReceivers"] = true,
}

hook.Add("HUDShouldDraw", "Noah:RemoveHUD:Ndev", function(name)
    if HideElement[name] then return false end
end)    