function Add-CSCatalogDefinitionProperty 
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
		$DefinitionName,
		
		[parameter(
			Mandatory=$true
		)]
		[string]
		$PropertyName,
		
		[Microsoft.CommerceServer.Catalog.DefinitionPropertyType]
		$DefinitionPropertyType = "NormalProperty"
	)

	$ErrorActionPreference = "Stop"

	$Definition = $Context | Get-CSCatalogDefinition -Name $DefinitionName -ThrowIfNotFound
	$AllDefinitionProperties = $Definition.DefinitionProperties.CatalogDefinitionProperties
	$ShouldAddProperty = $AllDefinitionProperties.Select("[PropertyName]='$PropertyName'").Length -eq 0
	if ($ShouldAddProperty) {
		Write-Debug -Message "Adding property '$PropertyName' to definition '$DefinitionName'."
		$Definition.AddProperty($PropertyName, $DefinitionPropertyType)
		$Definition.Save()
	}
}