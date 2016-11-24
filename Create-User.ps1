param(
    $EmailAddress = 'mattgwagner@gmail.com',
    $Password
)

$Here = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Import-Module Common

$CreateUri = $Endpoint + "/User"

$Body = ConvertTo-Json @{ EmailAddress = $EmailAddress; Password = $Password }

Invoke-RestMethod `
    -uri $CreateUri `
    -method Post `
    -ContentType $Accepts `
    -Headers @{ Accepts = $Accepts } `
    -Body $Body