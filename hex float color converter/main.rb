#!/usr/bin/env ruby -W0
require 'ruby2d'
STDOUT.sync = true

module Ruby2D
	def change_color=(colour='random')
		opacity = self.opacity
		self.color = colour
		self.opacity = opacity
	end

	def get_color() [self.color.r, self.color.g, self.color.b, 1] end
end

def main
	$width, $height = 640, 340

	control = ->(obj, func='reduce', val=0.1, threshold=0.5) {
		if func == 'reduce' then obj.opacity -= val if obj.opacity > threshold
		else obj.opacity += val if obj.opacity < 1
		end
	}

	generate_random_color = ->() {
		hex = ''
		6.times do hex += [Array('a'..'f').sample, ('0'..'9').to_a.sample].sample end
		"##{hex}"
	}

	set title: 'Hex-Float Colour Converter', width: $width, height: $height, fps_cap: 30
	bg = Rectangle.new width: $width, height: $height, color: generate_random_color.call

	typed = generate_random_color.call[1..-1]
	floating_squares = []

	100.times do
		size = rand(5..10)
		sq = Image.new('images/square.png', width: size, height: size, color: generate_random_color.call)
		sq.x, sq.y = rand(0..$width - sq.width), rand(0..$height)
		floating_squares << sq
	end

	enter_hex_label = Text.new 'Enter Hex Colour: ', font: 'fonts/ArimaMadurai-Regular.ttf', x: 15, y: 15
	hex_box_touched = false
	hex_box = Rectangle.new color: 'white', width: $width - 30, height: 50
	hex_box.x, hex_box.y = enter_hex_label.x, enter_hex_label.y + enter_hex_label.height + 5

	hex_blink = Line.new color: 'green', x1: hex_box.x, x2: hex_box.x, y1: hex_box.y + 5, y2: hex_box.y + hex_box.height - 5

	hash = Text.new '#', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'red', size: 26
	hash.x, hash.y = hex_box.x + 15, hex_box.y + hex_box.height/2 - hash.height/2

	hex_box_entry_text = Text.new typed, font: 'fonts/ArimaMadurai-Regular.ttf', x: hash.x + hash.width + 5
	hex_box_entry_text.y = hex_box.y + hex_box.height/2 - hex_box_entry_text.height/2

	clear_label_touched = false
	clear_label = Text.new 'Clear', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'red'
	clear_label.x, clear_label.y = hex_box.x + hex_box.width - clear_label.width - 15, hex_box.y + hex_box.height/2 - clear_label.height/2

	r_box_touched = false
	r_box = Rectangle.new width: $width/3 - 20, height: 50, x: hex_box.x, y: hex_box.y + hex_box.height + 30

	g_box_touched = false
	g_box = Rectangle.new width: $width/3 - 20, height: 50, x: r_box.x + r_box.width + 15, y: hex_box.y + hex_box.height + 30

	b_box_touched = false
	b_box = Rectangle.new width: $width/3 - 20, height: 50, x: g_box.x + g_box.width + 15, y: hex_box.y + hex_box.height + 30

	r_label = Text.new 'RED', color: 'green', size: 15, font: 'fonts/ArimaMadurai-Regular.ttf'
	r_label.x, r_label.y = r_box.x + r_box.width/2 - r_label.width/2, r_box.y - r_label.height

	g_label = Text.new 'GREEN', color: 'green', size: 15, font: 'fonts/ArimaMadurai-Regular.ttf'
	g_label.x, g_label.y = g_box.x + g_box.width/2 - g_label.width/2, g_box.y - g_label.height

	b_label = Text.new 'BLUE', color: 'green', size: 15, font: 'fonts/ArimaMadurai-Regular.ttf'
	b_label.x, b_label.y = b_box.x + b_box.width/2 - b_label.width/2, b_box.y - b_label.height

 	r_text = Text.new '', color: 'green', size: 20, font: 'fonts/ArimaMadurai-Regular.ttf'
	r_text.x, r_text.y = r_box.x + 15, r_box.y + r_box.height/2 - r_text.height/2

	g_text = Text.new '', color: 'green', size: 20, font: 'fonts/ArimaMadurai-Regular.ttf'
	g_text.x, g_text.y = g_box.x + 15, g_box.y + g_box.height/2 - g_text.height/2

	b_text = Text.new '', color: 'green', size: 20, font: 'fonts/ArimaMadurai-Regular.ttf'
	b_text.x, b_text.y = b_box.x + 15, b_box.y + b_box.height/2 - b_text.height/2

	r_line = Line.new color: 'green', x1: r_box.x, x2: r_box.x, y1: r_box.y + 5, y2: r_box.y + r_box.height - 5
	g_line = Line.new color: 'green', x1: g_box.x, x2: g_box.x, y1: g_box.y + 5, y2: g_box.y + g_box.height - 5
	b_line = Line.new color: 'green', x1: b_box.x, x2: b_box.x, y1: b_box.y + 5, y2: b_box.y + b_box.height - 5

	r_rgb_touched = false
	r_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	r_rgb.x, r_rgb.y = hex_box.x, r_box.y + r_box.height + 15
	r_rgb_label = Text.new '255', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'black'
	r_rgb_label.x, r_rgb_label.y = r_rgb.x + 15, r_rgb.y + r_rgb.height/2 - r_rgb_label.height/2

	g_rgb_touched = false
	g_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	g_rgb.x, g_rgb.y = r_rgb.x + r_rgb.width + 15, r_rgb.y
	g_rgb_label = Text.new '255', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'black'
	g_rgb_label.x, g_rgb_label.y = g_rgb.x + 15, g_rgb.y + g_rgb.height/2 - g_rgb_label.height/2

	b_rgb_touched = false
	b_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	b_rgb.x, b_rgb.y = g_rgb.x + g_rgb.width + 15, r_rgb.y
	b_rgb_label = Text.new '255', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'black'
	b_rgb_label.x, b_rgb_label.y = b_rgb.x + 15, b_rgb.y + b_rgb.height/2 - b_rgb_label.height/2

	r_key = g_key = b_key = ''
	r2_key = g2_key = b2_key = ''

	quit_button_touched = false
	quit_button = Rectangle.new width: 100, height: 30
	quit_button.x, quit_button.y = $width - quit_button.width - 5, $height - quit_button.height - 5
	quit_text = Text.new 'Close', color: 'black', font: 'fonts/ArimaMadurai-Regular.ttf'
	quit_text.x, quit_text.y = quit_button.x + quit_button.width/2 - quit_text.width/2, quit_button.y + quit_button.height/2 - quit_text.height/2

	reset_button_touched = false
	reset_button = Rectangle.new width: 100, height: 30
	reset_button.x, reset_button.y = quit_button.x - quit_button.width - 5, quit_button.y - quit_button.height - 5
	reset_button_label = Text.new "Clear", font: 'fonts/ArimaMadurai-Regular.ttf', color: 'orange'
	reset_button_label.x, reset_button_label.y = reset_button.x + reset_button.width/2 - reset_button_label.width/2, reset_button.y + reset_button.height/2 - reset_button_label.height/2

	random_button_touched = false
	random_button = Rectangle.new width: 100, height: 30
	random_button.x, random_button.y = reset_button.x + reset_button.width + 5, reset_button.y
	random_text = Text.new 'Random!', color: 'black', font: 'fonts/ArimaMadurai-Regular.ttf'
	random_text.x, random_text.y = random_button.x + random_button.width/2 - random_text.width/2, random_button.y + random_button.height/2 - random_text.height/2

	save_button_touched = false
	save_button = Rectangle.new width: 100, height: 30, x: reset_button.x, y: quit_button.y
	save_button_label = Text.new "Save", font: 'fonts/ArimaMadurai-Regular.ttf', color: 'orange'
	save_button_label.x, save_button_label.y = save_button.x + save_button.width/2 - save_button_label.width/2, save_button.y + save_button.height/2 - save_button_label.height/2

	saved_box = Rectangle.new x: 20, y: 20, width: $width - 40, height: $height - 40, z: 2, color: %w(red blue green fuchsia)
	saved_box.opacity = 0
	saved_box_label = Text.new 'Saved As', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'white', size: 55, z: 3
	saved_box_label.x, saved_box_label.y = saved_box.x + saved_box.width/2 - saved_box_label.width/2, saved_box.y + saved_box.height/2 - saved_box_label.height
	saved_box_label1 = Text.new 'MyColours.txt', font: 'fonts/ArimaMadurai-Regular.ttf', color: 'white', size: 55, z: 3
	saved_box_label1.x, saved_box_label1.y = saved_box.x + saved_box.width/2 - saved_box_label1.width/2, saved_box_label.y + saved_box_label.height
	saved_box_label.opacity = saved_box_label1.opacity = 0

	blurry_line_active = false
	blurry_line = Image.new 'images/line.png', width: 10
	blurry_line.opacity = 0

	on :key_down do |k|
		exit! 0 if %w(escape q p).include?(k.key)
		if r_box_touched
			r_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and r_key.length < 10
			r_key = '1' if r_key.to_i > 1
			r_key.chop! if k.key == 'backspace'
		elsif g_box_touched
			g_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and g_key.length < 10
			g_key = '1' if g_key.to_i > 1
			g_key.chop! if k.key == 'backspace'
		elsif b_box_touched
			b_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and b_key.length < 10
			b_key = '1' if b_key.to_i > 1
			b_key.chop! if k.key == 'backspace'
		else
			if k.key == 'backspace' then typed.chop!
				else typed += k.key[-1] if k.key[-1].match(/[a-fA-F0-9]/) and typed.length < 6
			end
		end
	end

	on :mouse_move do |e|
		clear_label_touched = clear_label.contains?(e.x, e.y) ? true : false
		hex_box_touched = hex_box.contains?(e.x, e.y) ? true : false
		r_box_touched = r_box.contains?(e.x, e.y) ? true : false
		g_box_touched = g_box.contains?(e.x, e.y) ? true : false
		b_box_touched = b_box.contains?(e.x, e.y) ? true : false
		r_rgb_touched = r_rgb.contains?(e.x, e.y) ? true : false
		g_rgb_touched = g_rgb.contains?(e.x, e.y) ? true : false
		b_rgb_touched = b_rgb.contains?(e.x, e.y) ? true : false
		random_button_touched = random_button.contains?(e.x, e.y) ? true : false
		quit_button_touched = quit_button.contains?(e.x, e.y) ? true : false
		save_button_touched = save_button.contains?(e.x, e.y) ? true : false
		reset_button_touched = reset_button.contains?(e.x, e.y) ? true : false

		if r_box_touched or g_box_touched or b_box_touched
			blurry_line_active = true
			blurry_line.height = r_box.height
			blurry_line.x, blurry_line.y = e.x - blurry_line.width/2, r_box.y
		elsif hex_box_touched
			blurry_line_active = true
			blurry_line.height = hex_box.height
			blurry_line.x, blurry_line.y = e.x - blurry_line.width/2, hex_box.y
		elsif reset_button_touched or random_button_touched
			blurry_line_active = true
			blurry_line.height = reset_button.height
			blurry_line.x, blurry_line.y = e.x - blurry_line.width/2, reset_button.y
		elsif save_button_touched or quit_button_touched
			blurry_line_active = true
			blurry_line.height = save_button.height
			blurry_line.x, blurry_line.y = e.x - blurry_line.width/2, save_button.y
		elsif r_rgb_touched or g_rgb_touched or b_rgb_touched
			blurry_line_active = true
			blurry_line.height = r_rgb.height
			blurry_line.x, blurry_line.y = e.x - blurry_line.width/2, r_rgb.y
		else
			blurry_line_active = false
		end
	end
	r, g, b = 0,0,0

	on :mouse_up do |e|
		typed = r_key = g_key = b_key = '' if clear_label.contains?(e.x, e.y)
		typed = r_key = g_key = b_key = '' if reset_button.contains?(e.x, e.y)
		exit if quit_button.contains?(e.x, e.y)
		if random_button.contains?(e.x, e.y)
			typed = generate_random_color.call[1..-1]
		end
		if save_button.contains?(e.x, e.y)
			file = File.open('My Colours.txt', 'a+')
			if File.zero?('My Colours.txt')
				file.puts "This File is Created by Float-Hex Colour Converter\n"
			else
				unless file.readlines[0].chomp == 'This File is Created by Hex-Float Colour Converter'
					file.truncate(0)
					file.puts 'This File is Created by Hex-Float Colour Converter'
				end
			end
			file.puts "Saved on #{Time.new.strftime('%D %T')}
				Hex = ##{typed}
				Float R, G, B = #{r.to_f.round(3)}, #{g.to_f.round(3)}, #{b.to_f.round(3)}
				R, G, B = #{r.*(255).to_f.ceil}, #{g.*(255).to_f.ceil}, #{b.*(255).to_f.ceil}\n\n"
			file.close
			saved_box.opacity = 0.8
			saved_box_label.opacity = 0.8
			saved_box_label1.opacity = 0.8
		end
	end

	update do
		floating_squares.each do |square|
			square.y -= 1
			square.rotate += square.width/5.0
			if square.y < -square.height
				size = rand(5..10)
				square.color = generate_random_color.call
				square.width = square.height = size
				square.x, square.y = rand(0..$width - size), rand($height..$height + 100)
			end
		end


		saved_box.opacity -= 0.01 if saved_box.opacity > 0
		saved_box_label.opacity -= 0.01 if saved_box_label.opacity > 0
		saved_box_label1.opacity -= 0.01 if saved_box_label1.opacity > 0

		if blurry_line_active
			control.call(blurry_line, '', 0.1)
		else
			control.call(blurry_line, 'reduce', 0.05, 0)
		end

		clear_label_touched ? control.call(clear_label) : control.call(clear_label, '')
		hex_box_touched ? control.call(hex_box, 'reduce', 0.03, 0.8) : control.call(hex_box, '', 0.03)

		r_box_touched ? control.call(r_box, 'reduce', 0.03, 0.7) : control.call(r_box, '')
		g_box_touched ? control.call(g_box, 'reduce', 0.03, 0.7) : control.call(g_box, '')
		b_box_touched ? control.call(b_box, 'reduce', 0.03, 0.7) : control.call(b_box, '')

		r_rgb_touched ? control.call(r_rgb, 'reduce', 0.03, 0.7) : control.call(r_rgb, '')
		g_rgb_touched ? control.call(g_rgb, 'reduce', 0.03, 0.7) : control.call(g_rgb, '')
		b_rgb_touched ? control.call(b_rgb, 'reduce', 0.03, 0.7) : control.call(b_rgb, '')

		random_button_touched ? control.call(random_button) : control.call(random_button, '')
		save_button_touched ? control.call(save_button) : control.call(save_button, '')
		reset_button_touched ? control.call(reset_button) : control.call(reset_button, '')
		quit_button_touched ? control.call(quit_button) : control.call(quit_button, '')

		# convert hex to decimal
		unless typed[1..2].nil?
			r = (typed[0..1].to_i(16).round(10)/255.0).round(8)
			r_key, g_key, b_key = '', '', ''
		else r = r_key
		end
		g = typed[3..4].nil? ? g_key : (typed[2..3].to_i(16).round(10)/255.0).round(8)
		b = typed[5..6].nil? ? b_key : (typed[4..5].to_i(16).round(10)/255.0).round(8)

		r_text.text, g_text.text, b_text.text = r, g, b		#r.to_f.round(10), g.to_f.round(10), b.to_f.round(10)

		hex_box_entry_text.text = typed
		bg.color.r += 0.05 if bg.color.r < r.to_f
		bg.color.r -= 0.05 if bg.color.r > r.to_f
		bg.color.g += 0.05 if bg.color.g < g.to_f
		bg.color.g -= 0.05 if bg.color.g > g.to_f
		bg.color.b += 0.05 if bg.color.b < b.to_f
		bg.color.b -= 0.05 if bg.color.b > b.to_f

		# convert decimal to hex
		if typed == '' and (!r_text.text.empty? or !g_text.text.empty? or !b_text.text.empty?)
			hex_r = r.to_f.*(255).ceil.to_s(16) == '0' ? '00' : r.to_f.*(255).ceil.to_s(16)
			hex_g = g.to_f.*(255).ceil.to_s(16) == '0' ? '00' : g.to_f.*(255).ceil.to_s(16)
			hex_b = b.to_f.*(255).ceil.to_s(16) == '0' ? '00' : b.to_f.*(255).ceil.to_s(16)
			hex_box_entry_text.text = "#{hex_r}#{hex_g}#{hex_b}"
		end

		r_rgb_label.text = r2_key.empty? ? r.to_f.*(255).ceil : r2_key
		g_rgb_label.text = g2_key.empty? ? g.to_f.*(255).ceil : g2_key
		b_rgb_label.text = b2_key.empty? ? b.to_f.*(255).ceil : b2_key

		if bg.color.r + bg.color.g + bg.color.b > 2.6
			hex_box.change_color = hex_box_entry_text.change_color = enter_hex_label.change_color = 'blue'
			r_label.change_color = g_label.change_color = b_label.change_color = 'blue'
		 	hex_box_entry_text.change_color = clear_label.change_color = 'white'
			r_box.change_color = g_box.change_color = b_box.change_color = 'blue'
			r_rgb_label.change_color = g_rgb_label.change_color = b_rgb_label.change_color = 'white'
			r_rgb.change_color = g_rgb.change_color = b_rgb.change_color = 'blue'
			random_button.change_color = quit_button.change_color = 'blue'
			random_text.change_color = quit_text.change_color = 'white'
			r_text.change_color = g_text.change_color = b_text.change_color = hash.change_color = 'white'
			random_text.change_color = quit_text.change_color = 'white'
			save_button.change_color = reset_button.change_color = 'blue'
			save_button_label.change_color = reset_button_label.change_color = 'white'
		else
			hex_box.change_color = enter_hex_label.change_color = 'white'
			r_label.change_color = g_label.change_color = b_label.change_color = 'white'
			r_box.change_color = g_box.change_color = b_box.change_color = 'white'
			hex_box_entry_text.change_color = clear_label.change_color = hash.change_color = bg.get_color
			hex_blink.change_color = r_line.change_color = g_line.change_color = b_line.change_color = bg.get_color
			r_text.change_color = g_text.change_color = b_text.change_color = bg.get_color

			r_rgb_label.change_color = g_rgb_label.change_color = b_rgb_label.change_color = bg.get_color
			random_button.change_color = quit_button.change_color = 'white'
			random_text.change_color = quit_text.change_color = bg.get_color
			r_text.change_color = g_text.change_color = b_text.change_color = hash.change_color = bg.get_color
			r_rgb.change_color = g_rgb.change_color = b_rgb.change_color = 'white'
			save_button.change_color = reset_button.change_color = 'white'
			random_text.change_color = 'purple'
			quit_text.change_color = 'orange'
			save_button_label.change_color = 'red'
			reset_button_label.change_color = 'green'
		end

		hex_blink.x1 = hex_blink.x2 = hex_box_entry_text.x + hex_box_entry_text.width + 5
		r_line.x1 = r_line.x2 = r_text.x + r_text.width + 5
		g_line.x1 = g_line.x2 = g_text.x + g_text.width + 5
		b_line.x1 = b_line.x2 = b_text.x + b_text.width + 5

		if r_box_touched then r_line.opacity = Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1 elsif r_line.opacity > 0 then r_line.opacity -= 0.2 end
		if g_box_touched then g_line.opacity = Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1 elsif g_line.opacity > 0 then g_line.opacity -= 0.2 end
	 	if b_box_touched then b_line.opacity = Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1 elsif b_line.opacity > 0 then b_line.opacity -= 0.2 end
		if hex_box_touched then hex_blink.opacity = Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1 elsif hex_blink.opacity > 0 then hex_blink.opacity -= 0.2 end
	end
	show
end
main
