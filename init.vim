set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:vimsyn_embed = 'lPr'
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- 宣言ジャンプ
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- 定義ジャンプ
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- ヒント表示
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- 実装ジャンプ
  buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- 引数情報
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts) -- workspaceの追加
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts) -- workspaceの削除
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts) -- workspaceのリスト表示
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts) -- 型定義へのジャンプ
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- リネーム
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- 指摘に対するアクション
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- 参照ジャンプ
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts) -- フォーマット
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- 指摘の開示
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- 次の指摘へ進む
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- 前の指摘に進む
  buf_set_keymap("n", "<space>ql", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) -- 指摘の一覧を表示する
  buf_set_keymap("n", "<space>qf", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts) -- quickfixの一覧を表示する
end

local mason = require('mason')
mason.setup()

local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()
mason_lspconfig.setup_handlers({ function(server_name)
    nvim_lsp[server_name].setup{on_attach = on_attach, capabilities = capabilities}
end })

-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.on_server_ready(function(server)
--     local opts = {}
--     opts.on_attach = on_attach
-- 
--     server:setup(opts)
-- end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
EOF
