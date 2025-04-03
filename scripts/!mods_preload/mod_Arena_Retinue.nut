::ArenaRetinue <- {
	ID = "mod_Arena_Retinue",
	Name = "Arena Retinue",
	Version = "1.0.0"
}
::ArenaRetinue.ModHook <- ::Hooks.register(::ArenaRetinue.ID, ::ArenaRetinue.Version, ::ArenaRetinue.Name);
::ArenaRetinue.ModHook.require("mod_legends >= 19.1.0", "mod_msu >= 1.6.0");
::ArenaRetinue.ModHook.queue(">mod_legends", ">mod_msu",function()
{
	::ArenaRetinue.Mod <- ::MSU.Class.Mod(::ArenaRetinue.ID, ::ArenaRetinue.Version, ::ArenaRetinue.Name);

	foreach (file in ::IO.enumerateFiles("hooks/"))
	{
		::include(file);
	}
});


