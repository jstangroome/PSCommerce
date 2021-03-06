function Set-CSCatalogPropertyAssignAll
{
    [CmdletBinding()]   
	param(
		[parameter(
			Mandatory=$true, 
			ValueFromPipeline=$true
		)]
		[Microsoft.CommerceServer.Catalog.CatalogContext]
		$Context,

		[parameter(
			Mandatory=$true
		)]
		[string]
		$PropertyName

	)

	$ErrorActionPreference = "Stop"

	$Property = $Context | Get-CSCatalogProperty -Context -Name $PropertyName -ThrowIfNotFound
	if (-not $Property.Information.AssignAll) {
		Write-Debug -Message "Setting AssignAll to True for property '$PropertyName'."
		$Property.Information.AssignAll = $true
		$Property.Save()
	}

	$ProductDefType = [Microsoft.CommerceServer.Catalog.CatalogDefinitionType]"ProductDefinition"
	$Context.GetDefinitions($ProductDefType).CatalogDefinitions |
		ForEach-Object {
			$Context | Add-CSCatalogDefinitionProperty `
				-DefinitionName $_.DefinitionName `
				-PropertyName $PropertyName
		}
}
