# Portable App Launcher Collection
 Collection of portable application launcher in PortableApps.com Format.

## What is this?
 This is a repository to collect and manage portable software launchers we make.

 Note that only the launcher will be shared in this repository in the form of source code. Hope this avoids some legal issues.

 We'll set out to portablize software in every field, including open source as well as proprietary.

 We are not warez. No app package will distributed in this repository.

 We didn't crack a software. All authentication steps and the process of assent of EULA will be retained in the software.

## Is this affiliated with the PortableApps.com Team?
 This repository is not affiliated with the PortableApps.com Team.

 We simply collected and organized the application launchers we wrote based on the PortableApps.com format into this repository.

 We understand that we may get into some legal troubles regarding proprietary software, and if anyone's rights are offended, **!!PLEASE CONTACT US!!** instead of PortableApps.com.

## The folder structure of the repository
 The folders in this repository are organized in this way:

 <ROOT>/*Publisher*/*AppName*/(Source codes of the launcher)

 Every folder for the app may contain *appinfo.ini*, *appicon.ico*, launcher file (*〇〇Portable.ini*), *Custom.nsh*, or NSIS scripts (*.nsi).

## Getting started

### Build
 Since we won't be releasing packaged portable apps, users will need to build the launcher themselves.
 Some of our launchers are universal launchers generated using the **PortableApps.com Launcher Generator** (with ***〇〇Portable.ini*** and ***Custom.nsh***),
 and some are native launchers written in the **NSIS** language (with ***〇〇Portable.nsi*** or  ***〇〇PortableU.nsi*** ).

#### Build a universal launcher of the portable app

##### Requirements
 - **[PortableApps.com Launcher Generator](https://portableapps.com/apps/development/portableapps.com_launcher)**
   (download it from [here](https://portableapps.com/apps/development/portableapps.com_launcher)).

 1. Go to the subdirectory of this repository that stores the portable application launcher files you want.
   Download the ***appinfo.ini***, ***appicon.ico***,  ***〇〇Portable.ini*** ,  ***Custom.nsh***  (if any).
   If any of the files are classified as a different version, the file of the same version is selected, if not, the previous version is selected.

 2. Create a directory to place the contents of the portable app.
    The folder name does not affect the build process, but usually we name it "***〇〇Portable***" based on the ***AppID***.

 3. Create an ***App*** directory at the root of the portable app folder.

 4. Open the ***App*** directory, create an *AppInfo* directory under the ***App*** directory.

 5. Open the ***AppInfo*** directory, put ***appinfo.ini*** and ***appicon.ico*** in this directory.

 6. Create a ***Launcher*** directory ***AppInfo*** directory.

 7. Open the ***Launcher*** directory, put ***〇〇Portable.ini***  and  ***Custom.nsh***  (if any) in this directory.

 8. Go back to the root of the portable app folder. Run **PortableApps.com Launcher Generator** and follow the steps to create a launcher, or simply drag the Portable Apps directory to ***PortableApps.comLauncherGenerator.exe*** to create a launcher.

 You need to have the binaries of your app before you run the launcher.
 Put the binaries of your app in the ***App*** directory. Makesure the relative path of your app executable matches with the value of `ProgramExecutable` or `ProgramExecutable64` written in the launcher file ( ***〇〇Portable.ini*** ).

#### Build a native launcher of the portable app

 Although PAL can serve as the portable launcher for most of our software, sometimes, when we deal with some software, PAL cannot meet our needs.

 There are several situations where we need to write our own launcher:
 - The application consists of several sub-applications and each of which needs needs to have its own launcher.
 - The launcher need to deal with path with unicode character. (commonly found in software in the CJK area)
 - Console application.

 Here's how to compile these type of launchers.

##### Requirements
 - **[NSIS](https://nsis.sourceforge.io)** (download from [official site](https://nsis.sourceforge.io/Download), or the portable one from [PortableApps.com](https://portableapps.com/apps/development/nsis_portable). To create a unicode-aware launcher, use [NSIS Portable Unicode](https://portableapps.com/apps/development/nsis_portable_unicode)).

 1. Download NSI script of your portable app from our repository.

 2. Create a directory to place the contents of the portable app.

 3. Create a ***Other*** directory.
    Open the ***Other*** directory,
    create a ***Source*** directory.

 4. Put the NSI script in ***Source*** directory.

 5. Run NSIS, open the script and compile it.

 In root of the portable app folder create a ***App*** directory and put the binaries of the app in the ***App*** directory.

## Contributing
 There are many ways in which you can participate in this project, for example:

 - Help us to test the laucher. Sometimes, although the launcher works, there are some files or registry keys that we ignore and don't collect them back into the Data directory or delete them. Report us if there are any issues.

 - Contribute your portable app launcher.

 To contribute the source code of your app launcher, you can fork the repository, push your changes into it and create an Issue.

 Please add your name to the AUTHORS file to acknowledge your contribution.

 Write down the change, the date, and your name (pseudonym is OK) with email to the CHANGELOG file to help us track it.

 Note that our coding style and conventions are different from the PortableApps.com Team.

 See [the contributing guide](CONTRIBUTING.md) for detailed instructions on how to join our development.

## License
 Not yet decided.
