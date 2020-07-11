/// @description Insert description here
// You can write your code in this editor

x = mouse_x;
y = mouse_y;

if (mouse_check_button_pressed(mb_left)) {
	var temp_inst = instance_create_depth(x, y, depth, oPointLight);
	temp_inst.range = 80;
}