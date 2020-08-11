extends Control


var timerCount = 0


func _ready():
	VisualServer.set_default_clear_color(Color(0, 0, 0))
	$Part1/Node2DPart1.show()
	$Part2/Node2DPart2.hide()
	$Part3/Node2DPart3.hide()
	
	$ReadyForLevel1.hide()


func _on_Timer_timeout():
	self.timerCount += 1
	
	if timerCount == 1:
		$Part1/Node2DPart1.hide()
		$Part2/Node2DPart2.show()
		$Part3/Node2DPart3.hide()
	elif timerCount == 2:
		$Part1/Node2DPart1.hide()
		$Part2/Node2DPart2.hide()
		$Part3/Node2DPart3.show()
	elif timerCount == 3:
		$Part3/Node2DPart3.hide()
		$Background.hide()
		
		$Timer.stop()
		
		$ReadyForLevel1.readyLevel1 = true
		$ReadyForLevel1.show()
