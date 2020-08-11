extends KinematicBody2D

var health = 100

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

# var dashing = false


func _ready():
	self.playerAnimState = self.playerAnim.get("parameters/playback")


func _physics_process(delta):
	self.MovementLoop()
	
	self.playerAnim.set("active", true)
	
	self.velocity.y += gravity * delta
	self.velocity = self.move_and_slide(self.velocity, self.vectorFloor)


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
	var dash = Input.is_action_just_pressed("player_dash")
	var attack = Input.is_action_just_pressed("player_attack")
	
	var horizontalDirection = int(right) - int(left)
	
	# =============== Mouvement d'attaque ===============
	if attack:
		self.timer_attack.start()
		self.velocity.x = 0
		self.playerAnimState.travel("Attack")
	
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
			$CollisionShape2D.disabled = false
			$CollisionShape2DJump.disabled = true
			self.jump_count = 0
		
		# =============== Mouvement de Jump ===============
		if (jump and jump_count < 2):
			self.velocity.y = self.jump_height * (-1)
			self.playerAnimState.travel("Jump")
			
			$CollisionShape2D.disabled = true
			$CollisionShape2DJump.disabled = false
		
		# =============== Mouvement de Falling ===============
		if (not(self.is_on_floor()) and (not(dash)) and (self.jump_count == 0 or self.jump_count == 2)):
			self.playerAnimState.travel("Falling")
		
		# =============== Mouvement de Dash ===============
		if (self.velocity.x >= 10 or self.velocity.x <= -10):
			if dash:
				self.MovementDash()
				self.playerAnimState.travel("Dash")


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


func _on_Area2D_body_entered(body):
	if body.is_in_group("trap"):
		self.PlayerDie()
