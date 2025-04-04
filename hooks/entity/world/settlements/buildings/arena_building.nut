::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	o.m.NumArenaAttempts <- 3;
	o.m.DailyRefresh <- true;

	local refreshCooldown = o.refreshCooldown;
	o.refreshCooldown = function ()
	{

		this.updateAttempts();
		if(this.m.NumArenaAttempts == 0){
			refreshCooldown();
			this.m.DailyRefresh = true;
		}
	}
	
	local onClicked = o.onClicked;
	o.onClicked = function (_townScreen)
	{
	
		if(this.World.Assets.m.IsArenaTooled && this.m.DailyRefresh)
		{

			this.m.NumArenaAttempts = 3;
			this.m.DailyRefresh = false;
		}
		onClicked(_townScreen);
	}
	
	o.updateAttempts <- function ()
	{
		if(this.World.Assets.m.IsArenaTooled)
		{
			this.m.NumArenaAttempts--;
		}else
		{
			this.m.NumArenaAttempts = 0;
		}
	}

	o.getAttempts <- function ()
	{
		if(!this.World.Assets.m.IsArenaTooled){
			if(this.isClosed()){
				return [0,1]
			}
			else if(this.m.DailyRefresh){
				return [1,1];
			}else{
				return [0,1];
			}
		}
		else
		{
			if(this.isClosed()){
				return [0,3]
			}
			else if(this.m.DailyRefresh){
				return [3,3];
			}
			else
			{
				return [this.m.NumArenaAttempts, 3];
			}

		}
	}

	local onSerialize = o.onSerialize
	o.onSerialize = function ( _out){
		onSerialize(_out);
			_out.writeBool(this.m.DailyRefresh);
			_out.writeI16(this.m.NumArenaAttempts)
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function (_in){
        onDeserialize(_in);
        if(::ArenaRetinue.Mod.Serialization.isSavedVersionAtLeast("1.0.0", _in.getMetaData())) {
          this.m.DailyRefresh = _in.readBool();
          this.m.NumArenaAttempts = _in.readI16();
        }
	}
});
