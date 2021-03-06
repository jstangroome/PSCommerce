function New-CSCatalogBaseCatalog
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
		
		[parameter(
			Mandatory=$true
		)]
		[string]
		$ProductIdProperty,
		
		[string]
		$VariantIdProperty,
		
		[string]
		$DefaultLanguage = [System.Globalization.CultureInfo]::CurrentCulture.Name,

		[string]
		$ReportingLanguage = $DefaultLanguage
	)

    end
    {
		return $Context.CreateBaseCatalog(
			$Name,
			$ProductIdProperty,
			$VariantIdProperty,
			$DefaultLanguage,
			$ReportingLanguage
		)
	}
}