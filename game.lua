Game.Rule.respawnable = false
Game.Rule.enemyfire = false
Game.Rule.friendlyfire = false

GroundSpeed = {}

for i = 1, 24 do 
	GroundSpeed[i] = Game.SyncValue.Create(string.format("No.%i", i))
end

function Game.Rule:OnUpdate(time)
	for k,v in ipairs(GroundSpeed) do
        local player = Game.Player.Create(k)
        if player ~= nil then
            v.value = math.sqrt(player.velocity.x^2 + player.velocity.y^2)
        end
    end
end

function Game.Rule:OnPlayerAttack(victim, attacker, damage, weapontype, hitbox)
	return 0
end