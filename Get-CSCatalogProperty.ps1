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

		filter Augment-CSCatalogProperty () {
			$Property = $_
			if ($Property -ne $null) {
				$Info = $Property.PSBase.Information.CatalogProperties[0]
				$Property | 
					Add-Member -MemberType NoteProperty -Name Information -Value $Info -Force
			}
			$Property
		}
	
		try {
			return $Context.GetProperty($Name) | Augment-CSCatalogProperty
		} catch [Microsoft.CommerceServer.EntityDoesNotExistException] {
			if ($ThrowIfNotFound) { throw }
		}
	}
}