package tests

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/BurntSushi/toml"
)

func TestTomlFormat(t *testing.T) {
	cwd, err := os.Getwd()
	if err != nil {
		t.Fatalf("failed to get current working directory -> %v", err)
	}
	pattern := filepath.Join(cwd, "*.toml")
	matches, err := filepath.Glob(pattern)
	if err != nil {
		t.Fatalf("failed to enumerate TOML files in %s -> %v", cwd, err)
	}

	for _, m := range matches {
		var data map[string]interface{}
		_, err := toml.DecodeFile(m, &data)
		if err != nil {
			t.Fatalf("malformed TOML file %s -> %v", m, err)
		}
	}
}
