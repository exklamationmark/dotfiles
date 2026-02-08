" == LSP =====================================================================
lua << EOF
  -- Keybindings: applied to any buffer when an LSP attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gb', '<C-o>', opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
    end,
  })

  -- Rust
  vim.lsp.config('rust_analyzer', {
    settings = {
      ['rust-analyzer'] = {},
    },
  })
  vim.lsp.enable('rust_analyzer')

  -- Rust
  vim.lsp.config('gopls', {})
  vim.lsp.enable('gopls')
EOF
