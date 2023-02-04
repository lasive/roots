extends Node2D





func _on_BackButton_pressed():
	get_tree().quit()
	


func _on_StartButton_pressed():
	get_tree().change_scene("res://MainScene.tscn")
