// Command config is a user's goda-cmp configuration: an ordinary Go program.
// Build it with :call goda_cmp#build() (or go build) and goda-cmp.vim runs the result.
//
// It is the counterpart of a ddc.ts: extensions are imported (and so type
// checked and completed by your editor), and configured with PatchGlobal and
// PatchFiletype.
package main

import (
	"github.com/Shougo/goda-cmp.vim/cmp"
	"github.com/Shougo/goda-cmp.vim/ext/filter/convertertruncateabbr"
	"github.com/Shougo/goda-cmp.vim/ext/filter/matcherhead"
	"github.com/Shougo/goda-cmp.vim/ext/filter/sorterlength"
	"github.com/Shougo/goda-cmp.vim/ext/source/around"
	"github.com/Shougo/goda-cmp.vim/ext/source/buffer"
	"github.com/Shougo/goda-cmp.vim/ext/source/file"
	"github.com/Shougo/goda-cmp.vim/ext/source/mocword"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdline"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdlinehistory"
	"github.com/Shougo/goda-cmp.vim/ext/source/shellnative"
	"github.com/Shougo/goda-cmp.vim/ext/source/shell"
	"github.com/Shougo/goda-cmp.vim/ext/source/vim"
	"github.com/Shougo/goda-cmp.vim/ext/source/lsp"
	"github.com/Shougo/goda-cmp.vim/ext/ui/native"
	"github.com/Shougo/goda-cmp.vim/ext/ui/pum"
)

func main() {
	b := cmp.New()

	// Extensions: anything implementing cmp.Source / cmp.Filter / cmp.UI,
	// from this repository or from your own modules. Nothing is built in:
	// even the popup is an extension, chosen with Config.UI.
	b.AddUI(native.New())
	b.AddUI(pum.New()) // needs pum.vim when it is chosen
	b.AddSource(around.New(around.Params{MinLength: 2}))
	b.AddSource(buffer.New(buffer.Params{}))
	b.AddSource(file.New(file.Params{}))
	b.AddSource(mocword.New(mocword.Params{}))
	b.AddSource(cmdline.New())
	b.AddSource(cmdlinehistory.New(cmdlinehistory.Params{}))
	b.AddSource(shellnative.New(shellnative.Params{}))
	b.AddSource(shell.New())
	b.AddSource(vim.New())
	b.AddSource(lsp.New(lsp.Params{}))
	b.AddFilter(matcherhead.New(matcherhead.Params{}))
	b.AddFilter(sorterlength.New())
	b.AddFilter(convertertruncateabbr.New(convertertruncateabbr.Params{MaxWidth: 40}))

	configure(b)
	b.Main()
}
