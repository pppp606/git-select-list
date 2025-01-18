# 📋 Git Select List

`git-select-list` is a tool to interactively perform Git operations. It allows you to select files or stashes from a list for actions like `git add`, `git stash`, `git stash apply`, and `git stash drop`.

https://github.com/user-attachments/assets/58c5fe79-cdff-4cbf-8bb4-02c4af767575

### 🎯 Who Is This Tool For?

This tool is designed for users who find Git's interactive mode insufficient but do not need advanced features.
If you require more powerful features, we recommend using tools like [tig](https://github.com/jonas/tig). Alternatively, you can utilize Git's standard `-i` option for entering interactive mode.
`git-select-list` is a lightweight solution for those looking for a balance between simplicity and usability.

## ✨ Features

- **Interactive UI**: Navigate with arrow keys, select with `a` or `s`, and toggle all with `u`.
- **Multiple Actions**: Supports `git add`, `git stash`, `git stash apply`, and `git stash drop`.
- **Lightweight Setup**: No external dependencies, with an included setup script.

---

## 🔨 Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/pppp606/git-select-list.git
   cd git-select-list
   ```

2. Run the setup script:
   ```bash
   bash setup.sh
   ```

3. After setup, you can use the `git ls` command.

---

## 💻 Usage

### Command Format

```bash
git ls <action> [subaction]
```

### Examples

#### Stage Files
1. Run the following command:
   ```bash
   git ls add
   ```
2. Select files from the displayed list using `a` or `u`, then press `Enter`.
3. The selected files will be staged.

#### Stash Files
1. Run the following command:
   ```bash
   git ls stash
   ```
2. Select files from the displayed list using `a` or `u`, then press `Enter`.
3. The selected files will be stashed.

#### Apply a Stash
1. Run the following command:
   ```bash
   git ls stash apply
   ```
2. Select a stash from the displayed list and press `Enter`.

#### Drop a Stash
1. Run the following command:
   ```bash
   git ls stash drop
   ```
2. Select a stash from the displayed list and press `Enter`.


### Supported Actions and Subactions

| Command                 | Description                                           |
|-------------------------|-------------------------------------------------------|
| `git ls add`            | Interactively select modified files to stage.         |
| `git ls stash`          | Interactively select modified files to stash.         |
| `git ls stash apply`    | Interactively select stashes to apply.                |
| `git ls stash drop`     | Interactively select stashes to drop.                 |

---

### ⌨️ Key Bindings

- **Arrow Keys**: Navigate between items.
- **`a` or `s` Key**: Select or deselect the current item.
- **`u` Key**: Select or deselect all items.
- **`Enter` or `Space` Key**: Confirm the selection.

---

## ⚠️ Troubleshooting

1. **`git ls` is not recognized**:
   - Ensure you ran `setup.sh` to configure the alias.
   - Check if the alias is set:
     ```bash
     git config --global --get alias.ls
     ```

2. **Script doesn't work**:
   - Ensure the required files are present.
   - Confirm the path to the script is correct in `setup.sh`.

---

## 🗑️ Uninstallation

1. Remove the alias:
   ```bash
   git config --global --unset alias.ls
   ```

2. Delete the repository:
   ```bash
   rm -rf git-select-list
   ```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

Enjoy a faster and more interactive Git workflow with `git-select-list`! 🎉

