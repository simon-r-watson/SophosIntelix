function Get-SophosIntelixFileLookup {
    <#
    .SYNOPSIS
        
    .DESCRIPTION

    .PARAMETER Url
        Url you want to look up
    .EXAMPLE
        Get-SophosIntelixFileLookup -FileHash CF19F79B8EE6BC1C83438EA8F6D266496681F686CC87BF1D295126621700A1EB
    .LINK
        https://api.labs.sophos.com/doc/lookup/files.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty]
        [string]$FileHash
    )

    $uriEndpoint = 'lookup/files/v1/' + $FileHash
    Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint
}