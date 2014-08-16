apps2sd
=======

Linux script that makes your Android device capable of moving all apps to the external SD card.

...well, all but system apps.

This script will be very useful if your device's internal storage is low and yet not many apps will allow moving to the external storage.

NOTE: many devices do not offer the option to move apps to the SD card by default. You may need to install an app for that. If you search the Play Store you will find many.

# Before use #

Before using the script, make sure that you are familiar with the guidelines described here: https://developer.android.com/guide/topics/data/install-location.html

## Tl;dr ##

~~Avoid moving~~ DO NOT move apps that fall into the following categories:

* Services
* Alarm Services
* Input Method Engines
* Live Wallpapers
* App Widgets
* Account Managers
* Sync Adapters
* Device Administrators
* Broadcast Receivers listening for "boot completed"

# Usage #

You can use this script in order to select the default installation location of your apps (internal or external storage).

After running the script you will be able to move already installed apps to your external SD card. It will not work for system apps though.

Your device's default setting will most probably be set to <code>auto</code>, that means that the device will decide where to install it. Other settings are <code>internal</code> and <code>external</code> storage.

If you run the script without any arguments, the default install location will change to be the <code>external</code> storage. In order to switch to another mode, check the <code>-m</code> argument described below.

## Execution instructions ##

1. Download the script from the git repo
2. cd to the directory (ex <code>cd _some_directory_</code>)
3. Make it executable by running <code>chmod +x apps2sd</code>
4. Run <code>./apps2sd</code> and follow the instructions

## Arguments ##

### -h ###

script help

### -s ###

Android SDK location (or adb location). Ex: <code>./apps2sd -s /opt/android-sdk/</code>

### -m ###

Mode, or where the apps on your phone will be installed by default.

* auto: the phone chooses
* internal: internal storage
* external: external storage

Usage example: <code>./apps2sd -m external</code>