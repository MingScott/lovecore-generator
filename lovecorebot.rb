require 'discordrb'
require 'open-uri'
require_relative 'lib/lovecorefilter.rb'
include LoveCoreFilter

token = File.read("conf/token.txt")
bot = Discordrb::Commands::CommandBot.new token: token, prefix: '/'

bot.command :lovecore do |event, link, *arg|
	puts "#{event.user.name}##{event.user.discriminator}"
	img = URI.open(link).read
	img = Image.from_blob(img).first
	bg = get_random_image('img/backgrounds/')
	fr = get_random_image('img/backgrounds/')

	text = arg.join(" ").gsub(" | ","\n")

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
	img = add_frame(img, fr)
	10.times do
		add_random_sticker(bg,'img/hearts/',0.25, SoftLightCompositeOp)
	end

	if not text.nil?
		img = make_text(img,text)
	end

	img.write("output/#{img.hash.abs}.png")
	File.open("output/#{img.hash.abs}.png", "r+") do |f|
		event.send_file(f)
		File.delete(f)
	end
	return nil
end
bot.run