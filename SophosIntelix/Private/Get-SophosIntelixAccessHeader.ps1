function Get-SophosIntelixAccessHeader {
    $access = @{
        Authorization      = $SCRIPT:SophosIntelixAuth['AccessToken']
        'X-Correlation-ID' = (New-Guid).Guid
    }
    $access
}