#!/usr/bin/ruby -w
# Written by Sourav Goswami, thanks to Ruby2D!
# The GNU General Public License v3.0

%w(ruby2d securerandom).each { |g| require(g) }

module Ruby2D
	FONT = File.join(File.dirname(__FILE__), %w(fonts ArimaMadurai-Regular.ttf))
	PATH = File.dirname(__FILE__)

	def change_color=(colour) self.color, self.opacity = colour, opacity end
	def get_color() [r, g, b, 1] end
end

def main
	$width, $height = 640, 340
	set title: 'Hex-Float Colour Converter', width: $width, height: $height, fps_cap: 45, resizable: true, icon: File.join(PATH, %w(images icon.png))

	increase, decrease = proc { |obj, l = 1| obj.opacity += 0.05 if obj.opacity < l }, proc { |obj, l = 0.5| obj.opacity -= 0.05 if obj.opacity > l }
	bg = Rectangle.new width: $width, height: $height, color: "##{SecureRandom.hex(3)}"

	typed = SecureRandom.hex(3)

	floating_squares_size = (floating_squares = Array.new(100) do
		Image.new(File.join(PATH, %w(images square.png)), width: (size = rand(5.0..10.0)), height: size, color: "##{SecureRandom.hex(3)}",
			x: rand($width), y: rand($height))
	end).size.to_f

	enter_hex_label_touched = false
	enter_hex_label = Text.new 'Enter Hex Colour: ', font: FONT, x: 15, y: 15
	hex_box = Rectangle.new(width: $width - 30, height: 50, x: enter_hex_label.x, y: enter_hex_label.y + enter_hex_label.height + 5)

	hash = Text.new '#', font:FONT, color: '#FF5C5E', size: 26
	hash.x, hash.y = hex_box.x + 15, hex_box.y + hex_box.height/2 - hash.height / 2

	hex_box_entry_text = Text.new(typed, font: FONT, x: hash.x + hash.width + 5)
	hex_box_entry_text.y = hex_box.y + hex_box.height/2 - hex_box_entry_text.height / 2

	clear_label_touched = false
	clear_label = Text.new 'Clear', font: FONT, color: '#FF5C5E'
	clear_label.x, clear_label.y = hex_box.x + hex_box.width - clear_label.width - 15, hex_box.y + hex_box.height/2 - clear_label.height/2

	r_box = Rectangle.new width: $width / 3 - 20, height: 50, x: hex_box.x, y: hex_box.y + hex_box.height + 30
	g_box = Rectangle.new width: $width / 3 - 20, height: 50, x: r_box.x + r_box.width + 15, y: hex_box.y + hex_box.height + 30
	b_box = Rectangle.new width: $width / 3 - 20, height: 50, x: g_box.x + g_box.width + 15, y: hex_box.y + hex_box.height + 30

	r_label = Text.new 'RED', size: 15, font: FONT
	r_label.x, r_label.y = r_box.x + r_box.width/2 - r_label.width/2, r_box.y - r_label.height

	g_label = Text.new 'GREEN', size: 15, font: FONT
	g_label.x, g_label.y = g_box.x + g_box.width/2 - g_label.width/2, g_box.y - g_label.height

	b_label = Text.new 'BLUE', size: 15, font: FONT
	b_label.x, b_label.y = b_box.x + b_box.width/2 - b_label.width/2, b_box.y - b_label.height

 	r_text = Text.new '', color: '#FF5C5E', size: 20, font: FONT
	r_text.x, r_text.y = r_box.x + 15, r_box.y + r_box.height/2 - r_text.height/2

	g_text = Text.new '', color: '#FF5C5E', size: 20, font: FONT
	g_text.x, g_text.y = g_box.x + 15, g_box.y + g_box.height/2 - g_text.height/2

	b_text = Text.new '', color: '#00FF00', size: 20, font: FONT
	b_text.x, b_text.y = b_box.x + 15, b_box.y + b_box.height/2 - b_text.height/2

	r_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	r_rgb.x, r_rgb.y = hex_box.x, r_box.y + r_box.height + 15
	r_rgb_label = Text.new '255', font: FONT, color: '#000000'
	r_rgb_label.x, r_rgb_label.y = r_rgb.x + 15, r_rgb.y + r_rgb.height/2 - r_rgb_label.height/2

	g_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	g_rgb.x, g_rgb.y = r_rgb.x + r_rgb.width + 15, r_rgb.y
	g_rgb_label = Text.new '255', font: FONT, color: '#000000'
	g_rgb_label.x, g_rgb_label.y = g_rgb.x + 15, g_rgb.y + g_rgb.height/2 - g_rgb_label.height/2

	b_rgb = Rectangle.new width: $width/3 - 20, height: r_box.height
	b_rgb.x, b_rgb.y = g_rgb.x + g_rgb.width + 15, r_rgb.y
	b_rgb_label = Text.new '255', font: FONT, color: '#000000'
	b_rgb_label.x, b_rgb_label.y = b_rgb.x + 15, b_rgb.y + b_rgb.height/2 - b_rgb_label.height/2

	r_key, g_key, b_key = '', '', ''

	quit_button = Rectangle.new width: 100, height: 30
	quit_button.x, quit_button.y = $width - quit_button.width - 5, $height - quit_button.height - 5
	quit_text = Text.new 'Exit', color: '#000000', font: FONT
	quit_text.x, quit_text.y = quit_button.x + quit_button.width/2 - quit_text.width/2, quit_button.y + quit_button.height/2 - quit_text.height/2

	reset_button = Rectangle.new width: 100, height: 30
	reset_button.x, reset_button.y = quit_button.x - quit_button.width - 5, quit_button.y - quit_button.height - 5
	reset_button_label = Text.new "Clear", font: FONT, color: '#DFB81B'
	reset_button_label.x, reset_button_label.y = reset_button.x + reset_button.width/2 - reset_button_label.width/2, reset_button.y + reset_button.height/2 - reset_button_label.height/2

	random_button = Rectangle.new width: 100, height: 30
	random_button.x, random_button.y = reset_button.x + reset_button.width + 5, reset_button.y
	random_text = Text.new 'Random!', color: '#000000', font: FONT
	random_text.x, random_text.y = random_button.x + random_button.width/2 - random_text.width/2, random_button.y + random_button.height/2 - random_text.height/2

	save_button = Rectangle.new width: 100, height: 30, x: reset_button.x, y: quit_button.y
	save_button_label = Text.new "Save", font: FONT, color: '#DFB81B'
	save_button_label.x, save_button_label.y = save_button.x + save_button.width/2 - save_button_label.width/2, save_button.y + save_button.height/2 - save_button_label.height/2

	saved_box = Rectangle.new(x: 20, y: 20, width: $width - 40, height: $height - 40, z: 2, color: '#DFB81B', opacity: 0)
	saved_box_label = Text.new('Saved As', font: FONT, color: '#FFFFFF', size: 55, z: 3, opacity: 0)
	saved_box_label.x, saved_box_label.y = saved_box.x + saved_box.width/2 - saved_box_label.width/2, saved_box.y + saved_box.height/2 - saved_box_label.height
	saved_box_label1 = Text.new('MyColours.txt', font: FONT, color: '#FFFFFF', size: 55, z: 3, opacity: 0)
	saved_box_label1.x, saved_box_label1.y = saved_box.x + saved_box.width/2 - saved_box_label1.width/2, saved_box_label.y + saved_box_label.height

	blurry_line = Image.new(File.join(PATH, %w(images line.png)), width: 10)
	blurry_line.opacity = 0

	touchable_boxes, touched_box = [hex_box, r_box, g_box, b_box, r_rgb, g_rgb, b_rgb], nil
	buttons, touched_button = [random_button, quit_button, save_button, reset_button], nil

	blink_line = Line.new(color: '#00FF00', x1: r_box.x, x2: r_box.x, y1: r_box.y + 5, y2: r_box.y + r_box.height - 5)
	editable_obj = { hex_box => hex_box_entry_text, r_box => r_text, g_box => g_text , b_box => b_text }

	r, g, b, r_hex, g_hex, b_hex, raw_hex = 0, 0, 0, '', '', '', ''
	texts, touched_text = binding.eval('local_variables').map { |lv| eval("#{lv} if Ruby2D::Text === #{lv}") }.compact - [saved_box_label1, saved_box_label], nil

	write_to_file = proc do
		filepath, saved_box.color, saved_box_label.color, saved_box_label1.color = File.join(PATH, 'My Colours.txt'), bg.color, r_box.color, r_box.color
		File.write(filepath, 'This File is Created by Float-Hex Colour Converter') if !File.exist?(filepath) || File.zero?(filepath)
		File.open(filepath, 'a+') do |file|
			file.puts(<<~EOF
					\n\nSaved #{Time.new.strftime('on %D at %T')}
					\t\t\tHex = ##{typed.upcase}
					\t\t\tFloat RGB = #{[r_key, g_key, b_key].join(', ')}
					\t\t\tRGB = #{[r, g, b].join(', ')}
				EOF
			)
		end
		saved_box.opacity = saved_box_label.opacity = saved_box_label1.opacity = 1
	end

	on :key_down do |k|
		close if %w(escape q p).include?(k.key)
		[typed, r_key, g_key, b_key].each { |k| k.clear } if  k.key == 't'
		typed.replace(SecureRandom.hex(3)) if k.key == 'r'
		write_to_file.call if k.key == 's'

		case touched_box
			when r_box
				typed.clear
				r_key.concat(k.key[-1]) if k.key[-1].match(/[0-9.]/) and r_key.length < 8
				r_key.replace('1') if r_key.to_f > 1
				r_key.chop! if k.key == 'backspace'

			when g_box
				typed.clear
				g_key.concat(k.key[-1]) if k.key[-1].match(/[0-9.]/) and g_key.length < 8
				g_key.replace('1') if g_key.to_f > 1
				g_key.chop! if k.key == 'backspace'

			when b_box
				typed.clear
				b_key.concat(k.key[-1]) if k.key[-1].match(/[0-9.]/) and b_key.length < 8
				b_key.replace('1') if b_key.to_f > 1
				b_key.chop! if k.key == 'backspace'

			else
				typed.chop! if k.key == 'backspace'
				typed.concat(k.key[-1]) if k.key[-1].match(/[a-f0-9]/) and typed.length < 6 if k.key != 'backspace'
				typed = raw_hex if typed.empty? and k.key != 'backspace'

				t1, t2, t3 = typed[0..1].to_s, typed[2..3].to_s, typed[4..5].to_s
				r_key, g_key, b_key = [t1, t2, t3].map { |fc| fc.to_i(16)./(255.0).round(6).to_s }
		end
	end

	on :mouse_move do |e|
		enter_hex_label_touched = enter_hex_label.contains?(e.x, e.y)
		clear_label_touched = clear_label.contains?(e.x, e.y)

		touchable_boxes.each { |b| b.contains?(e.x, e.y) ? (touched_box = b) && (break) : touched_box = nil }
		buttons.each { |b| b.contains?(e.x, e.y) ? (touched_button = b) && (break) : touched_button = nil }
		texts.each { |t| t.contains?(e.x, e.y) ? (touched_text = t) && (break) : touched_text = nil }
	end

	on :mouse_up do |e|
		[typed, r_key, g_key, b_key].each { |k| k.clear } if clear_label.contains?(e.x, e.y) || reset_button.contains?(e.x, e.y)

		write_to_file.call if save_button.contains?(e.x, e.y)
		close if quit_button.contains?(e.x, e.y)
		typed.replace(SecureRandom.hex(3)) if random_button.contains?(e.x, e.y)
	end

	update do
		floating_squares.each_with_index do |square, index|
			square.y -= (index / (floating_squares_size / 4.0)) + 1
			square.rotate += (index / (floating_squares_size / 6.0)) + 1

			if square.y < -square.height
				square.color = "##{SecureRandom.hex(3)}"
				square.width = square.height = size = rand(5.0..10.0)
				square.x, square.y = rand($width), $height
			end
		end

		saved_box.opacity -= 0.01 if saved_box.opacity > 0
		saved_box_label.opacity -= 0.01 if saved_box_label.opacity > 0
		saved_box_label1.opacity -= 0.01 if saved_box_label1.opacity > 0

		enter_hex_label_touched ? decrease.call(enter_hex_label) : increase.call(enter_hex_label)
		clear_label_touched ? decrease.call(clear_label) : increase.call(clear_label)

		if touched_box
			if editable_obj.include?(touched_box)
				el = editable_obj[touched_box]
				blink_line.x1 = blink_line.x2 = el.x + el.width + 5
				blink_line.y1, blink_line.y2 = el.y, el.y + el.height
				blink_line.opacity = Time.new.strftime('%N')[0].to_i % 2 == 0 ? 0 : 1
			else
				decrease.(blink_line, 0)
			end

			touchable_boxes.each_with_index do |b|
				b.equal?(touched_box) ? decrease.(b) : increase.(b)
				increase.(blurry_line)
				blurry_line.height = touched_box.height
				blurry_line.x, blurry_line.y = get(:mouse_x) - blurry_line.width / 2, touched_box.y
			end
		else
			touchable_boxes.each { |b| increase.(b) }
			decrease.(blurry_line, 0)
			decrease.(blink_line, 0)
		end

		touched_text ? texts.each { |el| el.equal?(touched_text) ? decrease.(el) : increase.(el) } : (texts.each { |el| increase.(el) })
		touched_button ? (buttons.each { |b| touched_button.equal?(b) ? decrease.(b) : increase.(b) }) : buttons.each { |b| increase.(b) }

		if typed.empty?
			r_text.text, g_text.text, b_text.text = r_key, g_key, b_key

			r_col = r_key.empty? ? '00' : r_key.to_f.*(255).to_i.to_s(16)
			g_col = g_key.empty? ? '00' : g_key.to_f.*(255).to_i.to_s(16)
			b_col = b_key.empty? ? '00' : b_key.to_f.*(255).to_i.to_s(16)

			tm1, tm2, tm3 = [r_key, g_key, b_key].map { |hxc| hxc.to_f.*(255).to_i.to_s(16) == '0' ? '' : hxc.to_f.*(255).to_i.to_s(16) }
			raw_hex = [(tm1.length > 0 ? (tm1.length > 1 ? tm1 : tm1 + '0') : ''), (tm2.length > 0 ? (tm2.length > 1 ? tm2 : tm2 + '0') : ''),
						(tm3.length > 0 ? (tm3.length > 1 ? tm3 : tm3 + '0') : '')].join

			r_hex = r_col.length > 0 ? (r_col.length == 1 ? '0' + r_col : r_col) : '00'
			g_hex = g_col.length > 0 ? (g_col.length == 1 ? '0' + g_col : g_col) : '00'
			b_hex = b_col.length > 0 ? (b_col.length == 1 ? '0' + b_col : b_col) : '00'
		else
			t1, t2, t3 = typed[0..1].to_s, typed[2..3].to_s, typed[4..5].to_s
			r_key, g_key, b_key = [t1, t2, t3].map { |fc| fc.to_i(16)./(255.0).round(6).to_s }

			r, g, b = [t1, t2, t3].map { |rc| rc.to_i(16).to_s }
			r_rgb_label.text, g_rgb_label.text, b_rgb_label.text = r, g, b

			r_hex = t1.length > 0 ? (t1.length == 1 ? t1 + '0' : t1) : '00'
			g_hex = t2.length > 0 ? (t2.length == 1 ? t2 + '0' : t2) : '00'
			b_hex = t3.length > 0 ? (t3.length == 1 ? + t3 + '0' : t3) : '00'
		end

		r_text.text, g_text.text, b_text.text = r_key, g_key, b_key

		hex_box_entry_text.text = [r_hex, g_hex, b_hex].join.upcase
		bg.color = '#' << hex_box_entry_text.text

		if (bg.color.r + bg.color.g + bg.color.b) > 1.8
			texts.each { |t| t.change_color = '#22FF00' }
			blink_line.change_color = '#22FF00'

			[hex_box, enter_hex_label, r_label, g_label, b_label, r_box, g_box, b_box, r_rgb, g_rgb, b_rgb,
				random_button, quit_button, save_button, reset_button].each { |obj| obj.change_color = '#000000' }
		else
			texts.each { |t| t.change_color = bg.get_color }
			blink_line.change_color = bg.get_color

			[hex_box, enter_hex_label, r_label, g_label, b_label, r_box, g_box, b_box, r_rgb, g_rgb, b_rgb,
				random_button, quit_button, save_button, reset_button].each { |obj| obj.change_color = '#FFFFFF' }

			random_text.change_color, quit_text.change_color = '#00F57F', '#F5B200'
			save_button_label.change_color, reset_button_label.change_color= '#00C2F5', '#D65AFB'
		end
	end

	itself
end

main && show
