# Package-Monitor
Keep track of outdated packages using a variety of package managers.

# Description
I, like many other developers, use various package managers to install and manage packages. I have a cronjob that runs every night thats supposed to keep all these packages up to date, but sometimes I'd like to know what's going to be updated when the job runs. Inspired by Polybar widgets on Linux, this plugin for Bitbar will display the combined number of outdated for a number of package managers. Another inspiration was the [meta package manager](https://meta-package-manager.readthedocs.io/en/develop/bitbar.html) plugin, unfortunately I could not get this to work and decided to rewrite the core functionality myself. This project shares no code but I did make sure to support all of the same package managers.

# Features
* Support for 
  * Brew
  * Brew Cask
  * Node Package Manager
  * Atom Package Manager
  * Mac App Store
  * Gem
  * PIP
* Quickly enable and disable managers to check in one string at the top of the document
* Custom icons to display along side outdated packages list
* Customizable state for 0 outdated packages
* Easy to add support for new package managers down the line
* Dropdown breaks down the outdated packages for every package manager enabled
* Package manager dropdown displays list of outdated packages for that manager

# Dependencies Based on Enabled Package Managers
* Brew
  * [Homebrew](https://brew.sh/)
  
* Brew Cask
  * [Homebrew](https://brew.sh/)
  * [brew-cask-outdated](https://github.com/bgandon/brew-cask-outdated)
  
* Mac App Store
  * [mas-cli](https://github.com/mas-cli/mas)
  
* Gem
  * [gem](https://rubygems.org/pages/download)
  
* Node
  * [Node](https://www.npmjs.com/get-npm)
  * [NPM](https://www.npmjs.com/get-npm)
  
* APM
  * [Atom](https://www.npmjs.com/get-npm)
  * [APM](https://www.npmjs.com/get-npm)
  
* PIP
  * [pip](https://pypi.org/project/pip/)
  * [pipupgrade](https://pypi.org/project/pipupgrade/) *technically not needed as terminal command dont work right now. See Known Issues.*

# Installation Instructions
1. Drag and drop the Packages.6h.sh file into your Bitbar plugins folder
2. Run `chmod +x Package.6h.sh` to allow execution of the file.
3. By default this plugin is set to run every 6 hours. You can rename the file to change that. Check the [Bitbar wiki](https://github.com/matryer/bitbar#installing-plugins) for more information. Keep in mind, this is very network intensive, so don't run it too often.
4. Edit $USE, add or remove package managers as you see fit.
5. Edit $ICON and $ZERO to customize, or leave it as is.

# Known Issues

- [ ] Pip doesn't show up in dropdown despite output being formatted perfectly when script is executed in the terminal. Perhaps this is a Bitbar issue?
- [ ] Terminal commands not executing when clicked.

# Features To Add
- [ ] Add option to upgrade specific package in second-level dropdown menu.
- [ ] Add color options based on number of outdated packages?

# Credit
Feel free to make changes and republish as you see fit, but please give credit in the form of a link to this page!
