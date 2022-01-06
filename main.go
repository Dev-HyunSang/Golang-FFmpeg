package main

import (
	"fmt"
	"log"
	"time"

	ffmpeg "github.com/floostack/transcoder/ffmpeg"
	"github.com/gofiber/fiber/v2"
)

type Config struct {
	Foramt    string `json:"foramt"`
	Overwrite bool   `json:"overwrite"`
}

func main() {
	app := fiber.New()

	app.Post("/", func(c *fiber.Ctx) error {
		req := new(Config)
		if err := c.BodyParser(req); err != nil {
			log.Fatalln(err)
		}

		opts := &ffmpeg.Options{
			OutputFormat: &req.Foramt,
			Overwrite:    &req.Overwrite,
		}

		ffmpegConf := &ffmpeg.Config{
			FfmpegBinPath:   "/usr/local/bin/ffmpeg",
			FfprobeBinPath:  "/usr/local/bin/ffprobe",
			ProgressEnabled: true,
		}

		progress, err := ffmpeg.
			New(ffmpegConf).
			Input("big-buck-bunny_trailer.webm").
			Output(fmt.Sprintf("big-buck-bunny_trailer.%s", req.Foramt)).
			WithOptions(opts).
			Start(opts)
		if err != nil {
			log.Fatalln(err)
		}

		for msg := range progress {
			log.Printf("%+v", msg)
		}

		return c.Status(200).JSON(fiber.Map{
			"message": "Ohhhh!! Successful",
			"date":    time.Now(),
		})
	})

	app.Listen(":3000")
}
