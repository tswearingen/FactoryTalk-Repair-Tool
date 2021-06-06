# Copyright (C) 2021  ALAS System Inc

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.

#Get the action to take
Function Get_Action {
  # Create prompt body
  $title = "Choose Action"
  $message = "Which error do you want to fix?"
  
  # Create answers
  $fixActivation = New-Object System.Management.Automation.Host.ChoiceDescription "FT&Helper", "FactoryTalk Activation Helper service not running."
  $fixPersoalizedInfo = New-Object System.Management.Automation.Host.ChoiceDescription "&Personalized Information","This software requires personalized informaiton that cannot be read."
  $none = New-Object System.Management.Automation.Host.ChoiceDescription "E&xit", "Exit this session."
  
  # Create ChoiceDescription with answers
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($fixActivation, $fixPersoalizedInfo, $none)

  # Show prompt and save user's answer to variable
  $response = $host.UI.PromptForChoice($title, $message, $options, 0)

  # Perform action based on answer
  switch ($response) {
    0 {
      Write-Host 'Attempting to fix FactoryTalk Activation Helper.'
      $svc = Get-Service -Name 'FTActivationBoost' -ErrorAction SilentlyContinue
      Manage_Svc($svc)
      break
    }
    1 {
      Write-Host 'Attempting to fix Personalized Information error.'
      $svc = Get-Service -Name 'FTViewServiceHost' -ErrorAction SilentlyContinue
      Manage_Svc($svc)
      break
    }
    2 {
      Exit
    }
  }
}

Function Manage_Svc {
  switch ($svc.Status) {
    'running' {
      Write-Host 'Restarting'($svc.DisplayName)'...'
      Restart-Service $svc
      Exit_Session
    }
    'stopped' {
      Write-Host 'Starting' $svc.DisplayName'...'
      Start-Service $svc
      Exit_Session
    }
    default {
      Write-Host 'Factorytalk View Studio is not installed on your computer.' -ForegroundColor Red
      Exit_Session
    }
  }
}

#Exit the Powershell session
Function Exit_Session {
  Write-Host -NoNewline -Object 'Press any key to exit...' -ForegroundColor Yellow
  $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
  Exit
}

#
# This is the program entry point
#

# Re-open Powershell with elevated PowerShell instance
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
  exit;
}

Write-Host "Copyright (C) 2021  ALAS Systems Inc
This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
This is free software, and you are welcome to redistribute it
under certain conditions; type `show c' for details."

 Get_Action
