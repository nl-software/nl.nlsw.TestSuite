# nl.nlsw.TestSuite

The nl.nlsw.TestSuite PowerShell module provides a simple yet effective unit test
framework for testing PowerShell scripts and modules. This 'framework'
consists of just three cmdlets: New-TestSuite, Test-Case, and Write-TestResult.

Should I not use *Pester*, the ubiquitous test and mock framework for
PowerShell? Yes, you probably should. However, if you look for creating
a simple test suite with a minimalistic framework, this module might
be enough.

## Installation

You can install the module for your own use from the [PowerShell Gallery](https://www.powershellgallery.com/packages/nl.nlsw.TestSuite/):

```powershell
Install-Module "nl.nlsw.TestSuite" -Scope CurrentUser
```

## Usage

As example, you can run the included test function that tests the module itself:

```powershell
Test-TestSuite
```

## Documentation

A little documentation on the module is included and available via:

```powershell
Get-Help about_nl.nlsw.TestSuite
```

## Downloading the Source Code

You can clone the repository:

```powershell
git clone https://github.com/nl-software/nl.nlsw.TestSuite.git
```

## Legal and Licensing

nl.nlsw.TestSuite is licensed under the [EUPL-1.2 license][].

[EUPL-1.2 license]: https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12