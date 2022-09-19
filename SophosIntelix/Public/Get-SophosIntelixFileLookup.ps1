function Get-SophosIntelixFileLookup {
    [CmdletBinding()]
    param (
        [string]$FileHash
    )

    $uriEndpoint = 'lookup/files/v1/' + $FileHash
    Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint -Verbose:$Verbose
}