local status_ok, gen = pcall(require, 'gen')
if not status_ok then
  return
end

-- Configure Gen.nvim for Gemini API
-- Note: You MUST set the GEMINI_API_KEY environment variable in your shell.
-- export GEMINI_API_KEY="your_api_key_here"

gen.setup({
  model = "gemini-2.5-pro",
  display_mode = "float",
  show_prompt = true,
  show_model = true,
  no_auto_close = false,
  init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,

  -- Function to generate the command
  command = function(options)
    local api_key = os.getenv("GEMINI_API_KEY")
    if not api_key then
        print("Error: GEMINI_API_KEY environment variable not set.")
        return ""
    end

    -- URL for Gemini API (Streaming)
    local url = string.format(
      "https://generativelanguage.googleapis.com/v1beta/models/%s:streamGenerateContent?alt=sse&key=%s",
      options.model, api_key
    )

    -- Construct the JSON payload for Gemini
    -- We need to escape the prompt for JSON
    local body = {
      contents = {
        {
          parts = {
            { text = options.prompt }
          }
        }
      }
    }

    local json_body = vim.fn.json_encode(body)

    -- Return the curl command
    -- We use a python script or jq to parse the SSE stream if needed, 
    -- but gen.nvim expects raw text usually. 
    -- Gemini SSE format is data: {"candidates": [{"content": {"parts": [{"text": "..."}]}}]}
    -- This command extracts the text from the stream.
    return "curl --silent --no-buffer -X POST '" .. url .. "'" ..
           " -H 'Content-Type: application/json'" ..
           " -d '" .. json_body .. "'" ..
           " | stdbuf -oL sed -n 's/^data: //p' | stdbuf -oL jq -j '.candidates[0].content.parts[0].text // empty'"
  end,
})

-- Visual Mode Keybindings
vim.keymap.set('v', '<leader>ge', ":lua require('gen').select_action()<CR>", { desc = "Gen: Select AI Action" })
vim.keymap.set('v', '<leader>gg', ":lua require('gen').run_action('Complete Code')<CR>", { desc = "Gen: Complete Code" })
vim.keymap.set('v', '<leader>gr', ":lua require('gen').run_action('Refactor')<CR>", { desc = "Gen: Refactor" })
vim.keymap.set('v', '<leader>gd', ":lua require('gen').run_action('Document')<CR>", { desc = "Gen: Document" })
vim.keymap.set('v', '<leader>gf', ":lua require('gen').run_action('Fix Code')<CR>", { desc = "Gen: Fix Code" })
vim.keymap.set('v', '<leader>gt', ":lua require('gen').run_action('Add Tests')<CR>", { desc = "Gen: Add Tests" })

-- Insert Mode Keybindings
vim.keymap.set('i', '<C-g>c', "<Esc>:lua require('gen').run_action('Complete Code')<CR>i", { desc = "Gen: Inline Complete Code" })
vim.keymap.set('i', '<C-g>f', "<Esc>:lua require('gen').run_action('Fix Code')<CR>i", { desc = "Gen: Inline Fix Code" })

-- Normal Mode Keybinding
vim.keymap.set('n', '<leader>gp', function()
  vim.ui.input({ prompt = 'Ask Gemini: ' }, function(prompt)
    if prompt and #prompt > 0 then
      require('gen').request(prompt)
    end
  end)
end, { desc = "Gen: Prompt Custom Question" })
