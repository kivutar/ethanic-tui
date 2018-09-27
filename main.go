package main

import (
	"flag"
	"fmt"
)

func main() {
	var version bool
	flag.BoolVar(&version, "version", false, "version")
	flag.Parse()

	if version {
		fmt.Printf("etui v0.0.1")
	} else {
		fmt.Printf("work-in-progress")
	}
}
