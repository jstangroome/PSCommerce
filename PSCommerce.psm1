trap { break }

Add-Type -AssemblyName "Microsoft.CommerceServer.Catalog, Version=6.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL"
Add-Type -AssemblyName "Microsoft.CommerceServer.CrossTierTypes, Version=6.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL"

. $PSScriptRoot\Get-CSCatalogContext.ps1
. $PSScriptRoot\Get-CSCatalogProperty.ps1
