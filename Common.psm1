$Endpoint = "https://my.rpsins.com/resume/api"

$Accepts = "application/json"

function Send-GetRequest($Uri)
{
    $SessionToken = Get-SessionToken

    return Invoke-RestMethod `
        -Uri $Uri `
        -Method Get `
        -ContentType $Accepts `
        -Headers @{ Accepts = $Accepts; Authentication = $SessionToken; }
}

function Send-PostRequest($Uri, $Body)
{
    $SessionToken = Get-SessionToken

    return Invoke-RestMethod `
        -Uri $Uri `
        -Method Post `
        -ContentType $Accepts `
        -Headers @{ Accepts = $Accepts; Authentication = $SessionToken; } `
        -Body (ConvertTo-Json $Body)
}

function Get-SessionToken
{
    if(!$Global:SessionToken)
    {
        $Creds = Get-Credential
        
        $JSON = @{ EmailAddress = $Creds.UserName; Password = $Creds.GetNetworkCredential().Password; }

        $Response = Invoke-RestMethod `
            -Uri ($Endpoint + "/Session") `
            -Method Post `
            -ContentType $Accepts `
            -Headers @{ Accepts = $Accepts; } `
            -Body (ConvertTo-Json $JSON)

            # TODO Handle session expiration

        $Global:SessionToken = $Response.SessionCypher;
    }

    return $Global:SessionToken;
}

Export-ModuleMember -Function @('Get-SessionToken', 'Send-GetRequest', 'Send-PostRequest') -Variable @('Endpoint', 'Accepts')