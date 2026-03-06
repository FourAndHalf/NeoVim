# Senior Engineer's Guide to Debugging in Neovim

## 1. The Senior Debugging Philosophy: "The Five Pillars"

1.  **Reproduce Consistently:** You cannot fix what you cannot reliably see. If the bug is intermittent, your first task is to make it happen 100% of the time.
2.  **Isolate the Root Cause:** Use a "Binary Search" approach. Is it the frontend? The API? The Database? The specific function? Narrow the search space until only the culprit remains.
3.  **Understand, Don't Just Patch:** Once you find the line, don't just change `>` to `>=`. Ask: *Why was it `>` in the first place?* What assumptions were made?
4.  **Fix and Refactor:** Apply the fix, but also consider if the code can be made more robust to prevent similar issues.
5.  **Verify and Automate:** Verify the fix manually, then **write a test** that would have caught this bug.

---

## 2. Your Neovim Debugging Arsenal

You now have a powerful debugging environment powered by `nvim-dap`.

### Essential Keybindings

| Key | Action | Description |
| :--- | :--- | :--- |
| `<F5>` | **Continue** | Start debugging or go to next breakpoint. |
| `<leader>b`| **Toggle Breakpoint** | Set/Remove a breakpoint on the current line. |
| `<F10>` | **Step Over** | Execute current line and move to next (don't enter functions). |
| `<F11>` | **Step Into** | Step into the function call on the current line. |
| `<F12>` | **Step Out** | Finish current function and return to caller. |
| `<leader>dr`| **REPL** | Open the DAP REPL for interactive evaluation. |
| `<leader>xx`| **Trouble** | Toggle Trouble to see LSP diagnostics/errors. |

### Advanced Debugging Tools

-   **DAP UI:** Automatically opens when you start debugging. It gives you a "VS Code-like" view of Scopes, Stacks, Watches, and Breakpoints.
-   **Virtual Text:** Variable values are displayed inline next to your code as you step through.
-   **Trouble.nvim:** Use this to see all compiler errors and LSP warnings across your project. Fix these *before* you start runtime debugging.
-   **Logpoints (`<leader>lp`):** Like `print()` statements but without modifying the code. They log a message to the console when hit without stopping execution.

---

## 3. Workflow: Step-by-Step

### Phase 1: Preparation (Static Analysis)
1.  Open **Trouble** (`<leader>xx`).
2.  Clear all red (errors) and yellow (warnings) that might be related to your issue.
3.  Use **LSP References** (`gR`) to see where the data comes from and where it goes.

### Phase 2: Active Debugging (Runtime)
1.  Set a **Breakpoint** (`<leader>b`) at the earliest point where you suspect something is wrong.
2.  Start debugging (`<F5>`). Select your environment (e.g., Python, .NET).
3.  **Step Through** (`<F10>`, `<F11>`) and watch the **Virtual Text**.
4.  When you find a suspicious variable, **Hover** (`<leader>dh`) or use the **REPL** (`<leader>dr`) to test hypotheses:
    *   "What if I change this value to X?"
    *   "Does `my_obj.is_valid()` return true here?"

### Phase 3: The "Deep Dive"
If the bug is complex, use the **Scopes** and **Stacks** in the DAP UI.
-   Check the **Call Stack** to see how you got here. Sometimes the bug is 3 functions up.
-   Check **Variables** in different scopes (Local vs. Global).

---

## 4. Pro Tips for Senior Debugging

-   **Watch Expressions:** In the DAP UI, you can add "Watches". These are expressions that are re-evaluated every time you step. Great for tracking complex object state.
-   **Conditional Breakpoints (`<leader>B`):** Only stop if a condition is true (e.g., `i == 99` in a loop of 1000).
-   **Remote Debugging:** `nvim-dap` can connect to processes running in Docker or on other servers. Look into `dap.adapters` for specific language setups.
-   **The "Rubber Duck":** If you're stuck, explain the code line-by-line to a teammate (or a literal rubber duck). The act of verbalizing often reveals the logic flaw.
