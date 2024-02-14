$denopsPath = Join-Path $HOME ".cache" "dpp" "repos" "github.com" "vim-denops" "denops.vim"
$hostname = "127.0.0.1"
$port = "32123"

deno run -q --no-lock -A  (Join-Path $denopsPath "denops" "@denops-private" "cli.ts") --hostname $hostname --port $port
