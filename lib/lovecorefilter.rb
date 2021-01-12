require 'rmagick'
include Magick

module LoveCoreFilter
	def pink_overlay(img,percent)
		w = img.columns
		h = img.rows

		ovl = Image.new(w,h){self.background_color=Magick::Pixel.from_color("pink")}

		img = img.dissolve(ovl,percent,1)
		return img
	end

	def add_background(img,bg)
		w = img.columns
		h = img.rows

		bg.resize_to_fill!([w,h].max,[w,h].max)

		bw = bg.columns
		bh = bg.rows

		img.resize_to_fit!(bw,bh)

		bg.composite!(img, CenterGravity, 0, 0, OverCompositeOp)
		return bg
	end

	def add_frame(img,frm)
		w = img.columns
		h = img.rows

		frm.resize_to_fill!(w,h)
		frm.crop!(0,0,w,h)

		fw = frm.columns
		fh = frm.rows

		img.resize_to_fit!(fw,fh)
		blank = Image.new(fw,fh){self.background_color = 'none'}

		circle = Draw.new
		circle.circle(w/2,h/2,w/2+[w,h].min/3,h/2+[w,h].min/3)
		circle.draw(blank)

		frm.composite!(blank,0,0, XorCompositeOp)
		frm.alpha(ActivateAlphaChannel)
		frm.transparent('black')
		img.composite!(frm,0,0, OverCompositeOp)
		return img
	end

	def add_random_sticker(img,dirpath,size,comp_op)
		sticker_file = Dir.new(dirpath).children.shuffle.first
		sticker = Image.read("#{dirpath}#{sticker_file}").first
		sticker.background_color = "none"

		w = img.columns
		h = img.rows

		sticker.resize_to_fit!(w*size,h*size)
		rot = 80
		sticker.rotate!(rand(rot)-rot/2)

		img.composite!(sticker,rand(w),rand(h), comp_op)
		return img
	end

	def get_random_image(dirpath)
		Dir.new(dirpath).children.shuffle
		file = Dir.new(dirpath).children.shuffle.first
		Image.read("#{dirpath}#{file}").first
	end

	def make_text(img,str)
		w = img.columns
		h = img.rows

		text = Draw.new
		text.stroke('pink')
		text.fill('pink')
		text.text_undercolor('pale violet red')
		text.pointsize(0.04*h)
		text.font_family('times')
		text.font_weight(NormalWeight)
		text.text_align(CenterAlign)

		text.translate(w/2,3*h/4)

		rot = 20
		text.rotate(rand(rot)-rot/2)

		text.text(0,0," <3 #{str} <3 ".gsub("\n"," <3 \n <3 "))
		
		text.draw(img)
		return img
	end
end