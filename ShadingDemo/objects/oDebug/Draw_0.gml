/// @description Insert description here
// You can write your code in this editor

// Object
for (h = 0; h < range; h++) {
	for (w = 0; w < range; w++) {
		// Check if within Range
		if (point_distance((range / 2), (range / 2), w, h) < (range / 2)) {
			// Draw Vector
			var temp_x_vector = -cos((w / range) * pi);
			var temp_y_vector = -cos(((range - h) / range) * pi);
			
			var temp_dis = point_distance((range / 2), (range / 2), w, h) / (range / 2);
			var temp_z_vector = sqrt(1 - sqr(temp_dis));
			
			// Draw Color
			var temp_x_color = (temp_x_vector / 2) + 0.5;
			var temp_y_color = (temp_y_vector / 2) + 0.5;
			var temp_z_color = (temp_z_vector / 2) + 0.5;
			//temp_x_color = 0;
			//temp_y_color = 0;
			//temp_z_color = 0;
			var temp_color = make_color_rgb(temp_x_color * 255, temp_y_color * 255, temp_z_color * 255);
			
			draw_set_color(temp_color);
			draw_point(x - (range / 2) + w, y - (range / 2) + h);
		}
		else {
			var temp_color = make_color_rgb(0.5 * 255, 0.5 * 255, 1 * 255);
			
			draw_set_color(temp_color);
			draw_point(x - (range / 2) + w, y - (range / 2) + h);
		}
	}
}

/*
// Light
for (h = 0; h < mouse_range; h++) {
	for (w = 0; w < mouse_range; w++) {
		// Check if within Range
		if (point_distance((mouse_range / 2), (mouse_range / 2), w, h) < (mouse_range / 2)) {
			// Draw Vector
			var temp_x_vector = ((w / mouse_range) - 0.5) * 2;
			var temp_y_vector = (((mouse_range - h) / mouse_range) - 0.5) * 2;
			var temp_z_vector = -point_distance((mouse_range / 2), (mouse_range / 2), w, h) / (mouse_range / 2);
			
			// Draw Color
			var temp_x_color = (temp_x_vector / 2) + 0.5;
			var temp_y_color = (temp_y_vector / 2) + 0.5;
			var temp_z_color = (temp_z_vector / 2) + 0.5;
			var temp_color = make_color_rgb(temp_x_color * 255, temp_y_color * 255, temp_z_color * 255);
			
			// Check Color
			var temp_x_position = mouse_x - (mouse_range / 2) + w;
			var temp_y_position = mouse_y - (mouse_range / 2) + h;
			var temp_s_color = draw_getpixel(temp_x_position, temp_y_position);
			
			if (temp_color != c_black) {
				var temp_alt_x_v = (color_get_red(temp_s_color) - 0.5) * 2;
				var temp_alt_y_v = (color_get_green(temp_s_color) - 0.5) * 2;
				var temp_alt_z_v = (color_get_blue(temp_s_color) - 0.5) * 2;
				
				temp_alt_x_v = 1 - clamp(temp_alt_x_v - temp_x_vector, 0, 1);
				temp_alt_y_v = 1 - clamp(temp_alt_y_v - temp_y_vector, 0, 1);
				temp_alt_z_v = 1 - clamp(temp_alt_z_v - temp_z_vector, 0, 1);
				var temp_direction = temp_alt_x_v * temp_alt_y_v * temp_alt_z_v;
				
				draw_set_color(c_white);
				draw_set_alpha(temp_direction);
			}
			
			draw_set_color(temp_color);
			draw_point(temp_x_position, temp_y_position);
			draw_set_alpha(1);
		}
	}
}
*/

draw_set_color(c_white);