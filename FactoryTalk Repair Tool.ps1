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

 Get_Action
