$Endpoint = "https://my.rpsins.com/resume/api"

$Accepts = "application/json"

function Send-GetRequest($Uri)
{
    $SessionToken = Get-SessionToken

    return Invoke-RestMethod `
        -Uri $CreateUri `
        -Method Get `
        -ContentType $Accepts `
        -Headers @{ Accepts = $Accepts; Authentication = $SessionToken; }
}

function Send-PostRequest($Uri, $Body)
{
    $SessionToken = Get-SessionToken

    return Invoke-RestMethod `
        -Uri $CreateUri `
        -Method Post `
        -ContentType $Accepts `
        -Headers @{ Accepts = $Accepts; Authentication = $SessionToken; } `
        -Body (ConvertTo-Json $Body)
}

function Get-SessionToken
{
	$Creds = Get-Credential

    $JSON = @{ EmailAddress = $Creds.UserName; Password = $Creds.GetNetworkCredential().Password; }

    $Response = Send-PostRequest -Uri ($Endpoint + "/Session") -Body $JSON

    return $Response
}

Export-ModuleMember -Function @('Get-SessionToken', 'Send-GetRequest', 'Send-PostRequest') -Variable @('Endpoint', 'Accepts')