function Get-CSCatalogProduct
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
		$ProductId,
		
		[switch]
		$ThrowIfNotFound
	)

	$ErrorActionPreference = "Stop"

	try {
		return $Catalog.GetProduct($ProductId)
	} catch [Microsoft.CommerceServer.EntityDoesNotExistException] {
		if ($ThrowIfNotFound) { throw }
	}
}
