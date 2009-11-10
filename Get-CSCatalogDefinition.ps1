function Get-CSCatalogDefinition
{
    [CmdletBinding(DefaultParameterSetName="Name")]
	param(
		[parameter(
			Mandatory=$true, 
			ValueFromPipeline=$true
		)]
		[Microsoft.CommerceServer.Catalog.CatalogContext]
		$Context,

		[parameter(
			ParameterSetName="Name",
			Mandatory=$true
		)]
		[string]
		$Name,
		
		[parameter(
			ParameterSetName="Name"
		)]
		[switch]
		$ThrowIfNotFound,
		
		[parameter(
			ParameterSetName="Type",
			Mandatory=$true
		)]
		[Microsoft.CommerceServer.Catalog.CatalogDefinitionType]
		$DefinitionType
	)

	$ErrorActionPreference = "Stop"
	
	switch ($PSCmdlet.ParameterSetName) {
		Name {
			try {
				return $Context.GetDefinition($Name)
			} catch [Microsoft.CommerceServer.EntityDoesNotExistException] {
				if ($ThrowIfNotFound) { throw }
			}
		}
		Type {
			$Context.GetDefinitions($DefinitionType).CatalogDefinitions
		}
	}
}
