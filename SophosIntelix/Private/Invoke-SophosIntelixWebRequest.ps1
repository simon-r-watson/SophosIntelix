function Invoke-SophosIntelixWebRequest {
    [CmdletBinding()]
    param (
        [string]$UriEndpoint
    )
    $uri = 'https://' + $SCRIPT:SophosIntelixAuth['DefaultRegion'] + '.api.labs.sophos.com/' + $UriEndpoint
    $accessHeader = Get-SophosIntelixAccessHeader
    Invoke-RestMethod -Uri $uri -Headers $accessHeader -Verbose:$Verbose
}