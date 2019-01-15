package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/kevinburke/ssh_config"
)

func narf(configFile string) {
	f, _ := os.Open(configFile)
	cfg, _ := ssh_config.Decode(f)
	for _, host := range cfg.Hosts {
		fmt.Println("patterns:", host.Patterns)
		for _, node := range host.Nodes {
			// Manipulate the nodes as you see fit, or use a type switch to
			// distinguish between Empty, KV, and Include nodes.
			fmt.Println(node.Pos())
			fmt.Println(node.String())
			switch node.(type) {
			case *ssh_config.Include:
				includeObject := node.(*ssh_config.Include)
				fmt.Println("INCLUDE")
				fmt.Println(includeObject.String())
			}
		}
	}
	// Print the config to stdout:
	fmt.Println("--------------------")
	fmt.Println(cfg.String())
}

func main() {
	configFile := filepath.Join(os.Getenv("HOME"), ".ssh", "config")
	narf(configFile)
}
