[h1]Description[/h1]

This mod allows you to change some options from units.
Modify [u]XComRedefineUnits.ini[/u] to do so.

[h1]Variables[/h1]

[u]TemplateName[/u] - [i]String[/i]
[b]Optional[/b] - Name of the template modified.

[u]GroupName[/u] - [i]String[/i]
[b]Optional[/b] - Name of the character group name being modified.

[u]IsWeakToBluescreen[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be weak to Bluescreen, Emp...

[u]IsPsionic[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be psionic.

[u]IsHiddenFromShadowChamber[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be hidden from Shadow Chamber.

[u]IsImmueToFalling[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will take damage from falling.

[u]IsRobotic[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be robotic.

[u]IsHumanoid[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be humanoid. Added for targeting. Only ExludeNonHumanoidAliens uses it. 2 Aliens specify humanoid, Spectre and Codex.

[u]IsAlien[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will be alien.

[u]IsCivilian[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit is a civilian.

[u]IsHostileCivilian[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit is an hostile civilian.

[u]CanBeCarried[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit can be carried when incapacitated

[u]IsAfraidOfFire[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit will panic when set on fire - only applies to flamethrower

[u]CanTakeCover[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not can take cover. By default should be true, but certain large units, like mecs and andromedons, etc, don't take cover, so set to false.

[u]WearArmorInBase[/u] - [i]Bool[/i]
[b]Optional[/b] - Change whether or not this unit should wear their full armor around the base instead of an underlay.

[h1]Usage[/h1]

Can be used by other mods to create modify units by adding [u]XComRedefineUnits.ini[/u] to the mod config.
Can be used by anyone willing to tweak his game even more.

[u]Examples:[/u]
Those are examples with vanilla enemies
[code]
[RedefineUnits.OPTC_Characters]
+Characters=(TemplateName=Gatekeeper, IsWeakToBluescreen=true)
+Characters=(GroupName=Gatekeeper, IsWeakToBluescreen=true)
+Characters=(TemplateName=Sectoid, IsPsionic=true)
+Characters=(TemplateName=ArchonKing, IsHiddenFromShadowChamber=true)
+Characters=(TemplateName=Archon, IsImmueToFalling=true)
+Characters=(TemplateName=AdvMEC_M1, IsRobotic=true)
[/code]
[list]
[*] Gatekeeper is not Robotic but is weak against Tech (Bluescreen, EMP).
[*] All Characters from Gatekeeper group are not weak against Tech (Bluescreen, EMP).
[*] Sectoid is a Psionic unit.
[*] Archon King will not show in the Shadow Chamber informations.
[*] Archon won't take damage from falling.
[*] MEC is a Robotic unit and can be hacked.
[/list]

[h1]Compatibility[/h1]
It should be compatible with everything.

[h1]Troubleshooting[/h1]
https://www.reddit.com/r/xcom2mods/wiki/mod_troubleshooting
[url=steamcommunity.com/sharedfiles/filedetails/?id=683218526]Mods not working properly / at all[/url]
[url=steamcommunity.com/sharedfiles/filedetails/?id=625230005]Mod not working? Mods still have their effects after you disable them?[/url]

