Noah_HUD = Noah_HUD or {}
Noah_HUD.Config = Noah_HUD.Config or {}
----------------------- Configuration -----------------------
Noah_HUD.Config.Text = true   -- Affiche le texte
Noah_HUD.Config.MilimalisteMode = false -- Mode minimaliste (Affiche le job, le salaire et l'argent)

----------------------- Fin Configuration -----------------------

RX = RX or function(x) return x / 1920 * ScrW() end
RY = RY or function(y) return y / 1080 * ScrH() end

surface.CreateFont("Noah_HUD:Font:1", {
    font = "Roboto Bold",
    size = RY(20)
})

local MatHealth = Material("noah/hud/png/coeurs.png", "smooth")
local MatArmor = Material("noah/hud/png/armor.png", "smooth")
local MatMoney = Material("noah/hud/png/money.png", "smooth")
local MatJob = Material("noah/hud/png/job.png", "smooth")
local MatSalary = Material("noah/hud/png/salary.png", "smooth")
local MatHunger = Material("noah/hud/png/hunger.png", "smooth")
local MatGun = Material("noah/hud/png/gun.png", "smooth")

hook.Add("HUDPaint", "Noah:HUD:FiveM", function()
    local ply = LocalPlayer()
    local health = ply:Health()
    local armor = ply:Armor()
    local money = ply:getDarkRPVar("money")
    local hunger = ply:getDarkRPVar("Energy")

    local job = ply:getDarkRPVar("job")
    local salary = ply:getDarkRPVar("salary")

    local health = math.Clamp(health, 0, 100)
    local armor = math.Clamp(armor, 0, 100)
    local hunger = math.ceil(ply:getDarkRPVar("Energy"))

    draw.RoundedBox(7, ScrW() - 210, 30, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 30, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 70, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 70, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 110, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 110, 35, 30, Color(44, 44, 44, 246))

    if Noah_HUD.Config.MilimalisteMode then
    draw.RoundedBox(7, ScrW() - 210, 150, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 150, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 190, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 190, 35, 30, Color(44, 44, 44, 246))

    draw.RoundedBox(7, ScrW() - 210, 230, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 210, 230, 35, 30, Color(44, 44, 44, 246))
    end

    // Munition

    if !LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    draw.RoundedBox(7, ScrW() - 220, 1030, 200, 30, Color(44, 44, 44, 232))
    draw.RoundedBox(5, ScrW() - 220, 1030, 35, 30, Color(44, 44, 44, 246))
    draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Noah_HUD:Font:1", ScrW() / 1.060, ScrH() - 36, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    // Affiche les informations

    draw.RoundedBox(9, ScrW() - 150, 40, 100, 9, Color(124, 124, 124))
    draw.RoundedBox(9, ScrW() - 150, 40, health * 1, 9, Color(0, 138, 46))
    if Noah_HUD.Config.Text then
    draw.DrawText("" .. health, "Noah_HUD:Font:1", ScrW() - 110, 35, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    draw.RoundedBox(9, ScrW() - 150, 80, 100, 9, Color(124, 124, 124))
    draw.RoundedBox(9, ScrW() - 150, 80, armor * 1, 9, Color(0, 102, 255))
    if Noah_HUD.Config.Text then
    draw.DrawText("" .. armor, "Noah_HUD:Font:1", ScrW() - 110, 75, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    draw.RoundedBox(9, ScrW() - 150, 120, 100, 9, Color(124, 124, 124))
    draw.RoundedBox(9, ScrW() - 150, 120, hunger * 1, 9, Color(255, 102, 0))
    if Noah_HUD.Config.Text then
        draw.DrawText("" .. hunger, "Noah_HUD:Font:1", ScrW() - 110, 115, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end


    if Noah_HUD.Config.MilimalisteMode then
    draw.SimpleText(job, "Noah_HUD:Font:1", ScrW() - 150, 163, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText(salary, "Noah_HUD:Font:1", ScrW() - 115, 203, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText(DarkRP.formatMoney(money), "Noah_HUD:Font:1", ScrW() - 165, 243, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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

    surface.SetMaterial(MatGun)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 209, 1035, 16, 16)
    
    if Noah_HUD.Config.MilimalisteMode then

    surface.SetMaterial(MatJob)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 155, 16, 16)


    surface.SetMaterial(MatSalary)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 195, 16, 16)

    surface.SetMaterial(MatMoney)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(ScrW() - 200, 235, 16, 16)
    end
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

--[[---------------------------------------------------------
   Name: noah-hudfivem
   Author : Noah
   Desc: Hud FiveM
   Version : 1.02
   Last update : 06/10/2024
   Discord : noah_ballas
-----------------------------------------------------------]]