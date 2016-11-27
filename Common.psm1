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

function Get-SessionToken($EmailAddress, $Password)
{
    $JSON = @{ EmailAddress = $EmailAddress; Password = $Password; }

    return Invoke-RestMethod `
        -Uri ($Endpoint + "/Session") `
        -Method Post `
        -ContentType $Accepts `
        -Headers @{ Accepts = $Accepts; } `
        -Body (ConvertTo-Json $JSON)
}

Export-ModuleMember -Function @('Get-SessionToken', 'Send-GetRequest', 'Send-PostRequest') -Variable @('Endpoint', 'Accepts')