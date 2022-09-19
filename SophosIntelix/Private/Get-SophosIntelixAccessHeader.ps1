function Get-SophosIntelixAccessHeader {

    if ($null -ne $SCRIPT:SophosIntelixAuth['AccessToken']) {
        if ($SCRIPT:SophosIntelixAuth.ExpiresAt -le (Get-Date)) {
            Connect-SophosIntelix -ClientID $SCRIPT:SophosIntelixAuth.ClientID -ClientSecret $SCRIPT:SophosIntelixAuth.ClientSecret
        }

        $access = @{
            Authorization      = $SCRIPT:SophosIntelixAuth['AccessToken']
            'X-Correlation-ID' = (New-Guid).Guid
        }
        $access
    } else {
        throw 'Login using Connect-SophosIntelix'
    }
}