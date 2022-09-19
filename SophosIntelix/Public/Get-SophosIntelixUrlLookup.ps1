function Get-SophosIntelixUrlLookup {
    [CmdletBinding()]
    param (
        [string]$Url
    )

    $replaceHash = @{
        '/' = '%2F'
        ':' = '%3A'
    }
    foreach ($key in $replaceHash.key) {
        $url = $url.Replace($key, $replaceHash[$key])
    }
    Write-Verbose $url
    $uriEndpoint = 'lookup/urls/v1/' + $url
    Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint -Verbose:$Verbose
}