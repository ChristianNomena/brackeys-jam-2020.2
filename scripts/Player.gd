extends KinematicBody2D

var health = 100
var potion = 3

var pesanteur = 1.5
var gravity = 1000 * self.pesanteur

var acceleration = 10
var deceleration = 0.125

var max_speed = 400
var jump_height = 800
var jump_count = 0

var player_anim_blend_pos = 1

var vectorFloor = Vector2(0, -1)
var velocity = Vector2()

onready var playerSprite = $Sprite
onready var playerAnim = $AnimationTree

var playerAnimState : AnimationNodeStateMachinePlayback

onready var timer_attack = $TimerAttack
onready var timer_dash = $TimerDash

var Fire = preload("res://scenes/Fire.tscn")

var attacking = false

var able_to_attack
var able_to_dash


func _ready():
	self.playerAnimState = self.playerAnim.get("parameters/playback")


func _physics_process(delta):
	self.MovementLoop()
	
	self.playerAnim.set("active", true)
	
	self.velocity.y += gravity * delta
	self.velocity = move_and_slide(velocity, vectorFloor)


func InitAnimation():
	self.playerAnim.set("parameters/Idle/blend_position", self.player_anim_blend_pos)
	self.playerAnim.set("parameters/Run/blend_position", self.player_anim_blend_pos)
	self.playerAnim.set("parameters/Jump/blend_position", self.player_anim_blend_pos)
	self.playerAnim.set("parameters/Falling/blend_position", self.player_anim_blend_pos)
	self.playerAnim.set("parameters/Dash/blend_position", self.player_anim_blend_pos)
	self.playerAnim.set("parameters/Attack/blend_position", self.player_anim_blend_pos)


func MovementLoop():
	self.InitAnimation()
	
	var left = Input.is_action_pressed("player_move_left")
	var right = Input.is_action_pressed("player_move_right")
	
	var jump = Input.is_action_just_pressed("player_jump")
	var dash = Input.is_action_just_pressed("player_dash") and self.able_to_dash
	var attack = Input.is_action_just_pressed("player_attack") and self.able_to_attack
	
	var healing = Input.is_action_just_pressed("player_interact")
	
	var horizontalDirection = int(right) - int(left)
	
	# =============== Remettre partie de PV ===============
	if self.potion > 0:
		self.HealingPlayer()
	
	# =============== Mouvement d'attaque ===============
	if (attack and self.timer_attack.time_left == 0):
		self.attacking = true
		self.timer_attack.start()
		self.velocity.x = 0
		self.playerAnimState.travel("Attack")
		
	if (self.timer_attack.time_left > 0.17 and self.timer_attack.time_left < 0.25 and attacking):
		self.NewFire()
		self.attacking = false
	
	if (self.timer_attack.time_left < 0.1 and self.timer_attack.time_left > 0):
		self.timer_attack.stop()
		
	elif (self.timer_dash.time_left < 0.1 and self.timer_dash.time_left > 0):
		self.timer_dash.stop()
		
	elif (self.timer_attack.time_left == 0 and self.timer_dash.time_left == 0):
		# =============== Mouvement lineaire horizontal ===============
		if horizontalDirection == -1:
			self.velocity.x = max(self.velocity.x - self.acceleration, -self.max_speed)
			self.playerSprite.flip_h = true
			self.player_anim_blend_pos = -1
			
			if self.is_on_floor():
				self.playerAnimState.travel("Run")
				
		elif horizontalDirection == 1:
			self.velocity.x = min(self.velocity.x + self.acceleration, self.max_speed)
			self.playerSprite.flip_h = false
			self.player_anim_blend_pos = 1
			
			if self.is_on_floor():
				self.playerAnimState.travel("Run")
		
		elif (horizontalDirection == 0 and self.is_on_floor()):
			self.velocity.x = lerp(self.velocity.x, 0, self.deceleration)
			
			if self.is_on_floor():
				self.playerAnimState.travel("Idle")
				
		# =============== Reinitialisation de Jump ===============
		if self.is_on_floor():
			self.jump_count = 0
		
		# =============== Mouvement de Jump ===============
		if (jump and jump_count < 2):
			self.velocity.y = self.jump_height * (-1)
			self.playerAnimState.travel("Jump")
			jump_count += 1
		
		# =============== Mouvement de Falling ===============
		if (not(self.is_on_floor()) and (not(dash)) and (self.jump_count == 0 or self.jump_count == 2)):
			self.playerAnimState.travel("Falling")
		
		# =============== Mouvement de Dash ===============
		if (self.velocity.x >= 10 or self.velocity.x <= -10):
			if dash:
				if ($TimerCooldownDash.time_left < 0.1 and $TimerCooldownDash.time_left >= 0):
					self.MovementDash()
					self.playerAnimState.travel("Dash")
					$TimerCooldownDash.start()


func MovementDash():
	self.timer_dash.start()
	
	if not(self.playerSprite.flip_h):
		self.velocity.x += 200
	else:
		self.velocity.x -= 200


func PlayerDie():
	self.health = 100
	
	self.position.x = 64
	self.position.y = -48


func HealingPlayer():
	self.health += 25
	
	if self.health > 100:
		self.health = 100


func NewFire():
	var direction = 1
	$Muzzle.position.x = 28
	
	if $Sprite.flip_h:
		direction = -1
		$Muzzle.position.x = -28
	
	var fire = Fire.instance()
	fire.new_start($Muzzle.global_position, direction)
	self.get_parent().add_child(fire)


func _on_Area2D_body_entered(body):
	if body.is_in_group("trap"):
		self.PlayerDie()
		
	if body.is_in_group("enemy"):
		self.PlayerDie()
	
	if body.is_in_group("entryLevel2"):
		get_tree().change_scene("res://scenes/stories/ReadyForLevel2.tscn")
		
	if body.is_in_group("entryLevel3"):
		get_tree().change_scene("res://scenes/stories/ReadyForLevel3.tscn")
		
	if body.is_in_group("entryLevel4"):
		get_tree().change_scene("res://scenes/stories/ReadyForLevel4.tscn")
		
	if body.is_in_group("entryLevel5"):
		get_tree().change_scene("res://scenes/stories/ReadyForLevel5.tscn")
