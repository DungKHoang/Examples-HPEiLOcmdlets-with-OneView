# HPEiLOCmdlets examples: Change user login anme and iLO host name and domain name


## Notes
   * Access iLO from OneView
   * Works only for iLO5 with Authentcation token key. 


## How to get Support
Simple scripts or tools posted on github are provided AS-IS and support is absed on best effort provided by the author. If you encunter problems with the script, please submit an issue 

## Prerequisites
The script requires:
   * the latest OneView PowerShell library on PowerShell gallery
   * the latest HPEiLOCmdelts on PowerShell gallery

  

## To install OneView PowerShell library and HPEiLOCmdlets

```
    install-module HPOneView.500  -scope currentuser
    install-Module HPEiLOcmdlets  -scope currentuser
    

```

## To run in an OneView environment

```
    # ONLY on Gen10 servers
    .\Change-iLO-hostname-username.ps1 -hostname <OV-name> -username <OV-admin> -password <OV-password>

```

    
