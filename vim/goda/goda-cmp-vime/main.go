// Command config is a user's goda-cmp configuration: an ordinary Go program.
// Build it with :call goda_cmp#build() (or go build) and goda-cmp.vim runs the result.
//
// It is the counterpart of a ddc.ts: extensions are imported (and so type
// checked and completed by your editor), and configured with PatchGlobal and
// PatchFiletype.
package main

import (
	"log"
	"runtime"

	"github.com/Shougo/goda-cmp.vim/cmp"
	"github.com/Shougo/goda-cmp.vim/ext/filter/convertertruncateabbr"
	"github.com/Shougo/goda-cmp.vim/ext/filter/matcherhead"
	"github.com/Shougo/goda-cmp.vim/ext/filter/sorterlength"
	"github.com/Shougo/goda-cmp.vim/ext/source/file"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdline"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdlinehistory"
	"github.com/Shougo/goda-cmp.vim/ext/source/shellnative"
	"github.com/Shougo/goda-cmp.vim/ext/source/shell"
	"github.com/Shougo/goda-cmp.vim/ext/source/vim"
	"github.com/Shougo/goda-cmp.vim/ext/ui/native"
	"github.com/Shougo/goda-cmp.vim/ext/ui/pum"
	"github.com/Shougo/goda-skk.vim/engine"
	"github.com/Shougo/goda-skk.vim/dictionary/google"
	"github.com/Shougo/goda-skk.vim/cmp/source/skk"
	"github.com/Shougo/goda-skk.vim/cmp/source/skkokuri"
)

func main() {

	// skk
	
	jisyo := "/usr/share/skk/SKK-JISYO.L"
	if runtime.GOOS == "windows" {
		jisyo = "~/.config/SKK-JISYO.L"
	}
	p, err := engine.New(engine.Config{
		// globalDictionaries, and the sources: google_japanese_input (and
		// skk_server, for an SKK server).
		Dictionaries: []engine.Dictionary{
			engine.NewJisyo(jisyo, ""),
			google.New(google.Params{}),
			// skkserv.New(skkserv.Params{Addr: "localhost:1178"}),
		},
		// No markers: the highlights GodaSkkHenkan and
		// GodaSkkHenkanSelect show the pre-edit (vimrc.vim).
		MarkerHenkan:          new(""),
		MarkerHenkanSelect:    new(""),
		EggLikeNewline:        true,
		RegisterConvertResult: true,

		// register_kanatable('rom', {'jj': 'escape', '~': ['〜', '']})
		KanaTable: engine.RomTable.With(
			engine.Rule{From: "jj", Func: "escape"},
			engine.Rule{From: "~", Kana: "〜"},
			engine.Rule{From: "z<Space>", Kana: "\u3000"},
			engine.Rule{From: "<M-s>", Kana: "disable"},
			engine.Rule{From: "<M-k>", Kana: "katakana"},
		),
		// register_keymap('input', '<C-z>', 'kakuteiUndo'); <C-z> is
		// mapped by itself.
		Keymaps: map[string]map[string]string{
			"input": {"<C-z>": "kakuteiUndo"},
		},
	})
	if err != nil {
		log.Fatal(err)
	}

	// goda-cmp
	b := cmp.New()

	// Extensions: anything implementing cmp.Source / cmp.Filter / cmp.UI,
	// from this repository or from your own modules. Nothing is built in:
	// even the popup is an extension, chosen with Config.UI.
	b.AddUI(native.New())
	b.AddUI(pum.New()) // needs pum.vim when it is chosen
	b.AddSource(file.New(file.Params{}))
	b.AddSource(cmdline.New())
	b.AddSource(cmdlinehistory.New(cmdlinehistory.Params{}))
	b.AddSource(shellnative.New(shellnative.Params{}))
	b.AddSource(shell.New())
	b.AddSource(vim.New())
	b.AddSource(skk.New(p))
	b.AddSource(skkokuri.New(p))
	b.AddFilter(matcherhead.New(matcherhead.Params{}))
	b.AddFilter(sorterlength.New())
	b.AddFilter(convertertruncateabbr.New(convertertruncateabbr.Params{MaxWidth: 40}))

	configure(b)
	b.Main(p)
}
