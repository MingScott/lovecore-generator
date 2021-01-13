require_relative 'lib/lovecorefilter'
include LoveCoreFilter

img = Image.read('img/subjects/catboy.png').first
bg = get_random_image('img/backgrounds/')
puts "loaded img and bg"

bg = pink_overlay(bg,0.5)
puts "overlaid bg"
13.times do
	bg = add_random_sticker(bg,'img/hearts/',0.25, OverCompositeOp)
	puts "added heart"
end

img = pink_overlay(img,0.1)
5.times do
	img = add_random_sticker(img, 'img/hearts/',0.1, OverCompositeOp)
	puts "added small heart"
end
3.times do
	img = add_random_sticker(img, 'img/glitter/',0.5, AtopCompositeOp)
	puts "glittered"
end

img = add_background(img,bg)
puts "added image and backgroud"
img = add_frame(img, Image.read('img/backgrounds/roses.jpeg').first)
puts "added frame"
img = make_text(img,"no u can't make up missed clinicals\nwe aw so vewwy sowwy\nfuck u vewwy much i guess")
puts "added text"
img.display
img.write('output/catboy.png')O
exit

