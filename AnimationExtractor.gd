"""
MIT License

Copyright (c) 2020 Master-J

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

"""
How to use :
	
	(1) Select the AnimationPlayer Node containing the animations you want to extract
	(2) Right-click, Add Child Node, select AnimationExtractor
	(3) In the AnimationExtractor's inspector, set the destination folder in which the animations will be saved
	(4) Click on the 'extract_animations' checkbox
	(5) The extraction process will begin and save all the animations found in the AnimationPlayer in the chosen folder
"""


tool
extends Node
class_name AnimationExtractor

export(bool) var extract_animations : bool = false;

#Directory in which the animations will be saved
export(String, DIR) var export_path : String = "res://";

func _process(delta : float) -> void :
	if extract_animations == true :
		extract_animations = false
		
		print("Extracting animations");
		print("Extract destination : " + export_path);
		
		if (get_parent() is AnimationPlayer) == false :
			print("Parent Node is not of type AnimationPlayer, put this node under an AnimationPlayer Node for it to work properly.")
		else :
			#Get source AnimationPlayer
			var animation_player : AnimationPlayer = get_parent() as AnimationPlayer;
			
			#Get all the animations in the source AnimationPlayer
			var animation_list : PoolStringArray = animation_player.get_animation_list();
			
			#For all animations
			for animation in animation_list :
				print("Extracting animation : " + animation)
				var export_full_path : String = export_path + "/" + animation + ".tres";
				if ResourceSaver.save(export_full_path, animation_player.get_animation(animation)) != OK :
					print("Failed to extract animation \"" + animation + "\" to " + export_full_path);
