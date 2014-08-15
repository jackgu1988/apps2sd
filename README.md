apps2sd
=======

Let your Android phone move apps that are not movable, to the SD card.

Usage
=====

1. Download the script from the git repo
2. cd to the directory (ex <code>cd _some_directory_</code>)
3. Make it executable by running <code>chmod +x apps2sd</code>
4. Run <code>./apps2sd</code> and follow the instructions

## Arguments ##

### -h ###

script help

### -s ###

Android SDK location (or adb location). Ex: <code>./apps2sd -s /opt/android-sdk/ </code>

### -m ###

Mode, or where the apps on your phone will be installed by default.

* auto: the phone chooses
* internal: internal storage
* external: external storage

Usage example: <code>./apps2sd -m external</code>