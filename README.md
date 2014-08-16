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

1. Make sure you have installed ~~the Android SDK and~~ adb (if not follow this link: https://developer.android.com/sdk/index.html).
Also make sure that your OS contains the <code>udev</code> rules required (else follow this: https://github.com/M0Rf30/android-udev-rules).
2. Download the script from the git repo
3. cd to the directory (ex <code>cd _some_directory_</code>)
4. Make it executable by running <code>chmod +x apps2sd</code>
5. Enable USB debugging on your device (instructions: https://developer.android.com/tools/device.html) and then connect it to your computer
6. Run <code>./apps2sd.sh</code> and follow the instructions

## Arguments ##

### -h ###

Script help

### -s ###

Android SDK location (or adb location). Ex: <code>./apps2sd.sh -s /opt/android-sdk/</code>

### -m ###

Mode, or where the apps on your phone will be installed by default.

* auto: the phone chooses
* internal: internal storage
* external: external storage

Usage example: <code>./apps2sd.sh -m external</code>

### -c ###

Prints the currently used mode and exits.

Usage example: <code>./apps2sd.sh -c</code>

## Examples ##

* <code>./apps2sd.sh</code>
Sets the app install location to external storage (default script behaviour).

* <code>./apps2sd.sh -s /opt/android-sdk/</code>
Sets the app install location to external storage (default script behaviour). <code>-s</code> argument in case the SDK's/adb directory is not set as an environment variable.

* <code>./apps2sd.sh -m auto -s /opt/android-sdk/</code>
Sets the app install location to auto (default for most devices).

* <code>./apps2sd.sh -c -s /opt/android-sdk/</code>
Prints the current mode. In this occasion the SDK is located at <code>/opt/android-sdk/</code>.

* <code>./apps2sd.sh --help</code>
Script help (although this guide provides much more details).