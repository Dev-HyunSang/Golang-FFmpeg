build: 
	@docker build --tag ffmpeg-golang:0.2 .
run: 
	@docker run --name ffmpeg-golang -p 3000:3000 ffmpeg-golang:0.2