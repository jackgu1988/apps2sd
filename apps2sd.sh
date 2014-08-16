#!/bin/bash

function check_adb
{
  # Checks if adb can be found

  path_to_adb=$(which adb)

  if [ ! -f $sdkLocation/platform-tools/adb -a ! -f $sdkLocation/adb -a ! -x $path_to_adb ]
  then
    echo "adb is not installed or you provided a wrong SDK location"
    exit 1
  else
    if [ -f $sdkLocation/platform-tools/adb ]
    then
      location="$sdkLocation/platform-tools/adb"
    elif [ -f $sdkLocation/adb ]
    then
      location="$sdkLocation/adb"
    elif [ -x $path_to_adb ]
    then
      location="$path_to_adb"
    fi
    check_phone_connected $location
  fi
}

function check_phone_connected ()
{
  # Checks if a device is connected

  devices=$($1 devices)
  lines=$(echo "$devices" | wc -l)

  if test $lines -lt 2
  then
    echo "No devices found"
    exit 1
  else
    android_version
    v=$?
    check_status $v $1
  fi
}

function android_version
{
  # Asks the user for the Android version on her phone

  read -p "If you are running Android version >= 4.0 enter 1, else 0: " version

  if test $version -ne 0 -a $version -ne 1
  then
    printf "ERROR! You should input either 0 or 1!\nPlease try again...\n\n"
    android_version
  fi

  return $version
}

function check_status ()
{
  # Checks if mod has already been applied

  echo "Please wait... Checking your phone..."

  if test $1 -eq 1
  then
    output=$($2 shell pm get-install-location)
  else
    output=$($2 shell pm getInstallLocation)
  fi

  current_mode="$(echo $output | head -c 1)"
  current_mode_txt=$(echo $output |cut -d "[" -f2 | cut -d "]" -f1)

  if test $print_n_exit -eq 1
  then
    echo "Your device's current mode is: $(tput setaf 2)$current_mode_txt"
    exit 0
  fi

  if [[ $output == *\[$mode\]* ]]
  then
    echo "The hack has already been applied!"
    echo "Bye!"
    exit 0
  else
    printf "\n\nCurrent mode: $current_mode_txt\n\n"

    echo "Applying the hack... DO NOT DISCONNECT YOUR PHONE OR TURN OFF YOUR COMPUTER!"
    for i in 2 1 0
    do
      apply_hack $1 $2 $i
      r=$?

      if test $r -eq 0
      then
        printf "All done!\nHappy hacking."
        exit 0
      fi
    done

    printf "The hack could not be applied.\nReverting to previous settings..."
    mode=$current_mode_txt
    apply_hack $1 $2 $current_mode
    printf "\nDone."
  fi
}

function apply_hack ()
{
  # Apply the hack

  if test $1 -eq 1
  then
    $($2 shell pm set-install-location $3)
    out=$($2 shell pm get-install-location)
  else
    $($2 shell pm setInstallLocation $3)
    out=$($2 shell pm getInstallLocation)
  fi

  if [[ $out == *\[$mode\]* ]]
  then
    return 0
  fi

  return 1
}

function usage_msg
{
  # Message to be printed in case of wrong usage of arguments

  printf >&2 $"Usage: $0 {-s|-m|-c}\n\nUse $0 --help for help on the arguments"
  exit 1
}

##### Main

help=
sdkLocation=
mode="external"

while [[ $# > 0 ]]; do
  key="$1"
  shift

  case $key in
   -h|--help)
      if test $# -ne 0
      then
        usage_msg
      fi

      echo "$(tput setaf 2)apps2sd"
      echo "=======$(tput sgr0)"
      echo ""
      echo "This script will make your Android device capable of moving apps (that were not movable) to the external SD card."
      echo "$(tput setaf 1)WARNING:$(tput sgr0) apps moved to the external SD card might not sync or work as expected. Use at your own risk."
      echo "Please read this article if you do not know what apps to move https://developer.android.com/guide/topics/data/install-location.html"
      echo ""
      echo "Please also refer to the README (https://github.com/jackgu1988/apps2sd) in order to check the best practises, examples and other info."
      echo ""
      echo "* Use -s <location> in order to set the SDK's absolute path. (Use only if adb is not set as an environment variable)"
      echo "* Use -m <mode> in order to select the default install location. (Available locations: auto, internal, external)"
      echo "* Use -c in order to just print the currently activated mode."
      echo ""
      echo "- Default install location on most phones: auto"
      echo "- Default script behaviour without the -m argument: external"
      echo ""
      echo "License: GPLv3"
      exit 0
      ;;
   -s|--sdk)
      if [ -z "$1" ] || [ $(echo $1 | head -c 1) == "-" ]
      then
        usage_msg
      fi

      sdkLocation="$1"
      ;;
   -m|--mode)
      if [ -z "$1" ] || [ $(echo $1 | head -c 1) == "-" ]
      then
        usage_msg
      fi

      mode="$1"
      if [ $mode != "auto" -a $mode != "external" -a $mode != "internal" ]
      then
        echo "There is no such mode available! Please try again with different arguments..."
        printf "\nAvailable modes:\n* auto\n* internal\n* external"
        exit 1
      fi
      ;;
   -c|--current)
      shift
      print_n_exit=1
      ;;
   *)
      usage_msg
      ;;
  esac
  shift
done

check_adb
