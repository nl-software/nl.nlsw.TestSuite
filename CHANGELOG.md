# nl.nlsw.TestSuite changelog

## Release 2022-10-17-nl.nlsw.TestSuite-1.0.1

### Changed
- Version number conform [Semantic Versioning 2.0.0]. However,
  restricting to SemVer 1.0.0 for [PowerShell Gallery Prerelease Module] compatibility.

### Fixed
- A few Information-remarks of PSScriptAnalyzer. Ignored the Warnings on;
  - ShouldProcess for New-TestSuite
  - using Write-Host, since it is used deliberately.

## References

[PowerShell Gallery Prerelease Module]: https://learn.microsoft.com/en-us/powershell/scripting/gallery/concepts/module-prerelease-support
[Semantic Versioning 2.0.0]: <https://semver.org/> "semver.org"
- These release notes are loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
