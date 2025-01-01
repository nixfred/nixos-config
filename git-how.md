Here’s a **README.md** documenting the process as a how-to guide:

---

```markdown
# How to Set Up Git with SSH and Clone a Repository

This guide explains how to set up SSH authentication for GitHub and clone a repository without needing to sign in interactively.

---

## Steps to Set Up SSH Authentication

### 1. Generate an SSH Key
Run the following command to generate a new SSH key:
```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```
- Replace `"your-email@example.com"` with your email address.
- Press `Enter` to accept the default file location.
- Optionally, enter a passphrase for extra security.

### 2. Start the SSH Agent and Add the Key
Start the SSH agent and add your private key:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 3. Add Your SSH Key to GitHub
Display the contents of your public key:
```bash
cat ~/.ssh/id_ed25519.pub
```
- Copy the output.
- Go to your [GitHub SSH Keys Settings](https://github.com/settings/keys).
- Click **New SSH Key**, paste the key, and save.

### 4. Configure SSH for GitHub
Create or update your SSH configuration file:
```bash
nano ~/.ssh/config
```
Add the following lines:
```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

Save the file (`Ctrl + O`, `Enter`, then `Ctrl + X`).

### 5. Test SSH Connection
Verify your SSH setup with GitHub:
```bash
ssh -T git@github.com
```
You should see a message like:
```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

### 6. Clone the Repository
Clone the repository using the SSH URL:
```bash
git clone git@github.com:<username>/<repository>.git
```

---

## Example for Cloning a Specific Repository

If your repository is named `nixos-config` and belongs to the user `nixfred`, use:
```bash
git clone git@github.com:nixfred/nixos-config.git
```

---

## Troubleshooting

- If the SSH key is not working, ensure it has been added to GitHub correctly.
- Use verbose debugging for SSH:
  ```bash
  GIT_SSH_COMMAND="ssh -vvv" git clone git@github.com:nixfred/nixos-config.git
  ```
- Verify that the `~/.ssh/config` file is configured properly and points to the correct key.

---

## Notes

- SSH is the preferred method for secure and seamless GitHub authentication.
- You can reuse this setup for multiple repositories once configured.

---

Happy coding!
```

This `README.md` is user-friendly and provides all necessary details for setting up SSH with GitHub. You can save this file alongside your other documentation or share it with others!
