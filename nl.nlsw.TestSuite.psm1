#	__ _ ____ _  _ _    _ ____ ____   ____ ____ ____ ___ _  _ ____ ____ ____
#	| \| |=== |/\| |___ | |--- |===   ==== [__] |---  |  |/\| |--| |--< |===
#
# @file nl.nlsw.TestSuite.psm1
# @copyright Ernst van der Pols, Licensed under the EUPL-1.2-or-later
#requires -version 5.1

<#
.SYNOPSIS
 Create a new test suite.
  
.DESCRIPTION
 Create a new test suite object to perform a series of test case operations.
 
.PARAMETER Name
 The name of the test suite.

.PARAMETER Quiet
 Do not write the test case result(s) to the host.

.NOTES
 @date 2021-11-01
 @author Ernst van der Pols
#>
function New-TestSuite {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$true)]
		[string]$Name,
		
		[Parameter(Mandatory=$false)]
		[int]$IdColumnWidth = 10,
		
		[Parameter(Mandatory=$false)]
		[int]$NameColumnWidth = 60,
		
		[Parameter(Mandatory=$false)]
		[switch]$Quiet
	)
	# log the tests
	$suite = [PSCustomObject][ordered]@{
		'Name' = $Name;
		'Case' = new-object "System.Collections.Generic.List[PSCustomObject]";
		'Errors' = 0;
		'IdColumnWidth' = $IdColumnWidth;
		'NameColumnWidth' = $NameColumnWidth;
		'Quiet' = $Quiet;
	}

	if ($PSVersionTable.PSVersion.Major -lt 6) {
		# PSv5.1+: Make Out-File/>/>> create UTF-8 files with BOM by default:
		$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
	}

	if (!$suite.quiet) {
		write-host ("{0,$($suite.IdColumnWidth)} {1}" -f "TestSuite",$suite.Name) -foregroundcolor Yellow
	}
	return $suite
}

<#
.SYNOPSIS
 Perform a test case.
  
.DESCRIPTION
 Execute an operation as part of a test suite, compare the output of the operation with the expected result,
 and store all this in a new entry in the test suite.
 
.PARAMETER Suite
 The test suite to store the test case result into.

.PARAMETER Operation
 The operation to execute.
 
.PARAMETER ExpectedOutput
 The expected output of the operation.

.PARAMETER PassThru
 Return the created test case in the pipeline.

.PARAMETER Quiet
 Do not write the test case result to the host.

.NOTES
 @date 2019-01-21
 @author Ernst van der Pols
#>
function Test-Case {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$True, ValueFromPipeline = $True)]
		[PSCustomObject]$suite,

		[Parameter(Mandatory=$True, Position=0)]
		[string]$Name,

		[Parameter(Mandatory=$True, Position=1)]
		[scriptblock]$Operation,

		[Parameter(Mandatory=$false, Position=2)]
		[object]$ExpectedOutput,

		[Parameter(Mandatory=$false)]
		[switch]$PassThru,

		[Parameter(Mandatory=$false)]
		[switch]$Quiet
	)
	begin {
		$verboseOn = ($VerbosePreference -ne 'SilentlyContinue')
	}
	process {
		# create a new test case
		$test = [PSCustomObject][ordered]@{
			'id'=$("T{0:d}" -f $suite.case.Count); 'name'=$Name;
			'operation'=$Operation; 'expected'=$ExpectedOutput; 'output'=$null; 'result'=$null; 'error'=$null;
		}
		$suite.case.Add($test)
		try {
			# execute the operation
			$test.output = invoke-command $test.operation -verbose:$verboseOn
			# check the expected output
			if ($test.expected -is [System.Type]) {
				# an output object of a specific type is expected: check the type of the output
				if ($test.output -is $test.expected) {
					$test.result = "OK"
					$message = "expected $($test.expected)"
				}
				else {
					$test.result = "FAILED"
					$outputtype = if ($test.output) { $test.output.GetType() } else { $null }
					$test.error = "invalid output type $($outputtype)"
					$suite.Errors++
				}
			}
			elseif ($test.output -ne $test.expected) {
				$test.result = "FAILED"
				$test.error = "invalid output value: $($test.output)"
				$suite.Errors++
			}
			else {
				$test.result = "OK"
			}
		}
		catch [Exception] {
			# the 'output' of the test is an exception
			$test.output = $_.Exception;
			if (($test.expected -is [System.Type]) -and ($test.output -is $test.expected)) {
				# the exception is of the expected type
				$test.result = "OK"
				$message = "expected $($test.expected)"
			}
			else {
				$test.result = "FAILED"
				$test.error = $_
				$suite.Errors++
			}
		}
		if ($PassThru) {
			# return the performed test
			write-output $test
		}
		if (!$Quiet -and !$suite.quiet) {
			$color = if ($test.error) { $message=$test.error; "Red" } else { "Green" }
			write-host ("{0,$($suite.IdColumnWidth)} {1} {2} {3}" -f $test.id,$test.name.PadRight($suite.NameColumnWidth,'.'),$test.result,$message) -foregroundcolor $color
		}
	}
}

