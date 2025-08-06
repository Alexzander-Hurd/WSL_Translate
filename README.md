[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![project_license][license-shield]][license-url]

# WSL-Translate

A minimal, zero-dependency shell utility to convert **Windows-style paths** to their **WSL-compatible equivalents**, with optional inline actions such as `cd`, `mv`, `cp`, `ls`, and more. Usable as a simple path converter or a sourced shell helper with persistent context switching.

[View on GitHub](https://github.com/Alexzander-Hurd/WSL_Translate)

---

## 📜 Table of Contents

- [About The Project](#about-the-project)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)
- [Security Policy](#security-policy)

---

## 🧠 About The Project

WSL-Translate helps WSL users seamlessly bridge the gap between **Windows paths** and **Linux file system semantics**:

- Convert `C:\Users\Name\file.txt` → `/mnt/c/Users/Name/file.txt`
- Invoke common commands (`cd`, `cp`, `ls`, etc.) directly on translated paths
- Source into your shell to persist directory context changes
- Bash and Zsh compatible (with shell-specific handling)
- `.env` support for local config overrides (e.g., mount point, default function)

---

## 🛠 Built With

This project is built with:

[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Zsh](https://img.shields.io/badge/Shell-Zsh-000000?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.zsh.org/)
[![WSL](https://img.shields.io/badge/WSL-Compatible-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://docs.microsoft.com/en-us/windows/wsl/)

---

## 🚀 Getting Started

### Prerequisites

- Bash 4+ or Zsh
- WSL installed (Ubuntu, Debian, Fedora, etc.)
- No additional dependencies (`sed`, `awk`, etc. not required)

### Installation

Clone the repository:

```bash
git clone https://github.com/Alexzander-Hurd/WSL_Translate.git
cd WSL-Translate
chmod +x wsl_translate.sh
```

> Optional: Add `wsl_translate.sh` to your `$PATH` for global usage

---

## 💡 Usage

### Basic Path Translation

```bash
./wsl_translate.sh "C:\Users\Name\Documents"
```

Returns:

```bash
/mnt/c/Users/Name/Documents
```

### With a Function

```bash
WSL_TRANSLATE_FUNC=ls ./wsl_translate.sh "C:\Windows"
```

You’ll be prompted before running the command.

### Source Mode (Zsh or Bash)

```bash
source ./wsl_translate.sh "C:\Users"
```

Allows commands like `cd` to persist within the current shell session.

> ⚠️ Shell-specific behavior like `read -p` and `return` are handled automatically

---

## 🧩 Supported Functions

- `stdout` — Default, outputs the translated path
- `cd` — Change directory (only when sourced)
- `ls` — List directory contents
- `mv` — Move the file or directory
- `cp` — Copy the file or directory
- `rm` — Delete the file or directory
- `mkdir` — Create subdirectories
- `touch` — Create a new file

---

## 📦 .env Support

You can configure default settings using a `.env` file in the project root:

```env
WSL_TRANSLATE_FUNC=ls
WSL_TRANSLATE_MNT=/mnt/d
```

Only unset environment variables are overwritten, so you can override inline:

```bash
WSL_TRANSLATE_FUNC=mv ./wsl_translate.sh "C:\temp\foo"
```

---

## 🛣 Roadmap

See [ROADMAP.md](ROADMAP.md) for the full development plan.

Planned features:

- Flags and options parsing (`--dry-run`, `--force`, etc.)
- Configurable mounts per drive
- Shell function wrappers for persistent aliases
- Support for WSL 2 path conventions

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Contributions will be governed by a future [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## 🛡 License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for more information.

© Alexzander Hurd

---

## 📬 Contact

- GitHub: [@Alexzander-Hurd](https://github.com/Alexzander-Hurd)
- Website: [alexhurd.uk](https://www.alexhurd.uk)
- Links: [alexhurd.uk/links](https://www.alexhurd.uk/links)

---

## 🛡 Security Policy

Security disclosures and vulnerability reports will be handled via a formal [`SECURITY.md`](SECURITY.md) in the near future. For now, please contact through GitHub issues or [alexhurd.uk](https://www.alexhurd.uk).

---

## 🙌 Acknowledgements

- [Zsh Manual](https://zsh.sourceforge.io/)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
- [Best README Template](https://github.com/othneildrew/Best-README-Template)

[contributors-shield]: https://img.shields.io/github/contributors/Alexzander-Hurd/WSL_Translate.svg?style=for-the-badge
[contributors-url]: https://github.com/Alexzander-Hurd/WSL_Translate/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Alexzander-Hurd/WSL_Translate.svg?style=for-the-badge
[forks-url]: https://github.com/Alexzander-Hurd/WSL_Translate/network/members
[stars-shield]: https://img.shields.io/github/stars/Alexzander-Hurd/WSL_Translate.svg?style=for-the-badge
[stars-url]: https://github.com/Alexzander-Hurd/WSL_Translate/stargazers
[issues-shield]: https://img.shields.io/github/issues/Alexzander-Hurd/WSL_Translate.svg?style=for-the-badge
[issues-url]: https://github.com/Alexzander-Hurd/WSL_Translate/issues
[license-shield]: https://img.shields.io/github/license/Alexzander-Hurd/WSL_Translate.svg?style=for-the-badge
[license-url]: https://github.com/Alexzander-Hurd/WSL_Translate/blob/master/LICENSE
