::mods_hookExactClass("contracts/contracts/arena_contract", function(o)
{
	local setup = o.setup;
	o.setup = function()
	{
		setup();

		local paymentMult = 1;
		if(this.World.Assets.m.IsArenaTooled){
			paymentMult = 1.25
		}

		this.m.Payment.Pool *= paymentMult;
	}

	local onClear = o.onClear;
	o.onClear = function (){
		if(this.m.Home != null && this.m.IsActive){
		  local building = this.m.Home.getBuilding("building.arena");
		  local original = building.refreshCooldown;
		  building.refreshCooldown = function () {};
		  onClear();
		  building.refreshCooldown = original;
		}		

	}
});
