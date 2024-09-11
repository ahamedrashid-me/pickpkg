PickPkg - App Store Script

PickPkg is a terminal-based script designed for easy package management on Debian-based systems. This script provides a simple and interactive menu for searching, installing, removing, and listing packages, as well as refreshing the package list and editing repositories. It leverages the dialog utility to offer a user-friendly interface in the terminal.
Features

    Search for Packages: Find available packages by name and view their descriptions.
    Install Packages: Easily install new packages using a straightforward input dialog.
    Remove Packages: Remove installed packages and clean up unused dependencies.
    List Installed Packages: Display a list of currently installed packages on your system.
    Refresh Package List: Update your package list to ensure you have the latest information.
    Edit Repositories: Modify your package sources with a text editor.

Requirements

    bash
    dialog
    apt (for package management)
    nano (for editing repository lists)
    sudo (for administrative tasks)

Installation

To use the script, follow these steps:

    Ensure you have the required tools installed on your system:

    bash

sudo apt-get install dialog nano

Download the PickPkg script and make it executable:

bash

wget https://example.com/path/to/pickpkg.sh -O pickpkg.sh
chmod +x pickpkg.sh

Run the script:

bash

    ./pickpkg.sh

Usage

When executed, PickPkg presents a menu with the following options:

    Search for a package: Enter a package name to search and view details.
    Install a package: Input the name of a package to install it.
    Remove a package: Enter the name of a package to remove it from your system.
    List installed packages: View all installed packages on your system.
    Refresh package list: Update your local package list.
    Edit repositories: Modify your /etc/apt/sources.list to add or change repositories.

Contribution

Contributions are welcome! If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request. For detailed contributing guidelines, please refer to the CONTRIBUTING.md file.
License

This script is licensed under the MIT License.
Contact

For questions or feedback, please reach out via our Facebook page: fb:@ahamedrashid.fb/.
