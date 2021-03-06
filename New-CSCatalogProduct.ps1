function New-CSCatalogProduct
{
    [CmdletBinding()]   
	param(
		[parameter(
			Mandatory=$true, 
			ValueFromPipeline=$true
		)]
		[Microsoft.CommerceServer.Catalog.ProductCatalog]
		$Catalog,

		[parameter(
			Mandatory=$true
		)]
		[string]
		$DefinitionName,

		[parameter(
			Mandatory=$true
		)]
		[string]
		$ProductId,

		[string]
		$DisplayName
	)

	$ErrorActionPreference = "Stop"

	$Product = $Catalog.CreateProduct($DefinitionName, $ProductId)

	$HasChanged = $false
	if ($DisplayName -ne $null) {
		$Product.DisplayName = $DisplayName
		$HasChanged = $true
	}
	
	if ($HasChanged) {
		$Product.Save()
	}
	return $Product
}
