#!/bin/bash

# <bitbar.title>Package</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Shrey Choudhary</bitbar.author>
# <bitbar.author.github>SxC97</bitbar.author.github>
# <bitbar.desc>Plugin that displays total number of outdated packages.</bitbar.desc>
# <bitbar.dependencies>brew, brew-cask-outdated, pip, pipoutdated, npm, yarn, apm, gem, mas</bitbar.dependencies>

# Sets unicode encoding to UTF-8. Fixes issues with displaying *many* but not *all* unicode charecters.
export LANG="es_ES.UTF-8"

# Exports the plugin to your $PATH to allow execution. Make sure you run `chmod +x Package.6h.sh` after downloading
export PATH=/usr/local/bin:$PATH

# specify the package managers you want the program to use
USE='brew cask npm yarn apm mas pip'


# Checks to see if the brew command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v brew)" ]] && [[ $USE == *"brew"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  brewLIST=$(brew outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $brewLIST == "" ]]; then
    BREW='0'
    brewLIST=""
  else
    BREW=$(echo "$brewLIST" | wc -l)
  fi

fi

# Checks to see if the brew command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v brew)" ]] && [[ $USE == *"cask"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  caskLIST=$(brew-cask-outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $caskLIST == "" ]]; then
    CASK='0'
    caskLIST=""
  else
    CASK=$(echo "$caskLIST" | wc -l)
  fi

fi

# Checks to see if the pip command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v pip)" ]] && [[ $USE == *"pip"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  pipLIST=$(pip list --outdated)
  tempPIP=$(echo "$pipLIST" | wc -l)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $tempPIP -gt 1 ]]; then
    PIP=$(($tempPIP - 2))
  else
    PIP="0"
    pipLIST=""
  fi

fi

# Checks to see if the npm command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v npm)" ]] && [[ $USE == *"npm"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  npmLIST=$(npm outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $npmLIST == "" ]]; then
    NPM='0'
    npmLIST=""
  else
    NPM=$(echo "npmLIST" | wc -l)
  fi

fi

# Checks to see if the yarn command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v yarn)" ]] && [[ $USE == *"yarn"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  yarnLIST=$(yarn outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $yarnLIST == "" ]]; then
    YARN='0'
    yarnLIST=""
  else
    YARN=$(echo "$yarnLIST" | wc -l)
  fi

fi

# Checks to see if the apm command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v apm)" ]] && [[ $USE == *"apm"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  apmLIST="$(apm outdated)"

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $apmLIST == *"empty"* ]]; then
    APM='0'
    apmLIST=""
  else
  tempAPM=$(echo "$apmLIST" | wc -l)
  APM=$((tempAPM - 1))
  fi

fi

# Checks to see if the gem command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v gem)" ]] && [[ $USE == *"gem"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  gemLIST=$(gem outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $gemLIST == "" ]]; then
    GEM='0'
    gemLIST=""
  else
    GEM=$(echo "$gemLIST" | wc -l)
  fi

fi

# Checks to see if the mas command is avaliable and the package manager is in the enabled list above.
if [[ -x "$(command -v mas)" ]] && [[ $USE == *"mas"* ]]; then

  # runs the outdated command and stores the output as a list variable.
  masLIST=$(mas outdated)

  # checks to see if the returned list is empty. If so, it sets the outdated packages list to zero, if not, sets it to the line count of the list.
  if [[ $masLIST == "" ]]; then
    MAS='0'
    masLIST=""
  else
    MAS=$(echo "$masLIST" | wc -l)
  fi

fi

# sum of all outdated packages
SUM=$(($BREW + $CASK + $PIP + $NPM + $YARN + $APM + $GEM + $MAS))

# icon to be displayed next to number of outdated packages. Feel free to customize.
ICON=""

# icon to be displayed if no packages are outdated. Change to `ZERO=""` if you want the widget to be invisible when no packages are out of date.
ZERO="✔︎"

if [[ $SUM -gt 0 ]]; then
  FINAL="$SUM $ICON"
else
  FINAL="$ZERO"
fi

echo "$FINAL"

# all echo statements below this point will be shown as a submenu
echo "---"

# option to upgrade all packages
echo "upgrade all: $SUM | bash='$0' param1=all terminal=false"

# option to upgrade brew packages
if [[ -x "$(command -v brew)" ]] && [[ $USE == *"brew"* ]]; then
  echo "brew: $BREW | bash='$0' param1=brew terminal=true"

  if ! [[ $brewLIST == "" ]]; then
    echo "$(echo "$brewLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade cask packages
if [[ -x "$(command -v brew-cask-outdated)" ]] && [[ $USE == *"cask"* ]]; then
  echo "cask: $CASK | bash='$0' param1=cask terminal=true"

  if ! [[ $caskLIST == "" ]]; then
    echo "$(echo "$caskLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade pip packages
if [[ -x "$(command -v pip)" ]] && [[ $USE == *"pip"* ]]; then
  echo "pip: $PIP | bash='$0' param1=pip terminal=true"

  if ! [[ $pipLIST == "" ]]; then
    echo "$(echo "$pipLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{for (i=3; i<=NF; i++) print "--"$i}')"
  fi

fi

# option to upgrade npm packages
if [[ -x "$(command -v npm)" ]] && [[ $USE == *"npm"* ]]; then
  echo "npn: $NPM | bash='$0' param1=npm terminal=true"

  if ! [[ $npmLIST == "" ]]; then
    echo "$(echo "$npmLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade yarn packages
if [[ -x "$(command -v yarn)" ]] && [[ $USE == *"yarn"* ]]; then
  echo "yarn: $YARN | bash='$0' param1=yarn terminal=true"

  if ! [[ $yarnLIST == "" ]]; then
    echo "$(echo "$yarnLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade apm packages
if [[ -x "$(command -v apm)" ]] && [[ $USE == *"apm"* ]]; then
  echo "apm: $APM | bash='$0' param1=apm terminal=true"

  if ! [[ $apmLIST == "" ]]; then
    echo "$(echo "$apmLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade gem packages
if [[ -x "$(command -v gem)" ]] && [[ $USE == *"gem"* ]]; then
  echo "gem: $GEM | bash='$0' param1=gem terminal=true"

  if ! [[ $gemLIST == "" ]]; then
    echo "$(echo "$gemLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# option to upgrade MAS packages
if [[ -x "$(command -v mas)" ]] && [[ $USE == *"mas"* ]]; then
  echo "mas: $MAS | bash='$0' param1=mas terminal=true"

  if ! [[ $masLIST == "" ]]; then
    echo "$(echo "$masLIST" | awk 'BEGIN{ RS = "" ; FS = "\n" }{print "--"$0}')"
  fi

fi

# updates all
if [[ "$1" = "all" ]]; then
  brew update && brew upgrade; brew cask upgrade; pipupgrade; npm update; yarn upgrade; apm update && apm upgrade; mas upgrade; sudo gem update
fi

# updates brew
if [[ "$1" = "brew" ]]; then
  brew update && brew upgrade
fi

# updates brew-cask
if [[ "$1" = "cask" ]]; then
  brew cask upgrade
fi

# updates pip
if [[ "$1" = "pip" ]]; then
  pipupgrade
fi

# updates npm
if [[ "$1" = "npm" ]]; then
  npm update
fi

# updates yarn
if [[ "$1" = "yarn" ]]; then
  yarn upgrade
fi

# updates apm
if [[ "$1" = "apm" ]]; then
  apm update && apm upgrade
fi

# updates gem
if [[ "$1" = "gem" ]]; then
  sudo gem update
fi

# updates mas
if [[ "$1" = "mas" ]]; then
  mas upgrade
fi
