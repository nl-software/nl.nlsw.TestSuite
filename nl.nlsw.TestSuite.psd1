#	_  _ ____ _ _ _ _    _ ____ ____    ____ ____ ____ ___ _ _ _ ____ ____ ____
#	|\ | |___ | | | |    | |___ |___    [__  |  | |___  |  | | | |__| |__/ |___
#	| \| |___ |_|_| |___ | |    |___    ___] |__| |     |  |_|_| |  | |  \ |___
#
# @file nl.nlsw.TestSuite.psd1
#
@{
	# Script module or binary module file associated with this manifest.
	RootModule = ".\nl.nlsw.TestSuite.psm1"

	# Version number of this module.
	ModuleVersion = "1.0.0.0"

	# Supported PSEditions
	# CompatiblePSEditions = @()

	# ID used to uniquely identify this module
	GUID = "df22e9bb-15e4-4374-9415-63786747ee4c"

	# Author of this module
	Author = "Ernst van der Pols"

	# Company or vendor of this module
	CompanyName = "NewLife Software"

	# Copyright statement for this module
	Copyright = "(c) Ernst van der Pols. All rights reserved."

	# Description of the functionality provided by this module
	Description = "A PowerShell utility module for running unit tests."

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = "5.1"

	# Name of the Windows PowerShell host required by this module
	# PowerShellHostName = ''

	# Minimum version of the Windows PowerShell host required by this module
	# PowerShellHostVersion = ''

	# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
	DotNetFrameworkVersion = "4.5"

	# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
	CLRVersion = "4.0"

	# Processor architecture (None, X86, Amd64) required by this module
	# ProcessorArchitecture = ''

	# Modules that must be imported into the global environment prior to importing this module
	# RequiredModules = @()

	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @()

	# Script files (.ps1) that are run in the caller's environment prior to importing this module.
	# ScriptsToProcess = @()

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @()

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @()

	# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
	NestedModules = @()

	# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
	FunctionsToExport=@(
		"New-TestSuite","Test-Case","Write-TestResult","Test-TestSuite"
	)

	# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
	CmdletsToExport = @()

	# Variables to export from this module
	VariablesToExport = @()

	# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
	AliasesToExport = @()

	# DSC resources to export from this module
	# DscResourcesToExport = @()

	# List of all modules packaged with this module
	# ModuleList = @()

	# List of all files packaged with this module
	FileList=@(
		".\nl.nlsw.TestSuite.psm1"
	)

	# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{

		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('Test','UnitTest')

			# A URL to the license for this module.
			LicenseUri = 'https://spdx.org/licenses/EUPL-1.2.html'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/nl-software/nl.nlsw.TestSuite'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable

	# HelpInfo URI of this module
	# HelpInfoUri = "http://www.nlsw.nl/?item=software"

	# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
	# DefaultCommandPrefix = ''
}
