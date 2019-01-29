#	_  _ ____ _ _ _ _    _ ____ ____    ____ ____ ____ ___ _ _ _ ____ ____ ____ 
#	|\ | |___ | | | |    | |___ |___    [__  |  | |___  |  | | | |__| |__/ |___ 
#	| \| |___ |_|_| |___ | |    |___    ___] |__| |     |  |_|_| |  | |  \ |___ 
#
# @file nl.nlsw.TestSuite.psd1
#
@{
	GUID = "df22e9bb-15e4-4374-9415-63786747ee4c"
	Author = "Ernst van der Pols"
	CompanyName = "NewLife Software"
	Copyright = "(c) Ernst van der Pols. All rights reserved."
	HelpInfoUri="http://www.nlsw.nl/?item=software"
	ModuleVersion = "1.0.0.0"
	PowerShellVersion="5.1"
	DotNetFrameworkVersion="4.5"
	CLRVersion="4.0"
	#RootModule=".\nl.nlsw.TestSuite.ps1"
	Description="A PowerShell utility module for running unit tests."
	NestedModules = @(
		".\nl.nlsw.TestSuite.ps1"
	)
	FunctionsToExport=@(
		"New-TestSuite","Test-Case","Write-TestResult","Test-TestSuite"
	)
}
