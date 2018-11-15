#!/usr/bin/env ruby -W0
# Written by Sourav Goswami, thanks to Ruby2D!
# The GNU General Public License v3.0

require 'ruby2d'
require 'securerandom'

module Ruby2D
	def change_color=(colour='random')
		opacity, self.color = self.opacity, colour
		self.opacity = opacity
	end

	def get_color() [self.r, self.g, self.b, 1] end
end

def main
	$width, $height = 640, 340
	set title: 'Hex-Float Colour Converter', width: $width, height: $height, fps_cap: 45, resizable: true

	increase, decrease = proc { |obj, l=1| obj.opacity += 0.05 if obj.opacity < l }, proc { |obj, l=0.5| obj.opacity -= 0.05 if obj.opacity > l }
	bg = Rectangle.new width: $width, height: $height, color: "##{SecureRandom.hex(3)}"

	typed = SecureRandom.hex(3)
	floating_squares, speeds = [], []

	100.times do
		size = rand(5.0..10.0)
		sq = Image.new('images/square.png', width: size, height: size, color: "##{SecureRandom.hex(3)}")
		sq.x, sq.y = rand(0..$width - sq.width), rand(0..$height)
		floating_squares << sq
		speeds << rand(1.0..3.0)
	end

	enter_hex_label_touched = false
	enter_hex_label = Text.new 'Enter Hex Colour: ', font: 'fonts/ArimaMadurai-Regular.ttf', x: 15, y: 15
	hex_box_touched = false
	hex_box = Rectangle.new color: '#ffffff', width: $width - 30, height: 50
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

	r_label_touched = false
	r_label = Text.new 'RED', color: 'green', size: 15, font: 'fonts/ArimaMadurai-Regular.ttf'
	r_label.x, r_label.y = r_box.x + r_box.width/2 - r_label.width/2, r_box.y - r_label.height

	g_label_touched = false
	g_label = Text.new 'GREEN', color: 'green', size: 15, font: 'fonts/ArimaMadurai-Regular.ttf'
	g_label.x, g_label.y = g_box.x + g_box.width/2 - g_label.width/2, g_box.y - g_label.height

	b_label_touched = false
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
	quit_text = Text.new 'Exit', color: 'black', font: 'fonts/ArimaMadurai-Regular.ttf'
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

	saved_box = Rectangle.new x: 20, y: 20, width: $width - 40, height: $height - 40, z: 2, color: %w(#3c4f8b #3c4f8b #eae889 #d1739c)
	saved_box.opacity = 0
	saved_box_label = Text.new 'Saved As', font: 'fonts/ArimaMadurai-Regular.ttf', color: '#ffffff', size: 55, z: 3
	saved_box_label.x, saved_box_label.y = saved_box.x + saved_box.width/2 - saved_box_label.width/2, saved_box.y + saved_box.height/2 - saved_box_label.height
	saved_box_label1 = Text.new 'MyColours.txt', font: 'fonts/ArimaMadurai-Regular.ttf', color: '#ffffff', size: 55, z: 3
	saved_box_label1.x, saved_box_label1.y = saved_box.x + saved_box.width/2 - saved_box_label1.width/2, saved_box_label.y + saved_box_label.height
	saved_box_label.opacity = saved_box_label1.opacity = 0

	blurry_line_active = false
	blurry_line = Image.new 'images/line.png', width: 10
	blurry_line.opacity = 0

	on :key_down do |k|
		exit 0 if %w(escape q p).include?(k.key)
		if r_box_touched
			r_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and r_key.length < 6
			r_key = '1' if r_key.to_i > 1
			r_key.chop! if k.key == 'backspace'
		elsif g_box_touched
			g_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and g_key.length < 6
			g_key = '1' if g_key.to_i > 1
			g_key.chop! if k.key == 'backspace'
		elsif b_box_touched
			b_key += k.key[-1] if k.key[-1].match(/[0-9.]/) and b_key.length < 6
			b_key = '1' if b_key.to_i > 1
			b_key.chop! if k.key == 'backspace'
		else
			if k.key == 'backspace' then typed.chop!
				else typed += k.key[-1] if k.key[-1].match(/[a-f0-9]/) and typed.length < 6 end
		end
	end

	on :mouse_move do |e|
		enter_hex_label_touched = enter_hex_label.contains?(e.x, e.y) ? true : false
		clear_label_touched = clear_label.contains?(e.x, e.y) ? true : false
		hex_box_touched = hex_box.contains?(e.x, e.y) ? true : false
		r_box_touched = r_box.contains?(e.x, e.y) ? true : false
		g_box_touched = g_box.contains?(e.x, e.y) ? true : false
		b_box_touched = b_box.contains?(e.x, e.y) ? true : false
		r_label_touched = r_label.contains?(e.x, e.y) ? true : false
		g_label_touched = g_label.contains?(e.x, e.y) ? true : false
		b_label_touched = b_label.contains?(e.x, e.y) ? true : false
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
		# clear the screen if reset or clear button is pressed
		typed = r_key = g_key = b_key = '' if clear_label.contains?(e.x, e.y)
		typed = r_key = g_key = b_key = '' if reset_button.contains?(e.x, e.y)

		exit 0 if quit_button.contains?(e.x, e.y)
		typed = SecureRandom.hex(3) if random_button.contains?(e.x, e.y)

		# Save colours to a file
		if save_button.contains?(e.x, e.y)
			File.open('My Colours.txt', 'a+') do |file|
				if File.zero?('My Colours.txt') then file.puts 'This File is Created by Float-Hex Colour Converter' end
				file.puts "Saved #{Time.new.strftime('on %D at %T')}
					Hex = ##{typed}
					Float R, G, B = #{r.to_f.round(4)}, #{g.to_f.round(4)}, #{b.to_f.round(4)}
					R, G, B = #{r.to_i.*(255).ceil}, #{g.to_i.*(255).ceil}, #{b.to_i.*(255).ceil}\n\n"
			end
			saved_box.opacity = saved_box_label.opacity = saved_box_label1.opacity = 0.8
		end
	end

	update do
		floating_squares.each_with_index do |square, index|
			square.y -= speeds[index]
			square.rotate += speeds[index]
			if square.y < -square.height
				size = rand(5.0..10.0)
				square.color = "##{SecureRandom.hex(3)}"
				square.width = square.height = size
				square.x, square.y = rand(0..$width - size), $height
				speeds.delete_at(index)
				speeds.insert(index, rand(1.0..3.0))
			end
		end

		saved_box.opacity -= 0.01 if saved_box.opacity > 0
		saved_box_label.opacity -= 0.01 if saved_box_label.opacity > 0
		saved_box_label1.opacity -= 0.01 if saved_box_label1.opacity > 0

		blurry_line_active ? increase.call(blurry_line) : decrease.call(blurry_line, 0)
		r_label_touched ? decrease.call(r_label) : increase.call(r_label)
		g_label_touched ? decrease.call(g_label) : increase.call(g_label)
		b_label_touched ? decrease.call(b_label) : increase.call(b_label)
		enter_hex_label_touched ? decrease.call(enter_hex_label) : increase.call(enter_hex_label)

		clear_label_touched ? decrease.call(clear_label) : increase.call(clear_label)
		hex_box_touched ? decrease.call(hex_box) : increase.call(hex_box)

		r_box_touched ? decrease.call(r_box) : increase.call(r_box)
		g_box_touched ? decrease.call(g_box) : increase.call(g_box)
		b_box_touched ? decrease.call(b_box) : increase.call(b_box)

		r_rgb_touched ? decrease.call(r_rgb) : increase.call(r_rgb)
		g_rgb_touched ? decrease.call(g_rgb) : increase.call(g_rgb)
		b_rgb_touched ? decrease.call(b_rgb) : increase.call(b_rgb)

		random_button_touched ? decrease.call(random_button) : increase.call(random_button)
		save_button_touched ? decrease.call(save_button) : increase.call(save_button)
		reset_button_touched ? decrease.call(reset_button) : increase.call(reset_button)
		quit_button_touched ? decrease.call(quit_button) : increase.call(quit_button)

		# convert hex to decimal
		unless typed[1..2].nil?
			r = (typed[0..1].to_i(16)/255.0).round(4)
			r_key, g_key, b_key = '', '', ''
		else r = r_key
		end
		g = typed[3..4].nil? ? g_key : (typed[2..3].to_i(16)/255.0).round(4)
		b = typed[5..6].nil? ? b_key : (typed[4..5].to_i(16)/255.0).round(4)

		r_text.text, g_text.text, b_text.text = r, g, b

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
			hex_box.change_color = hex_box_entry_text.change_color = enter_hex_label.change_color = '#0000ff'
			r_label.change_color = g_label.change_color = b_label.change_color = '#0000ff'
			r_box.change_color = g_box.change_color = b_box.change_color = '#0000ff'
			r_rgb.change_color = g_rgb.change_color = b_rgb.change_color = '#0000ff'
			random_button.change_color = quit_button.change_color = '#0000ff'
			save_button.change_color = reset_button.change_color = '#0000ff'
		 	hex_box_entry_text.change_color = clear_label.change_color = '#ffffff'
			r_rgb_label.change_color = g_rgb_label.change_color = b_rgb_label.change_color = '#ffffff'
			random_text.change_color = quit_text.change_color = '#ffffff'
			r_text.change_color = g_text.change_color = b_text.change_color = hash.change_color = '#ffffff'
			random_text.change_color = quit_text.change_color = '#ffffff'
			save_button_label.change_color = reset_button_label.change_color = '#ffffff'
		else
			hex_box.change_color = enter_hex_label.change_color = '#ffffff'
			r_label.change_color = g_label.change_color = b_label.change_color = '#ffffff'
			r_box.change_color = g_box.change_color = b_box.change_color = '#ffffff'
			random_button.change_color = quit_button.change_color = '#ffffff'
			r_rgb.change_color = g_rgb.change_color = b_rgb.change_color = '#ffffff'
			save_button.change_color = reset_button.change_color = '#ffffff'
			hex_box_entry_text.change_color = clear_label.change_color = hash.change_color = bg.get_color
			hex_blink.change_color = r_line.change_color = g_line.change_color = b_line.change_color = bg.get_color
			r_text.change_color = g_text.change_color = b_text.change_color = bg.get_color

			r_rgb_label.change_color = g_rgb_label.change_color = b_rgb_label.change_color = bg.get_color
			random_text.change_color = quit_text.change_color = bg.get_color
			r_text.change_color = g_text.change_color = b_text.change_color = hash.change_color = bg.get_color
			random_text.change_color, quit_text.change_color,  save_button_label.change_color, reset_button_label.change_color= 'purple', 'orange', 'red', 'green'
		end

		hex_blink.x1 = hex_blink.x2 = hex_box_entry_text.x + hex_box_entry_text.width + 5
		r_line.x1 = r_line.x2 = r_text.x + r_text.width + 5
		g_line.x1 = g_line.x2 = g_text.x + g_text.width + 5
		b_line.x1 = b_line.x2 = b_text.x + b_text.width + 5

		r_line.opacity = r_box_touched ? (Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1) : 0
		g_line.opacity = g_box_touched ? (Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1) : 0
	 	b_line.opacity =  b_box_touched ? (Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1) : 0
		hex_blink.opacity =  hex_box_touched ? (Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1) : 0
	end
	show
end
main
