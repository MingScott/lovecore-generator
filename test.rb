require_relative 'lib/lovecorefilter'
include LoveCoreFilter

img = Image.read('img/subjects/catboy.png').first
bg = get_random_image('img/backgrounds/')

bg = pink_overlay(bg,0.5)
13.times do
	bg = add_random_sticker(bg,'img/hearts/',0.25, OverCompositeOp)
end

img = pink_overlay(img,0.1)
5.times do
	img = add_random_sticker(img, 'img/hearts/',0.1, OverCompositeOp)
end
3.times do
	img = add_random_sticker(img, 'img/glitter/',0.5, AtopCompositeOp)
end

img = add_background(img,bg)
img = add_frame(img, Image.read('img/backgrounds/roses.jpeg').first)
img = make_text(img,"no u can't make up missed clinicals\nwe aw so vewwy sowwy\nfuck u vewwy much i guess")
img.display
img.write('output/catboy.png')
exit