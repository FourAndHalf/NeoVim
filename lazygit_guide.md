# Senior Engineer's Guide to Lazygit

Lazygit is a terminal UI for git commands that makes complex operations visual and efficient.

## 1. Navigation & Basic Workflow

| Key | Action | Description |
| :--- | :--- | :--- |
| `1`-`5` | **Jump to Panel** | 1: Status, 2: Files, 3: Branches, 4: Commits, 5: Stash. |
| `j`/`k` | **Move** | Move up/down within a panel. |
| `h`/`l` | **Tabs** | Move between tabs in the current panel (e.g., Local vs Remote branches). |
| `space` | **Toggle/Stage** | Stage/unstage a file or a specific line/hunk in the diff view. |
| `a` | **Stage All** | Stages all changes in the Files panel. |
| `c` | **Commit** | Create a new commit with a message. |
| `A` | **Amend** | Amend the last commit with current staged changes. |
| `P` / `p` | **Push / Pull** | Push to remote or pull from remote. |
| `?` | **Help** | Open the full keybinding cheatsheet for the current context. |

---

## 2. Merging & Rebasing (The Nuance Methods)

Lazygit excels at visualising the tree during these operations.

### Merging
1.  **Navigate to Branches (3).**
2.  Find the branch you want to merge **INTO** your current branch.
3.  Press `M` to open the merge menu.
4.  Select **Merge** to create a merge commit.
5.  *Nuance:* Use `f` to fast-forward if possible, keeping a linear history.

### Rebasing (The Clean History Approach)
Rebasing is preferred for keeping a clean, linear git history before merging into `main`.

1.  **Rebase Current onto Another Branch:**
    - Go to Branches (3), highlight the base branch (e.g., `main`).
    - Press `r` to rebase your current branch onto it.
2.  **Interactive Rebase (The "Surgical" Method):**
    - Go to Commits (4).
    - Find the commit *before* where you want to start changes.
    - Press `e` to start an interactive rebase from that point.
    - Use the following keys on specific commits:
        - `s`: **Squash** (combine with commit below).
        - `f`: **Fixup** (combine with commit below, discard message).
        - `d`: **Drop** (delete the commit).
        - `e`: **Edit** (pause rebase to modify files).
        - `p`: **Pick** (keep the commit as is).
    - Press `m` to finish the rebase.

---

## 3. Debugging GitHub Issues & Code History

Use Lazygit as a "Time Machine" to find where things went wrong.

### The "Bug Hunt" Workflow
1.  **File History:** In the Files panel (2), highlight a file and press `enter` to see its commit history. This isolates changes to just that file.
2.  **Line History (Blame):** In the diff view, you can see who changed what and when.
3.  **Reflog (`<C-r>`):** If you accidentally deleted a branch or messed up a rebase, go to the Branches panel and press `Ctrl+r` to see the Reflog. You can checkout or reset to any previous state, even if "deleted".
4.  **Cherry-pick:** If a fix exists on another branch, find that commit in its branch history, press `c` to copy it, go to your branch, and press `v` to paste (cherry-pick) it.

### GitHub Integration
If configured, you can interact with GitHub directly:
-   `o`: Open the current repo/file/commit in the browser.
-   `Create Pull Request`: Usually found in the branches menu (`M`).

---

## 4. Resolving Conflicts
When a merge or rebase fails:
1.  Lazygit will enter **Conflict Resolution Mode**.
2.  Files with conflicts will be marked in red in the Files panel (2).
3.  Select the file and press `enter`.
4.  Navigate between conflicts with `[` and `]`.
5.  Select:
    - `b`: Keep **Both** versions.
    - `top`: Keep **Our** version (Current branch).
    - `bottom`: Keep **Their** version (Incoming branch).
6.  Once resolved, stage the file (`space`) and continue the operation (`m` for rebase or `c` for merge).
