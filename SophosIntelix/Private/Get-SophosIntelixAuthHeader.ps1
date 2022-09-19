function Get-SophosIntelixAuthHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'StdAuth')]
        [String]$ClientID,

        [Parameter(ParameterSetName = 'StdAuth')]
        [SecureString]$ClientSecret
    )

    $authString = $ClientID + ':' + (Unprotect-Secret -Secret $ClientSecret)
    $authHeader = @{
        Authorization = 'Basic ' + (ConvertTo-Base64String -String $authString)
    }
    $authHeader
}