package main

import (
	"github.com/mattn/go-runewidth"
	"github.com/nsf/termbox-go"
)

// Styles
const padding = 2
const color = termbox.ColorDefault

// Helpers
func handleErr(err error) {
	if err != nil {
		panic(err)
	}
}

func tbPrint(x, y int, fg, bg termbox.Attribute, msg string) {
	for _, c := range msg {
		termbox.SetCell(x, y, c, fg, bg)
		x += runewidth.RuneWidth(c)
	}
}

func drawLayout() {
	clearErr := termbox.Clear(color, color)
	handleErr(clearErr)

	tbPrint(padding, padding, color, color, "Welcome to the Ethanic Wallet TUI!")

	flushErr := termbox.Flush()
	handleErr(flushErr)
}

func app() {
	err := termbox.Init()
	handleErr(err)
	defer termbox.Close()
	drawLayout()

exit:
	for {
		switch ev := termbox.PollEvent(); ev.Type {

		case termbox.EventKey:
			switch ev.Key {
			case termbox.KeyCtrlC:
				break exit
			case termbox.KeyEsc:
				break exit
			default:
				if ev.Ch == 'q' {
					break exit
				}
			}

		case termbox.EventError:
			handleErr(ev.Err)
		}

		drawLayout()
	}
}
