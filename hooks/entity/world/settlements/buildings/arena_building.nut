::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	o.m.ArenaAttemptsRefresh <- 1;
	o.m.DailyRefresh <- true;

	local refreshCooldown = o.refreshCooldown;
	o.refreshCooldown = function ()
	{
		if(!this.World.Assets.m.IsArenaTooled || this.m.ArenaAttemptsRefresh == 1){
			refreshCooldown();
			this.m.DailyRefresh = true;
		}
		else{
			this.m.ArenaAttemptsRefresh--;
		}
	}
	
	local onClicked = o.onClicked;
	o.onClicked = function (_townScreen)
	{
	
		if(this.World.Assets.m.IsArenaTooled && !this.isClosed() && (this.World.getTime().Days >= this.m.CooldownUntil) && this.m.DailyRefresh)
		{
			this.m.ArenaAttemptsRefresh = 6;
			this.m.DailyRefresh = false;
		}
		onClicked(_townScreen);
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
				return [0,5]
			}
			else if(this.m.DailyRefresh){
				return [5,5];
			}
			else
			{
				return [this.m.ArenaAttemptsRefresh / 2, 5];
			}

		}
	}

	local onSerialize = o.onSerialize
	o.onSerialize = function ( _out){
		onSerialize(_out);
		_out.writeBool(this.m.DailyRefresh);
		_out.writeI16(this.m.ArenaAttemptsRefresh)
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function (_in){
        onDeserialize(_in);
        ::ArenaRetinue.Mod.Serialization.isSavedVersionAtLeast("1.0.0", _in.getMetaData()) {
          this.m.DailyRefresh = _in.readBool();
          this.m.ArenaAttemptsRefresh = _in.readI16();
        }
	}
});
