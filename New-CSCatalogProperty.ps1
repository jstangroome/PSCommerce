function New-CSCatalogProperty
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
		[Microsoft.CommerceServer.Catalog.CatalogDataType]
		$DataType = "String",
		
		[int]
		$MaxLength = 0,
		
		[switch]
		$AssignAll,
		
		[switch]
		$DisplayInProductsList,
		
		[switch]
		$IsRequired,
		
		[switch]
		$DisplayAsBaseProperty,
		
		$DefaultValue,

		[string]
		$DisplayName
	)

	$ErrorActionPreference = "Stop"

	$Property = $Context.CreateProperty($Name, $DataType, $MaxLength)
	$Property.Information.DisplayInProductsList = [bool]$DisplayInProductsList
	$Property.Information.IsRequired = [bool]$IsRequired
	$Property.Information.DisplayAsBase = [bool]$DisplayAsBaseProperty
	$Property.Information.DisplayName = $DisplayName
	
	$UnsupportedDataTypeDefaults = "BigInteger","Float","FilePath","Enumeration","Text"
	if ($UnsupportedDataTypeDefaults -notcontains $DataType -and $DefaultValue -ne $null) {
		$Property.Information."Default$($Property.DataType)Value" = $DefaultValue
	}
	
	$Property.Save()

	if ($AssignAll) {
		$Context | Set-CSCatalogPropertyAssignAll -PropertyName $Name
	}

	return $Property
}