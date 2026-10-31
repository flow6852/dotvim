package main

import "github.com/Shougo/goda-cmp.vim/cmp"

// configure holds the settings, like the patchGlobal calls of a ddc.ts.
// The settings can also be changed from Vim script at any time, for example
// goda_cmp#patch_global({'ui': 'pum'}); see the README.
func configure(b *cmp.Builder) {
	b.PatchGlobal(cmp.Config{
		UI:      "native", // a UI added in main.go: "native" or "pum"
		Sources: []string{"around", "buffer", "file", "mocword", "cmdline", "cmdlinehistory", "shellnative", "shell", "vim", "lsp"},
		SourceOptions: map[string]cmp.SourceOption{
			"_": {
				Matchers:   []string{"matcherhead"},
				Sorters:    []string{"sorterlength"},
				Converters: []string{"convertertruncateabbr"},
			},
			"around": {Mark: "around"},
			"buffer": {Mark: "buffer"},
			"file": {Mark: "file"},
			"mocword": {Mark: "mocword"},
			"cmdline": {Mark: "cmdline"},
			"cmdlinehistory": {Mark: "cmdlinehistory"},
			"shellnative": {Mark: "shellnative"},
			"shell": {Mark: "shell"},
			"vim": {Mark: "vim"},
			"lsp": {Mark: "lsp"},
		},
		AutoCompleteDelay: new(10),
	})

	// Per filetype, laid over the global settings.
	b.PatchFiletype("markdown", cmp.Config{
		SourceOptions: map[string]cmp.SourceOption{
			"around": {MinAutoCompleteLength: new(3)},
		},
	})
	b.PatchFiletypes([]string{"gitcommit", "text"}, cmp.Config{
		AutoCompleteDelay: new(100),
	})
}
