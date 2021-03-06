trap { break }

Add-Type -AssemblyName "Microsoft.CommerceServer.Catalog, Version=6.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL"
Add-Type -AssemblyName "Microsoft.CommerceServer.CrossTierTypes, Version=6.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL"

. $PSScriptRoot\Get-CSCatalogContext.ps1

. $PSScriptRoot\Get-CSCatalogDefinition.ps1
. $PSScriptRoot\Add-CSCatalogDefinitionProperty.ps1

. $PSScriptRoot\Get-CSCatalogProperty.ps1
. $PSScriptRoot\New-CSCatalogProperty.ps1
. $PSScriptRoot\Set-CSCatalogPropertyAssignAll.ps1

. $PSScriptRoot\Get-CSCatalog.ps1
. $PSScriptRoot\New-CSCatalogBaseCatalog.ps1

. $PSScriptRoot\Get-CSCatalogProduct.ps1
. $PSScriptRoot\New-CSCatalogProduct.ps1

. $PSScriptRoot\Invoke-CSCatalogChangeset.ps1
