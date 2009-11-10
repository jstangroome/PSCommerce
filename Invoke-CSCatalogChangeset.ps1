function Invoke-CSCatalogChangeset
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
			Mandatory=$true,
			HelpMessage="Unique label for this changeset to ensure it is only applied once."
		)]
		[string]
		$Label,
		
		[parameter(
			Mandatory=$true
		)]
		[ScriptBlock]
		$ChangesetScript
	)
	
	end {
		
if (-not ($Context | Get-CSCatalogProperty -Name SchemaChangeTrackingLabel)) {
	New-CSCatalogProperty -Context $Context `
		-Name SchemaChangeTrackingLabel `
		-DataType String `
		-MaxLength 256 `
		-DisplayInProductsList `
		-IsRequired `
		-DisplayAsBaseProperty
}

if (-not (Get-CSCatalogProperty -Context $Context -Name SchemaChangeTrackingStamp)) {
	New-CSCatalogProperty -Context $Context `
		-Name SchemaChangeTrackingStamp `
		-DataType DateTime `
		-DisplayInProductsList `
		-IsRequired `
		-DisplayAsBaseProperty ;
}

if (-not (Get-CSCatalogDefinition -Context $Context -Name SchemaChangeTrackingEvent)) {
	New-CSCatalogDefinition -Context $Context `
		-Name SchemaChangeTrackingEvent `
		-DefinitionType ProductDefinition
}
Add-CSCatalogDefinitionProperty -Context $Context `
	-DefinitionName SchemaChangeTrackingEvent `
	-PropertyName SchemaChangeTrackingStamp

		$ChangeTrackingCatalogName = "SchemaChangeTracking"
		$ChangeTracking = $Context | Get-CSCatalog -Name $ChangeTrackingCatalogName 
		if (-not $ChangeTracking) {
			$ChangeTracking = $Context | New-CSCatalogBaseCatalog `
				-Name $ChangeTrackingCatalogName `
				-ProductIdProperty SchemaChangeTrackingLabel `
				-DefaultLanguage "en-US"
		}

		if ($Catalog | Get-CSCatalogProduct -ProductId $Label) { return }

		& $ChangesetScript
		
		Write-Debug -Message "Marking label '$Label' as applied."
		$Stamp = [DateTime]::Now
		$Product = $Catalog | New-CSCatalogProduct -DefinitionName SchemaChangeTrackingEvent -ProductId $Label -DisplayName $Label
		$Product.Item("SchemaChangeTrackingStamp") = $Stamp
		$Product.Save()
		Write-Verbose -Message "Change '$Label' applied at $($Stamp.ToString())."
	}
}
