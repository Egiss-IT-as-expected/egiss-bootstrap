# egiss-bootstrap

Sets up a new Mac for Egiss development. Open Terminal and run:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Egiss-IT-as-expected/egiss-bootstrap/main/bootstrap.sh)"
```

It installs the Xcode Command Line Tools, Homebrew and the GitHub CLI, logs you in to
GitHub, then clones the private [egiss-dev-setup](https://github.com/Egiss-IT-as-expected/egiss-dev-setup)
repository to `~/projects/egiss-dev-setup` and runs its Ansible playbook. Everything else lives there.
