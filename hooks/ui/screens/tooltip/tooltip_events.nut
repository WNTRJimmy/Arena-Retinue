::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {


	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function (_entityId, _elementId, _elementOwner )
	{
		local entity;

		if (_entityId != null)
		{
			entity = this.Tactical.getEntityByID(_entityId);
		}

		switch(_elementId)
		{
		case "world-town-screen.main-dialog-module.Arena":
			local ttinfo = this.World.State.getCurrentTown().getBuilding("building.arena").getAttempts()
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Arena"
				},
				{
					id = 2,
					type = "description",
					text = "The arena offers an opportunity to earn gold and fame in fights that are to the death, and in front of crowds that cheer for the most gruesome manner in which lives are dispatched."
				}
				{
					id = 3,
					type = "hint",
					icon = "ui/icons/melee_skill.png",
					text = "There are " + ttinfo[0] + " / " + ttinfo[1] + " fights available today."
				}
			];
			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getBuilding("building.arena").isClosed())
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "No more matches take place here today. Come back tomorrow!"
				});
			}

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() != "contract.arena" && this.World.Contracts.getActiveContract().getType() != "contract.arena_tournament")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You cannot fight in the arena while contracted to do other work"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") && this.World.Assets.getStash().getNumberOfEmptySlots() < 5)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 5 empty inventory slots to fight in the ongoing tournament"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 3 empty inventory slots to fight in the arena"
				});
			}

			return ret;
		}

		return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}
});
