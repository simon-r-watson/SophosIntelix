function Get-SophosIntelixFileLookup {
    <#
    .SYNOPSIS
        
    .DESCRIPTION

    .PARAMETER Url
        Url you want to look up
    .EXAMPLE
        Get-SophosIntelixFileLookup -FileHash CF19F79B8EE6BC1C83438EA8F6D266496681F686CC87BF1D295126621700A1EB
    .EXAMPLE
        Get-ChildItem -Path "$($env:userprofile)\Downloads" -Filter "*.exe" -Recurse | Get-SophosIntelixFileLookup
    .LINK
        https://api.labs.sophos.com/doc/lookup/files.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'By File Hash')]
        [ValidateNotNullOrEmpty()]
        [string[]]$FileHash,

        [Parameter(Mandatory = $true, ParameterSetName = 'By File Path', ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if (-not (Test-Path -Path $_ -PathType Leaf)) {
                    throw 'File does not exist'
                }
                return $true
            })]
        [Alias('FullName')]
        [System.IO.FileInfo[]]$FilePath
    )

    begin {
        $FileHashList = New-Object System.Collections.Generic.List[PSCustomObject]
    }
    
    process {
        if ($null -ne $FileHash) {
            foreach ($hash in $FileHash) {
                $hashTemp = New-FileHashTable -FileHash $hash -FilePath $null
                $FileHashList.Add([PSCustomObject]$hashTemp)
            }
        }

        if ($null -ne $FilePath) {
            $FileHashList = New-Object System.Collections.Generic.List[PSCustomObject]
            foreach ($file in $FilePath) {
                $hash = (Get-FileHash -Path $FilePath.FullName -Algorithm SHA256).Hash
                $hashTemp = New-FileHashTable -FileHash $hash -FilePath $FilePath.FullName
                $FileHashList.Add([PSCustomObject]$hashTemp)
            }
        }

        foreach ($hashL in $FileHashList) {
            $uriEndpoint = 'lookup/files/v1/' + $hashL.FileHash
            $fileInfo = Invoke-SophosIntelixWebRequest -UriEndpoint $uriEndpoint
            if ($fileInfo.reputationScore) { $hashL.ReputationScore = $fileInfo.reputationScore }
            if ($fileInfo.requestId) { $hashL.RequestId = $fileInfo.requestId }
            if ($fileInfo.ttl) { $hashL.Ttl = $fileInfo.ttl }

            $hashL
        }
        
    }
}