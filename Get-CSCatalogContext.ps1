function Get-CSCatalogContext
{
    <#
    .Synopsis
        Gets a Commerce Server CatalogContext for a specific commerce site.
	.Link
		http://msdn.microsoft.com/en-us/library/microsoft.commerceserver.catalog.catalogcontext_members.aspx
    .Description
        Gets all of the loaded types, or gets the possible values for an 
        enumerated type or value.
    .Example
        # Gets all loaded types
        Get-CSCatalogContext -ServiceUri http://localhost/CatalogWebService/CatalogWebService.asmx
    .Example
        # Gets types from System.Management.Automation
        Get-CSCatalogContext -SiteName StarterSite
    #>
    
    [CmdletBinding(DefaultParameterSetName="ServiceUri")]   
	param(
		[parameter(
			ParameterSetName="ServiceUri",
			Position=0,
			Mandatory=$true, 
			ValueFromPipeline=$true, 
			HelpMessage="The Commerce Server catalog web service uri."
		)]
		[string]
		$ServiceUri,

		[parameter(
			ParameterSetName="SiteName",
			Mandatory=$true, 
			HelpMessage="The Commerce Server commerce site name."
		)]
		[string]
		$SiteName
	)

    end
    {
		$ErrorActionPreference = "Stop"

		switch ($PSCmdlet.ParameterSetName) {
            ServiceUri {
				$ExpectedSuffix = "/CatalogWebService/CatalogWebService.asmx"
				if ($ServiceUri -notlike "*$ExpectedSuffix") {
					if ($ServiceUri -like "*/") {
						$ServiceUri = $ServiceUri.Substring(0, $ServiceUri.Length - 1)
					}
					$ServiceUri += $ExpectedSuffix
				}
				$Agent = New-Object -TypeName Microsoft.CommerceServer.Catalog.CatalogServiceAgent -ArgumentList $ServiceUri 
            }          
            SiteName {
				$Agent = New-Object -TypeName Microsoft.CommerceServer.Catalog.CatalogSiteAgent
				$Agent.SiteName = $SiteName
            }
        }

		return [Microsoft.CommerceServer.Catalog.CatalogContext]::Create($Agent) ;
	}
}