# Easy C++ Compiler Installer (GCC/MinGW)

This script is an automated installer designed to set up the GNU GCC compiler and its associated tools on your Windows system, utilizing MSYS2 and the `pacman` package manager.

## ⚙️ How It Works

The installer performs the following steps:
1. **Administrator Privileges Check:** Requires execution with **Administrator privileges**.
2. **Dependency Check:** Verifies the availability of `winget` (Windows Package Manager) to manage initial downloads.
3. **MSYS2/MinGW Installation:** Downloads and installs the necessary base environment (MSYS2). If a previous installation is detected, this phase will be skipped.
4. **PATH Configuration:** Adds the MinGW compiler path to the system's environment variables (`PATH`), allowing any terminal to locate executables (`g++.exe`, etc.).
5. **GCC Installation:** Installs the complete C++ development tool suite (GCC) using `pacman`.

## 🚀 Usage

1. **Run as Administrator:** Right-click on `EasyC++Installer.bat` and select "Run as administrator".
2. **Language Selection:** Follow the prompts in the console to select a language (es/en).
3. **Wait:** Allow the process to complete. If any step fails, the terminal will display a detailed error.

## ⚠️ Important

**RESTART IS CRITICAL!**
Since this script modifies system environment variables (`PATH`), you must **close and reopen your terminal or IDE** (VS Code, Visual Studio, etc.) after execution for the changes to take effect.

---
*Note: This script utilizes operating system tools and external package managers. Always review the process in progress and ensure you trust the code before executing it.*