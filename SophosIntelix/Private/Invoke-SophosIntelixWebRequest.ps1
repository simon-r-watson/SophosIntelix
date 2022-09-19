function Invoke-SophosIntelixWebRequest {
    [CmdletBinding()]
    param (
        [string]$UriEndpoint
    )
    $uri = 'https://' + $SCRIPT:SophosIntelixAuth['DefaultRegion'] + '.api.labs.sophos.com/' + $UriEndpoint
    $accessHeader = Get-SophosIntelixAccessHeader
    if ($null -ne $accessHeader) {
        Invoke-RestMethod -Uri $uri -Headers $accessHeader -Verbose:$Verbose
    }
}