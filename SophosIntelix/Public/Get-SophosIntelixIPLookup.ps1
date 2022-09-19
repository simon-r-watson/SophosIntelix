function Get-SophosIntelixIPLookup {
    <#
    .SYNOPSIS
        
    .DESCRIPTION

    .PARAMETER IPAddress
        IP Address you want to look up
    .EXAMPLE
        Get-SophosIntelixIPLookup -IPAddress 1.1.1.1
    .LINK
        https://api.labs.sophos.com/doc/lookup/ips.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty]
        [System.Net.IPAddress]$IPAddress
    )

    $uriEndpoint = 'lookup/ip/v1/' + $IPAddress.IPAddressToString
    Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint -Verbose:$Verbose
}