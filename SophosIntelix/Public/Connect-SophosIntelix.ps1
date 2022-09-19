function Connect-SophosIntelix {
    <#
    .SYNOPSIS
        Connect to Sophos Intelix
    .DESCRIPTION
        Connect to Sophos Intelix

        To create a client id/client secret follow the guide below. The is a paid service from Sophos and requires a AWS account.
        https://api.labs.sophos.com/doc/index.html#registration-howto
    .PARAMETER ClientID
        The client ID from the Sophos Central API credential/service principal
    .PARAMETER ClientSecret
        The client secret from the Sophos Central API credential/service principal
    .EXAMPLE
        Connect-SophosIntelix -ClientID "asdkjsdfksjdf" -ClientSecret (Read-Host -AsSecureString -Prompt "Client Secret:")
    .LINK
        https://api.labs.sophos.com/doc/authentication.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'StdAuth')]
        [ValidateNotNullOrEmpty]
        [String]$ClientID,

        [Parameter(Mandatory = $true, ParameterSetName = 'StdAuth')]
        [ValidateNotNullOrEmpty]
        [SecureString]$ClientSecret,

        [ValidateSet('us', 'de')]
        [string]$DefaultRegion = 'us'
    )

    $authHeader = Get-SophosIntelixAuthHeader -ClientID $ClientID -ClientSecret $ClientSecret
    $body = @{
        grant_type = 'client_credentials'
    }

    $authInfo = Invoke-RestMethod -Uri 'https://api.labs.sophos.com/oauth2/token' -Method Post -ContentType 'application/x-www-form-urlencoded' -Body $body -Headers $authHeader
  
    if ($null -ne $authInfo) {
        $auth = @{
            ClientID      = $ClientID
            ClientSecret  = $ClientSecret
            AccessToken   = $authInfo.access_token
            ExpiresIn     = $authInfo.expires_in
            ExpiresAt     = (Get-Date).AddSeconds($authInfo.expires_in)
            TokenType     = $authInfo.token_type
            DefaultRegion = $DefaultRegion
        }
        
        $SCRIPT:SophosIntelixAuth = $auth
    }
}
