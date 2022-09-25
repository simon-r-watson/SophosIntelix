function Get-SophosIntelixUrlLookup {
    <#
    .SYNOPSIS
        
    .DESCRIPTION

    .PARAMETER FileHash
        SHA256 hash of the file you want to look up.
    .EXAMPLE
        Get-SophosIntelixUrlLookup -Url www.google.com
    .LINK
        https://api.labs.sophos.com/doc/lookup/urls.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url
    )

    $replaceHash = @{
        '/' = '%2F'
        ':' = '%3A'
    }
    foreach ($key in $replaceHash.key) {
        $url = $url.Replace($key, $replaceHash[$key])
    }

    $uriEndpoint = 'lookup/urls/v1/' + $url
    Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint
}