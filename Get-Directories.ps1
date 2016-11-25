$Here = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Import-Module "$Here\Common.psm1"

Send-GetRequest ($Endpoint + "/DirectoryEntries")