![Logo of the project](https://raw.githubusercontent.com/tswearingen/FactoryTalk-Repair-Tool/master/Full-Dark.png)

# FactoryTalk View Studio Repair Tool
> FactoryTalk View Studio is a registered trademark of Rockwell Automation. </br>
Windows is a registerd trademark of Microsoft Corporation.

FactoryTalk View Studio is a HMI design environment by Rockwell Automation. FactoryTalk depends on a variety of separate programs and services to operate properly. Numerous thing may cause these services to stop interacting as designed.

This tool is a Windows Powershell script designed to correct some common issues without requiring the user to restart the software or reboot the computer.

## Getting started

The `FactoryTalk Repair Tool.ps1` file is executed in a PowerShell environment. This file may be placed in the desired location and executed from the right-click context menu by selecting "Run in PowerShell".

A PowerShell terminal will open momentarily, close, and then re-open. This is intended behavior as the script attempts to elevate to administrator privileges. This privilege escallation is requred because the script attempts to interact with Windows services.

In order for this to function correctly, the user must be a member of the local administrator group or have access to an administrator account.

### Initial Configuration

The first time this script is executed, the user may encounter the following prompt:

```
Execution Policy Change
The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose you to the security risks described in the about_Execution_Policies help topic at https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
```
You must change the execution policy in order to use this script, however the user is responsible for understanding the security implications of this action and should not use this script if doing so is deemed to present unacceptable risk.

## Change Log

v0.1.0
* Initial version (Alpha)
* Added ability to correct Factorytalk Activation Helper error.
* Added ability to correct personalized information error.

## Links

Repository: https://github.com/tswearingen/FactoryTalk-Repair-Tool </br>
Issue tracker: https://github.com/tswearingen/FactoryTalk-Repair-Tool/issues

In case of sensitive bugs like security vulnerabilities, please contact TSwearingen@alassystems.com directly instead of using issue tracker. We value your effort to improve the security and privacy of this project!

## Licensing

Copyright (C) 2021  ALAS System Inc

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