<#
.SYNOPSIS
 Write the results of the test suite to the host.
  
.DESCRIPTION
 Calculate and write the results of the test suite to the host
 (the information stream).
 
.PARAMETER Suite
 The test suite to report on.

.PARAMETER Passthru
 Write the suite to the pipeline.

.PARAMETER Quiet
 Do not write the test suite result to the host.

.NOTES
 @date 2019-01-21
 @author Ernst van der Pols
#>
function Write-TestResult {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$True, ValueFromPipeline = $True)]
		[PSCustomObject]$Suite,
		
		[Parameter(Mandatory=$False)]
		[switch]$Passthru,

		[Parameter(Mandatory=$False)]
		[switch]$Quiet
	)
	if (!$Quiet -and !$suite.quiet) {
		write-host ("{0,$($suite.IdColumnWidth)} test(s) executed: {1} failed" -f $suite.case.Count,$suite.Errors) -foregroundcolor Yellow
	}
	if ($PassThru) {
		write-output $suite
	}
}

<#
.SYNOPSIS
 Run the test suite on module nl.nlsw.TestSuite.
 A set of functions to run a series of module, unit, or other PowerShell test
 operations (test cases).
  
.DESCRIPTION
 Calculate and write the results of the test suite to the host.

.EXAMPLE
 Install the nl.lsw.TestSuite module with PowerShell 5.1 or above
 
 - Install the folder nl.nlsw.TestSuite with its contents on your $env:Path

 - Open PowerShell

 - Enable the execution of (local) scripts
   PS > Set-ExecutionPolicy RemoteSigned

 - Check which commands are now available from the new module
   PS > Get-Command -module nl.nlsw.TestSuite

 - Run as example the test suite test of the TestSuite
   PS > $test = Test-TestSuite
   
 - Inspect output and results from the test suite
   PS > $test.case | format-table
 

.NOTES
 @date 2019-01-21
 @author Ernst van der Pols
#>
function Test-TestSuite {
	[CmdletBinding()]
	param (
	)
	begin {
		$suite = New-TestSuite -Name "Test of nl.nlsw.TestSuite"
	}
	process {
		$suite | test-case "Simple numerical example" { 1 + 1 } 2
		$suite | test-case "throw [System.Exception]" { throw [System.Exception] } $([System.Exception])
		# test the module manifest
		$suite | test-case "module manifest" { Test-ModuleManifest "$PSScriptRoot\nl.nlsw.TestSuite.psd1" | out-null; $? } $true
		$suite | test-case "verbose test case" { write-verbose "script that writes verbose output" 4>&1 } ([System.Management.Automation.VerboseRecord]) -verbose:$true
		# now, test some functions of this module with itself
		$case = $suite | test-case "`$ts = New-TestSuite" { 
			New-TestSuite "The inner test suite" -IdColumnWidth (10+$suite.IdColumnWidth) -NameColumnWidth ($suite.NameColumnWidth-20)
		} ([PSObject]) -passthru
		# test some properties of the created object in the previous test case (use the "output"-property of the returned test-case-object)
		$suite | test-case "`$ts.Name" { $case.output.Name } "The inner test suite"
		$suite | test-case "`$ts.IdColumnWidth" { $case.output.IdColumnWidth } (10+$suite.IdColumnWidth)
		$suite | test-case "`$ts.case.Count -eq 0" { $case.output.Case.Count } 0
		# now, something rather complex: test the execution of a test case on the inner test suite
		$oktest = $suite | test-case "run test case 0" { $case.output | test-case "Simple numerical example" { 1+1 } 2 -passthru } ([PSObject]) -passthru
		$suite | test-case "`$ts.case[0].result is OK" { $oktest.output.result } "OK"
		$suite | test-case "run (failing) test case 1" { $case.output | test-case "Faulty numerical example" { 1+1 } 3 -passthru } ([PSObject])
		$suite | test-case "`$ts.case[1].result is FAILED" { $case.output.case[1].result } "FAILED"
		$suite | test-case "`$ts.case.Count -eq 2" { $case.output.Case.Count } 2
		$suite | test-case "`$ts.case.Errors -eq 1" { $case.output.Errors } 1
		$tr = $suite | test-case "Write-TestResult" { $case.output | Write-TestResult -passthru } ([PSObject]) -passthru
		$suite | test-case "returned suite is the suite" { $tr.output -eq $case.output } $true
		
	}
	end {
		$suite | Write-TestResult -passthru
	}
}

Export-ModuleMember -function *
