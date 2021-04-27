# PowerShell实战指南（第3版）

# Chpater 2

wow, tab-completion can complete commands/program/path, also args key and value! Also variables!

# Chpater 3

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

1. `Update-Help -UICulture en-US `
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

### tutorial

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
