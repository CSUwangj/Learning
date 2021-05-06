# PowerShell实战指南（第3版）

## Chapter 2

wow, tab-completion can complete commands/program/path, also args key and value! Also variables!

## Chapter 3

wildcard\(\*\) is ok for powershell `Help`

powershell has something called [Position argument](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.1#position-argument)

use `Help about_Common` will list common parameters, there are

- DEBUG (db)
- ERRORACTION (ea)
- ERRORVARIABLE (ev)
- INFORMATIONACTION (infa)
- INFORMATIONVARIABLE (iv)
- OUTVARIABLE (ov)
- OUTBUFFER (ob)
- PIPELINEVARIABLE (pv)
- VERBOSE (vb)
- WARNINGACTION (wa)
- WARNINGVARIABLE (wv)

### hands on

1. `Update-Help -UICulture en-US`
2. `help convert` then found `ConvertTo-Html`, manual written `You can use this cmdlet to display the output of a command in a Web page.`
3. `help redirect` found `Out-File`, `help printer` found `Out-Printer`
4. operating process can be done with `Debug-Process`, `Start-process`, `Stop-Process`, `Wait-Process`
5. can not found it, maybe because I'm PowerShell7.1 on Windows10?
6. `help alias` found `New-Alias`, `Import-Alias`, `Remove-Alias`, `Set-Alias`, `Export-Alias`, `Get-Alias`
7. use `Start-Transcript` and `Stop-Transcript` I guess.
8. same as 5
9. use `Get-Service` with remote commands in PowerShell?
10. same as 9?
11. `-Width`, ` If this parameter is not used, the width is determined by the characteristics of the host. The default for the PowerShell console is 80 characters.`
12.  `-NoClobber`
13.  `Get-Alias`
14.  don't know...
15.  don't know...
16.  `help array`

### answer

1. yes
2. `help html` or `get-command -noun html`
3. `get-command -noun file,printer`
4. yes
5. `Get-Command -verb write -noun eventLog`, can use wildcard at noun.
6. yes
7. yes
8. My powershell don't actually have `Get-EventLog`
9. `No parameter matches criteria computername.`
10. `No parameter matches criteria computername.`
11. yes
12. yes
13. yes
14. `A parameter cannot be found that matches parameter name 'c'.`
15. `get-command -noun object`
16. yes

## Chapter 4

alias won't include any predifined parameters.

use `Show-Command` to get help with gui

use `--%` after external command name tell powershell not parse command but send to CMD.exe directly.(seems fixed at powershell7)

### hands on

1. `Get-Process`
2. can not find it
3. `get-command -CommandType Cmdlet`
4. `Get-Alias`
5. `New-Alias -Name "np" notepad`
6. `Get-Service -Name "M*"`
7. `Show-NetFirewallRule`
8. can not find it

## Chapter 5

### hands on

1. `Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "DibtOrettyPath" -Value 0`
2. `mkdir C:\Labs`
3. `New-Item C:\Labs\Test.txt -ItemType File`
4. 
   1. `Set-Item C:\Labs\Test.txt "TESTING"` then got `Set-Item : Provider operation stopped because the provider does not support this operation.` 
   2. read the help and got ``To change the values of items in   the file system, use the `Set-Content` cmdle`` so use `Set-Content C:\Labs\Test.txt TESTING`
5. `Get-Item Env:TEMP`
6. here's difference
   1. `-Filter`: The provider applies filter when the cmdlet gets the objects rather than having PowerShell filter the objects after they're retrieved. 
   2. `-Include`: When the Include parameter is used, the Path parameter needs a trailing asterisk (`*`) wildcard to specify the directory's contents. For example, `-Path C:\Test*`.
   3. `-Exclude`:   When the Exclude parameter is used, a trailing asterisk (` `) in the Path * parameter is optional. For example, `-Path C:\Test\Logs` or `-Path C:\Test\Logs*`.

### answer

1. yes
2. yes
3. yes
4. yes
5. and `dir env:temp`
6. 
   1. `-Include` and `-Exclude` must use with `-Recurse` parameter
      - (not mentioned in my help manual, maybe it's outdated?)
      - \[yes, it's outdated\]
   2. yes, and `The FileSystem (../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)provider is the only installed PowerShell provider that supports filters. Filters are more efficient than other parameters.` so it's not for all PSProviders.

## Chapter 6

### hands on

1. see below

``` powershell
PS C:\Users\X> cat tt
test
PS C:\Users\X> cat t
Test
PS C:\Users\X> diff -ReferenceObject (Get-Content .\t) -DifferenceObject (Get-Content .\tt)
PS C:\Users\X> 
```

``` powershell
PS C:\Users\X> echo testt > tt
PS C:\Users\X> cat .\tt
testt
PS C:\Users\X> diff -ReferenceObject (Get-Content .\t) -DifferenceObject (Get-Content .\tt)

InputObject SideIndicator
----------- -------------
testt       =>
Test        <=
```

2. `Out-File : Cannot process argument because the value of argument "path" is null. Change the value of argument "path" to a non-null value.`
3. `-Name`
4. `-Delimiter "|"` 
5. export and import with `-NoTypeInformation`?
6. `-NoClobber`, `-Confirm`
7. `-UseCulture`

## Chapter 7

powershell has almost the same functionality as MMC(doubt if it's true for powershell7)

there is only one powershell, but several shortcuts of powershell with different import-module.

there used to be particular shell for `SQL Server` called `mini-shell`, but removed since `SQL Server 2012`

there used to be PSSnapin for module, but it was removed in powershell core.

Damn! I found `Get-EventLog` in my windows powershell...

auto completion/hint can be done without import module, wow

### hands on

I have no idea what to do... google and found `Test-NetConnection` but not expected answer

### answer

``` powershell
❯ Get-Module *trouble* -list


    Directory: C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0.0.0    TroubleshootingPack                 {Get-TroubleshootingPack, Invoke-TroubleshootingPack}


❯ Import-Module TroubleshootingPack
 Thinker-Z@Thinker-Z  ~ 
❯ Get-Command -Module TroubleshootingPack

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-TroubleshootingPack                            1.0.0.0    TroubleshootingPack
Cmdlet          Invoke-TroubleshootingPack                         1.0.0.0    TroubleshootingPack


 Thinker-Z@Thinker-Z  ~  
❯ $pack=Get-TroubleshootingPack

cmdlet Get-TroubleshootingPack at command pipeline position 1
Supply values for the following parameters:
Path: C:\windows\diagnostics\system\networking
 Thinker-Z@Thinker-Z  ~ 
❯ Invoke-TroubleshootingPack $pack
Starting network diagnostics...  -1

Instance ID
Not to be specified outside of MSDT application.
:


Select entry point
Please select the entry point for Network Diagnostics.

[1] Web Connectivity
[2] File Sharing
[3] Network Adapter
[4] Winsock Connectivity
[5] Grouping
[6] Inbound
[7] DirectAccess
[8] DefaultConnectivity
[9] Reserved

[?] Help
[x] Exit
:1


Please select the issue Windows should troubleshoot

[1] Troubleshoot my connection to the Internet
[2] Help me connect to a specific web page

[?] Help
[x] Exit
:2

Enter the address of the website you want to access
For example, http://www.microsoft.com.
:http://www.pluralsight.com/browse/it-ops
Looking for problems...  -1
正在查看 Web 连接 中的问题...  -1
Collecting results...  -1
   -1
Collecting configuration details...  -1
   -1

No problems were detected
```

## Chapter 8

powershell has Extended Type System that's capable of adding more useful properties on objects, but for us now these extended properties act as normal property.

use method is more about .NET programming.

### hands on

1. `Get-Random`
2. `Get-Date`
3. `System.DateTime`
4. `Get-Date | select DayOfWeek`
5. `Get-HotFix`
6. `Get-HotFix | sort InstalledOn | select InstalledOn, HotFixID, InstalledBy`, wondering why InstallDate is empty
7. `Get-HotFix | sort Description | select Description, HotFixID, InstalledBy | ConvertTo-Html | Out-File hotfix.Html`
8. `Get-EventLog -LogName Security -Newest 50 | sort TimeGenerated, Index | select Index, TimeGenerated, Source | Out-File eventlog.txt`

### answer

1. yes
2. yes
3. yes
4. yes
5. yes
6. yes
7. yes
8. yes

## Chapter 9

pipeline `ByValue` and `ByPropertyName`, can check help for details.

use `(cmd)` in powershell act as `` `cmd` `` in linux

use `-ExpandProperty` to "unbox" properties

### assignment

1. yes, use `-expand` get `System.String`
2. no, because `Get-HotFix` need `ComputerName`
3. yes, pipeline by property name
4. `Get-ADComputer -Filter * | Select-Object @{l='ComputerName';e={$_.Name}} | Get-Process`
5. `Get-Service -ComputerName (Get-ADComputer -Filter * | Select-Object -Expand Name)`
6. no, found `Get-WmiObject` has no parameters accept pipeline input.

### answer

1. yes
2. yes
3. yes
4. yes
5. yes
6. yes

### answer

## Review hands on

### Chapter 1~6

1. can not found suitable command
2. see below:
``` powershell
Get-Process | Sort-Object VM -Descending | Select-Object -First 5 | Format-Table `
        @{Label = "NPM(K)"; Expression = {[int]($_.NPM / 1024)}},
        @{Label = "PM(K)"; Expression = {[int]($_.PM / 1024)}},
        @{Label = "WS(K)"; Expression = {[int]($_.WS / 1024)}},
        @{Label = "VM(M)"; Expression = {[int]($_.VM / 1MB)}},
        @{Label = "CPU(s)"; Expression = {if ($_.CPU) {$_.CPU.ToString("N")}}},
        Id, MachineName, ProcessName -AutoSize`

NPM(K)  PM(K)  WS(K)   VM(M) CPU(s)    Id MachineName ProcessName
------  -----  -----   ----- ------    -- ----------- -----------
    18  58880  60744 2218466 132.08 23916 .           chrome
    22  83956  64684 2212316 40.73  22924 .           chrome
    38 166496 127552 2208309 167.02 16892 .           chrome
    35 120560 120940 2204229 72.20   2960 .           chrome
    22 116656 155276 2204226 11.06  19556 .           chrome
```

3. `Get-Service | Select-Object Name,Status | Sort-Object Status -Descending | Export-Csv test.csv`
4. `Set-Service -Name BITS -StartupType Automatic`
5. `Get-ChildItem -Path C:\* -Recurse -Include Win*.*`
6. `dir -Attributes D c:\ > c:\dir.txt`
7. same as 1
8. `Get-Service | Export-Csv C:\services.csv`
9. `Get-Service | select Name,DisplayName,StartType | ConvertTo-Html -PreContent "<h1>Installed Services</h1>" > services.html`
10. see below

``` powershell
New-Alias -Name tt -Value Get-ChildItem

Export-Alias t -Name tt
Import-Alias .\t
```

11. same as 1
12. `pwd` or `Get-Location`
13. `Get-History`, then don't know
14. same as 1
15. `New-Item -ItemType Directory C:\Review`
16. `Get-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\'`
17. :
    1.  `Restart-Computer`
    2.  `Stop-Computer`
    3.  `Remove-LocalGroupMember` I guess
    4.  can not found
18. `Set-ItemProperty`

### answer for 1~6

1. yeah, `Get-EventLog` again
2. yes
3. yes
4. yes
5. yes
6. yes'yes
7. same as 1
8. same as 1
9. yes
10. yes, BTW it's not XML in powershell7 nor in my windows powershell, it's CSV
11. `Get-HotFix -Description "Update","Hotfix"`
12. yes
13. `Get-History -id x | Invoke-History`
14. same as 1
15. yes
16. yes
17. :
    1.  yes
    2.  yes
    3.  removed
    4.  removed
18. yes
