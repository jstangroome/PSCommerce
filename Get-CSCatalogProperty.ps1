function Get-CSCatalogProperty
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
		$Name,
		
		[switch]
		$ThrowIfNotFound
	)

    process
    {
		$ErrorActionPreference = "Stop"

		try {
			return $Context.GetProperty($Name)
		} catch [Microsoft.CommerceServer.EntityDoesNotExistException] {
			if ($ThrowIfNotFound) { throw }
		}
	}
}