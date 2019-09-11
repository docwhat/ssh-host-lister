package main

import (
	"fmt"
	"os"
	"path/filepath"

	ssh_config "github.com/kevinburke/ssh_config"
)

func narf(configFile string) {
	f, _ := os.Open(configFile)
	cfg, err := ssh_config.Decode(f)
	if err != nil {
		panic(err)
	}
	for _, host := range cfg.Hosts {
		fmt.Println("patterns:", host.Patterns)
		for _, node := range host.Nodes {
			// Manipulate the nodes as you see fit, or use a type switch to
			// distinguish between Empty, KV, and Include nodes.
			fmt.Println(node.Pos())
			fmt.Println(node.String())
			switch t := node.(type) {
			case *ssh_config.Include:
				fmt.Println("Narf", t)
			}
		}
	}
	// Print the config to stdout:
	fmt.Println("--------------------")
	fmt.Println(cfg.String())
}

func main() {
	// userSettings := ssh_config.DefaultUserSettings

	// // Force the userConfig to be loaded.
	// fmt.Println(userSettings.Get("*", "*"))

	// for _, host := range userSettings.userConfig.Hosts {
	//   fmt.Println("patterns:", host.Patterns)
	//   for _, node := range host.Nodes {
	//     // Manipulate the nodes as you see fit, or use a type switch to
	//     // distinguish between Empty, KV, and Include nodes.
	//     fmt.Println(node.String())
	//   }
	// }

	configFile := filepath.Join(os.Getenv("HOME"), ".ssh", "config")
	narf(configFile)
}
