[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $FilePath,
    [Parameter()]
    [string]
    $Group,
    [Parameter()]
    [string]
    $PermissionLevel = "modify"
)

try{
    $acl = $acl = (Get-Item $FilePath).GetAccessControl('Access')
    try{
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Group, $PermissionLevel, "Allow")
        $acl.SetAccessRule($AccessRule)
        $acl.SetAccessRuleProtection($true, $false)
        try{
            $acl | Set-Acl $FilePath
            return 0
        }
        catch{
            return "Failed to apply new Access Rule"
        }
    }
    catch{
        return "Failed to create new Access Rule"
    }
}
catch{
    return "Failed to get ACL on provided filepath"
}
