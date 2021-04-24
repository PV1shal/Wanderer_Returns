extends Bullet

const DAMAGE = 10
const DAMAGE_CRIT = 15
const CRIT_RATE = 0.5 # Out of 1
const SPEED = 250
const DASH_RECHARGE = 1

func _ready():
	$AnimationPlayer.play("waveGunBullet")

func Hit() -> void:
	$AnimationPlayer.stop()
	$ImpactParticles.scale = Vector2.ONE/self.scale
	self.set_physics_process(false)
	$Area2D.set_block_signals(true)
	$TrailParticles.emitting = false
	$ImpactParticles.emitting = true
	$Light2D.energy = 0
	$Sprite.play("death")
# warning-ignore:return_value_discarded
	$Sprite.connect("animation_finished",self,"Destroy")

func GetSpeed() -> int:
	return SPEED

func _on_Area2D_area_entered(area):
	if(rand_range(0, 1)<CRIT_RATE):
		area.get_parent().OnHit([DAMAGE_CRIT,true,false])
	else:
		area.get_parent().OnHit([DAMAGE,false,false])
	emit_signal("hit_enemy",DASH_RECHARGE)
	#hit()
