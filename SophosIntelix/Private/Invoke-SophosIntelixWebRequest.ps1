function Invoke-SophosIntelixWebRequest {
    [CmdletBinding()]
    param (
        [string]$UriEndpoint,
        [string]$Method = 'Get',
        [hashtable]$Body
    )
    $uri = 'https://' + $SCRIPT:SophosIntelixAuth['DefaultRegion'] + '.api.labs.sophos.com/' + $UriEndpoint
    $accessHeader = Get-SophosIntelixAccessHeader
    if ($null -ne $accessHeader) {
        if ($Method -eq 'Get') {
            Invoke-RestMethod -Uri $uri -Headers $accessHeader
        } elseif ($Method -eq 'Post') {
            Invoke-RestMethod -Uri $uri -Headers $accessHeader -Method Post -Body $Body
        }
    }
}