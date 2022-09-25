function New-FileHashTable {
    [CmdletBinding()]
    param (
        $FileHash,
        $FilePath
    )
    $hash = @{
        FileHash        = $FileHash
        FilePath        = $FilePath
        ReputationScore = $null
        RequestId       = $null
        Ttl             = $null
    }
    $hash
}