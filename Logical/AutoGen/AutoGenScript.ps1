################################################################################
 # File: AutoGenScript.ps1
 # Created: 2025-02-15
 # Author: Tyler Carpenter
 # License: MIT
 # PowerShell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\Logical\AutoGen\AutoGenScript.ps1 $(WIN32_AS_PROJECT_PATH) "$(AS_VERSION)" "$(AS_USER_NAME)" "$(AS_PROJECT_NAME)" "$(AS_CONFIGURATION)" "$(AS_BUILD_MODE)"
################################################################################

################################################################################
# Functions and Classes
################################################################################
	class VarDefinition {
		[string]$Name
		[string]$Type
		[string]$Init
		[string]$Comment
		[bool]$Constant
		[bool]$Retain
		[bool]$Unrep
		VarDefinition([string]$name, [string]$type, [string]$init, [string]$comment, [bool]$constant, [bool]$retain, [bool]$unrep) {
			$this.Name 		= $name 	
			$this.Type 		= $type 	
			$this.Init 		= $init 	
			$this.Comment 	= $comment 	
			$this.Constant 	= $constant 
			$this.Retain 	= $retain 	
			$this.Unrep 	= $unrep 	
		}
	}

	class TypeDefinition {
		[string]$Name
		[string]$Comment
		
		TypeDefinition([string]$name, [string]$comment) {
			$this.Name 		= $name
			$this.Comment 	= $comment
		}
	}

	class StructureMember {
		[string]$Name
		[string]$Type
		[string]$Init
		[string]$Comment

		StructureMember([string]$name, [string]$type, [string]$init = "", [string]$comment = "") {
			$this.Name 		= $name
			$this.Type 		= $type
			$this.Init 		= $init
			$this.Comment 	= $comment
		}
	}

	class EnumMember {
		[string]$Name
		[string]$Init
		[string]$Comment

		EnumMember([string]$name, [string]$init = "", [string]$comment = "") {
			$this.Name 		= $name
			$this.Init 		= $init
			$this.Comment 	= $comment
		}
	}
	function DeepCopy-OrderedDict {
		param(
			[Collections.Specialized.OrderedDictionary]$Dict
		)
		$newDict = New-Object Collections.Specialized.OrderedDictionary
		foreach ($key in $Dict.Keys) {
			if ($Dict[$key] -is [Collections.Specialized.OrderedDictionary] -or $Dict[$key] -is [hashtable]) {
				# Recursively copy if it's a dictionary or hashtable
				$newDict[$key] = DeepCopy-OrderedDict $Dict[$key]
			} elseif ($Dict[$key] -is [array]) {
				# Clone arrays to prevent reference issues
				$newDict[$key] = $Dict[$key].Clone()
			} else {
				# Simple assignment for primitive values (strings, numbers, etc.)
				$newDict[$key] = $Dict[$key]
			}
		}
		return $newDict
	}
	function Get-FileLocations {
		param(
			[Collections.Specialized.OrderedDictionary]$Dict,
			[string]$SearchPath,
			[string]$FileName,
			[string]$Category,
			[switch]$ShowOutput,
			[switch]$ParentPathOnly
		)
		# Initialize $Dict if it's not provided, null, or empty
		if (-not $Dict -or $Dict.Count -eq 0) {
			$Dict = New-Object Collections.Specialized.OrderedDictionary
		}
		$files = Get-ChildItem -Path $SearchPath -Filter $FileName -Recurse
		$Dict[$Category] = if ($ParentPathOnly) {
			@($files | Select-Object -ExpandProperty Directory | Select-Object -ExpandProperty FullName)
		} else {
			@($files | Select-Object -ExpandProperty FullName)
		}
		if ($ShowOutput) {
			Write-Host "Found $($Dict[$Category].Count) $(if($ParentPathOnly){'directories'}else{'files'}) matching '$FileName' in '$SearchPath':"
			$Dict[$Category] | ForEach-Object { Write-Host " - $_" }
		}
		return $Dict
	}
	function Add-ActionFile {
		param (
			[string]$FolderPath,
			[string]$Name,
			[string]$Content
		)
		$FileName = $Name+".st"
		Add-IECObject -FolderPath $FolderPath -ObjectName $FileName -Description "AutoGen"
		$Path = $FolderPath + "/" + $FileName
		$FullContent = "`r`nACTION $Name`:`r`n$Content`r`nEND_ACTION`r`n"
		Set-Content -Path $Path -Value $FullContent
	}
	function Add-TypFile {
		param (
			[string]$FolderPath,
			[string]$Name,
			[System.Collections.Specialized.OrderedDictionary]$Dict,
			 [switch]$Global
		)
		$FileName = $Name+".typ"
		if ($Global){
			Add-PackageObject -FolderPath $FolderPath -ObjectName $FileName -ObjectType "File" -Description "AutoGen"
		}
		else
		{
			Add-IECObject -FolderPath $FolderPath -ObjectName $FileName -Description "AutoGen"
		}
		$Path = $FolderPath + "/" + $FileName
		Write-TypeContent -FilePath $Path -Structure $Dict
	}
	function Add-VarFile {
		param (
			[string]$FolderPath,
			[string]$Name,
			[System.Collections.Specialized.OrderedDictionary]$Dict,
			 [switch]$Global
		)
		$FileName = $Name+".var"
		if ($Global){
			Add-PackageObject -FolderPath $FolderPath -ObjectName $FileName -ObjectType "File" -Description "AutoGen"
		}
		else
		{
			Add-IECObject -FolderPath $FolderPath -ObjectName $FileName -Description "AutoGen"
		}
		$Path = $FolderPath + "/" + $FileName
		Write-VarContent -FilePath $Path -Variables $Dict
	}
	function Add-PackageObject {
		param (
			[string]$FolderPath,
			[string]$ObjectName,
			[string]$ObjectType,
			[string]$Description
		)
		$PackageFilePath = Join-Path -Path $FolderPath -ChildPath "Package.pkg"
		if (Test-Path -Path $PackageFilePath) {
			$PackageXml = New-Object System.Xml.XmlDocument
			$PackageXml.PreserveWhitespace = $true
			$PackageXml.Load($PackageFilePath)
			$ObjectsNode = $PackageXml.Package.Objects
			$ObjectExists = $ObjectsNode.Object | Where-Object { $_.InnerText -eq $ObjectName }
			if (-not $ObjectExists) {
				$WhitespaceBefore = $PackageXml.CreateWhitespace("  ")
				$null = $ObjectsNode.AppendChild($WhitespaceBefore)
				$NewObject = $PackageXml.CreateElement("Object", $PackageXml.DocumentElement.NamespaceURI)
				$NewObject.SetAttribute("Type", $ObjectType)
				$NewObject.SetAttribute("Description", $Description)
				$NewObject.InnerText = $ObjectName
				$null = $ObjectsNode.AppendChild($NewObject)
				$WhitespaceAfter = $PackageXml.CreateWhitespace("`r`n  ")
				$null = $ObjectsNode.AppendChild($WhitespaceAfter)
				$PackageXml.Save($PackageFilePath)
			}
		}
	}
	function Add-IECObject {
		param (
			[string]$FolderPath,
			[string]$ObjectName,
			[string]$Description,
			 [switch]$Global
		)
		$IECFilePath = Join-Path -Path $FolderPath -ChildPath "IEC.prg"
		if (Test-Path -Path $IECFilePath) {
			$IECXml = New-Object System.Xml.XmlDocument
			$IECXml.PreserveWhitespace = $true
			$IECXml.Load($IECFilePath)
			$ObjectsNode = $IECXml.Program.Files
			$ObjectExists = $ObjectsNode.File | Where-Object { $_.InnerText -eq $ObjectName }
			if (-not $ObjectExists) {
				$WhitespaceBefore = $IECXml.CreateWhitespace("  ")
				$null = $ObjectsNode.AppendChild($WhitespaceBefore)
				$NewObject = $IECXml.CreateElement("File", $IECXml.DocumentElement.NamespaceURI)
				$NewObject.SetAttribute("Description", $Description)
				if (!$Global){
					$NewObject.SetAttribute("Private", "true")
				}
				$NewObject.InnerText = $ObjectName
				$null = $ObjectsNode.AppendChild($NewObject)
				$WhitespaceAfter = $IECXml.CreateWhitespace("`r`n  ")
				$null = $ObjectsNode.AppendChild($WhitespaceAfter)
				$IECXml.Save($IECFilePath)
			}
		}
	}
	function Merge-Structures {
		param (
			[System.Collections.Specialized.OrderedDictionary]$hash1,
			[System.Collections.Specialized.OrderedDictionary]$hash2
		)
		$merged = New-Object System.Collections.Specialized.OrderedDictionary
		foreach ($key in $hash1.Keys) {
			$merged[$key] = $hash1[$key]
		}
		foreach ($key in $hash2.Keys) {
			if ($merged.Contains($key)) {
				if ($merged[$key] -is [System.Collections.Specialized.OrderedDictionary] -and 
					$hash2[$key] -is [System.Collections.Specialized.OrderedDictionary]) {
					$nestedMerged = Merge-Structures -hash1 $merged[$key] -hash2 $hash2[$key]
					$merged[$key] = $nestedMerged
				} else {
					$merged[$key] = $hash2[$key]
				}
			} else {
				$merged.Add($key, $hash2[$key])
			}
		}
		return $merged
	}

	function New-StructureDefinition {
		param(
			[string]$TypeName,
			[StructureMember[]]$Members,
			[string]$Comment = ""
		)
		
		$structure = [ordered]@{
			$TypeName = [ordered]@{
				'Structure_Comment' = $Comment
				'Structure_Elements' = [ordered]@{}
			}
		}
		if ($Members.Count -ne 0){
			foreach ($member in $Members) {
				$structure[$TypeName]['Structure_Elements'][$member.Name] = @{
					'Type' = $member.Type
					'Init' = $member.Init
					'Comment' = $member.Comment
				}
			}
		}
		return $structure
	}

	function Add-StructureMembers {
		param(
			[Parameter(Mandatory=$true)]
			[System.Collections.Specialized.OrderedDictionary]$Structure,
			[Parameter(Mandatory=$true)]
			[StructureMember[]]$Members
		)
		
		# Verify this is a structure definition
		$typeName = $Structure.Keys | Select-Object -First 1
		if (-not $Structure[$typeName].Contains('Structure_Elements')) {
			throw "The provided definition is not a structure"
		}
		
		foreach ($member in $Members) {
			$Structure[$typeName]['Structure_Elements'][$member.Name] = @{
				'Type' = $member.Type
				'Init' = $member.Init
				'Comment' = $member.Comment
			}
		}
		
		return $Structure
	}

	function New-EnumDefinition {
		param(
			[Parameter(Mandatory=$true)]
			[string]$TypeName,
			[Parameter(Mandatory=$true)]
			[EnumMember[]]$Members,
			[string]$Comment = ""
		)
		
		$enum = [ordered]@{
			$TypeName = [ordered]@{
				'Enum_Comment' = $Comment
				'Enum_Elements' = [ordered]@{}
			}
		}
		
		foreach ($member in $Members) {
			$enum[$TypeName]['Enum_Elements'][$member.Name] = @{
				'Init' = $member.Init
				'Comment' = $member.Comment
			}
		}
		
		return $enum
	}
	function Add-EnumMembers {
		param(
			[Parameter(Mandatory=$true)]
			[System.Collections.Specialized.OrderedDictionary]$Enum,
			[Parameter(Mandatory=$true)]
			[EnumMember[]]$Members
		)
		
		# Verify this is an enum definition
		$typeName = $Enum.Keys | Select-Object -First 1
		if (-not $Enum[$typeName].Contains('Enum_Elements')) {
			throw "The provided definition is not an enum"
		}
		
		foreach ($member in $Members) {
			$Enum[$typeName]['Enum_Elements'][$member.Name] = @{

				'Init' = $member.Init
				'Comment' = $member.Comment
			}
		}
		
		return $Enum
	}

	function New-VarDefinition {
		param(
			[string]$Name = "",
			[string]$Type = "",
			[string]$Init = "",
			[string]$Comment = "",
			[switch]$Constant,
			[switch]$Retain,
			[switch]$Unrep
		)
		return [VarDefinition]::new($Name, $Type, $Init, $Comment, $Constant, $Retain, $Unrep)
	}
	function Add-VarDefinitions {
		param(
			[Parameter(Mandatory=$true)]
			[System.Collections.Specialized.OrderedDictionary]$VarDictionary,
			[Parameter(Mandatory=$true)]
			[VarDefinition[]]$Vars
		)
		foreach ($var in $Vars) {
			$VarDictionary[$var.Name] = @{
				'Type'	  = $var.Type
				'Init'	  = $var.Init
				'Comment'  = $var.Comment
				'Constant' = $var.Constant
				'Retain'	= $var.Retain
				'Unrep'	 = $var.Unrep
			}
		}
		return $VarDictionary
	}
function Write-VarContent {
	param (
		[string]$FilePath,
		[System.Collections.Specialized.OrderedDictionary]$Variables
	)
	$newContent = ""
	# Categorize variables based on attributes
	$varGroups = @{
		"CONSTANT" = New-Object System.Collections.Specialized.OrderedDictionary
		"RETAIN"	= New-Object System.Collections.Specialized.OrderedDictionary
		"DEFAULT"  = New-Object System.Collections.Specialized.OrderedDictionary
	}
	
	foreach ($varName in $Variables.Keys) {
		$varDef = $Variables[$varName]
		if ($varDef.Constant) {
			$varGroups["CONSTANT"].Add($varName, $varDef)
		} elseif ($varDef.Retain) {
			$varGroups["RETAIN"].Add($varName, $varDef)
		} else {
			$varGroups["DEFAULT"].Add($varName, $varDef)
		}
	}

	# Write DEFAULT (non-CONSTANT, non-RETAIN) variables
	if ($varGroups["DEFAULT"].Count -gt 0) {
		$newContent += "VAR`r`n"
		foreach ($varName in $varGroups["DEFAULT"].Keys) {
			$var = $varGroups["DEFAULT"][$varName]
			$newContent += "`t$varName : "
			if ($var.Unrep) {
				$newContent += "{REDUND_UNREPLICABLE} "
			}
			$newContent += "$($var.Type)"
			if (![string]::IsNullOrEmpty($var.Init)) {
				$newContent += " := $($var.Init)"
			}
			$newContent += ";"
			if (![string]::IsNullOrEmpty($var.Comment)) {
				$newContent += " (*$($var.Comment)*)"
			}
			$newContent += "`r`n"
		}
		$newContent += "END_VAR`r`n`r`n"
	}

	# Write RETAIN variables
	if ($varGroups["RETAIN"].Count -gt 0) {
		$newContent += "VAR RETAIN`r`n"
		foreach ($varName in $varGroups["RETAIN"].Keys) {
			$var = $varGroups["RETAIN"][$varName]
			$newContent += "`t$varName : "
			if ($var.Unrep) {
				$newContent += "{REDUND_UNREPLICABLE} "
			}
			$newContent += "$($var.Type)"
			if (![string]::IsNullOrEmpty($var.Init)) {
				$newContent += " := $($var.Init)"
			}
			$newContent += ";"
			if (![string]::IsNullOrEmpty($var.Comment)) {
				$newContent += " (*$($var.Comment)*)"
			}
			$newContent += "`r`n"
		}
		$newContent += "END_VAR`r`n`r`n"
	}

	# Write CONSTANT variables
	if ($varGroups["CONSTANT"].Count -gt 0) {
		$newContent += "VAR CONSTANT`r`n"
		foreach ($varName in $varGroups["CONSTANT"].Keys) {
			$var = $varGroups["CONSTANT"][$varName]
			$newContent += "`t$varName : $($var.Type)"
			if (![string]::IsNullOrEmpty($var.Init)) {
				$newContent += " := $($var.Init)"
			}
			$newContent += ";"
			if (![string]::IsNullOrEmpty($var.Comment)) {
				$newContent += " (*$($var.Comment)*)"
			}
			$newContent += "`r`n"
		}
		$newContent += "END_VAR`r`n`r`n"
	}

	# Save to file
	Set-Content -Path $FilePath -Value $newContent
}

function Get-VarContent {
	param (
		[string]$FilePath
	)
	
	$content = Get-Content $FilePath -Raw
	$variables = New-Object System.Collections.Specialized.OrderedDictionary

	# Regex pattern to match VAR blocks and capture attributes (CONSTANT, RETAIN, etc.)
	$varBlockPattern = 'VAR\s*(CONSTANT|RETAIN)?\s*([\S\s]*?)END_VAR'
	$matches = [regex]::Matches($content, $varBlockPattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)

	foreach ($match in $matches) {
		$varAttribute = $match.Groups[1].Value.Trim()
		$varBlockContent = $match.Groups[2].Value

		# Regex to match individual variable declarations
		$varPattern = '\s*(\w+)\s*:\s*(?:\{(.*?)\}\s*)?([^;:=]+)(?:\s*:=\s*([^;]+))?\s*;(?:\s*\(\*(.*?)\*\))?'
		$varMatches = [regex]::Matches($varBlockContent, $varPattern)

		foreach ($varMatch in $varMatches) {
			$varName = $varMatch.Groups[1].Value.Trim()
			$varAttributes = $varMatch.Groups[2].Value.Trim()
			$varType = $varMatch.Groups[3].Value.Trim()
			$varInit = $varMatch.Groups[4].Value.Trim()
			$varComment = $varMatch.Groups[5].Value.Trim()

			# Determine attributes
			$isConstant = ($varAttribute -eq "CONSTANT")
			$isRetain = ($varAttribute -eq "RETAIN")
			$isUnrep = ($varAttributes -match "REDUND_UNREPLICABLE")

			# Create new VarDefinition object
			$varDef = [VarDefinition]::new(
				$varName,
				$varType,
				$varInit,
				$varComment,
				$isConstant,
				$isRetain,
				$isUnrep
			)

			$variables.Add($varName, $varDef)
		}
	}
	return $variables
}
	function Merge-TypeDefinitions {
		param(
			[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
			[System.Collections.ICollection]$Definitions
		)
		
		begin {
			$merged = [ordered]@{}
		}
		
		process {
			foreach ($def in $Definitions) {
				foreach ($key in $def.Keys) {
					if ($merged.Contains($key)) {
						# If it's a structure or enum, merge the elements
						if ($def[$key].ContainsKey('Structure_Elements')) {
							$merged[$key]['Structure_Elements'] += $def[$key]['Structure_Elements']
						}
						elseif ($def[$key].ContainsKey('Enum_Elements')) {
							$merged[$key]['Enum_Elements'] += $def[$key]['Enum_Elements']
						}
					}
					else {
						# Otherwise, just add the new type
						$merged[$key] = $def[$key]
					}
				}
			}
		}
		
		end {
			return $merged
		}
	}
	function Write-TypeContent {
		param (
			[String]$FilePath,
			[System.Collections.Specialized.OrderedDictionary]$Structure
		)
		$newContent = "`r`nTYPE`r`n"
		# First write all structures
		foreach ($Def in $Structure.Keys) {
			if ($Structure[$Def].Contains("Structure_Elements")) {
				$newContent += "`t$Def : STRUCT"
				$Comment = $Structure[$Def]['Structure_Comment']
				if (![string]::IsNullOrEmpty($Comment) -and $Comment.Trim() -ne ""){
					$newContent += "`t(*$Comment*)"
				}
				$newContent += "`r`n"
				$Elements = $Structure[$Def]["Structure_Elements"]
				# Iterate through 'Elements'
				foreach ($Elem in $Elements.Keys) {
					$Name = $Elem
					$Type = $Elements[$Elem]["Type"]
					$Init = $Elements[$Elem]["Init"]
					$Comment = $Elements[$Elem]["Comment"]
					$newContent += "`t`t$Name : $Type"
					if (![string]::IsNullOrEmpty($Init) -and $Init.Trim() -ne ""){
						$newContent += " := $Init"
					}
					$newContent += ";"
					if (![string]::IsNullOrEmpty($Comment) -and $Comment.Trim() -ne ""){
						$newContent += " (*$Comment*)"
					}
					$newContent += "`r`n"
				}
				$newContent += "`tEND_STRUCT;`r`n"
			}
		}
		# Then write all enums
		foreach ($Def in $Structure.Keys) {
			if ($Structure[$Def].Contains("Enum_Elements")){
				$newContent += "`t$Def : `r`n`t`t( "
				$Comment = $Structure[$Def]['Enum_Comment']
				if (![string]::IsNullOrEmpty($Comment) -and $Comment.Trim() -ne ""){
					$newContent += "(*$Comment*)"
				}
				$newContent += "`r`n"
				$Elements = $Structure[$Def]["Enum_Elements"]
				# Iterate through 'Elements'
				$index = 0
				foreach ($Elem in $Elements.Keys) {
					$Name = $Elem
					$Init = $Elements[$Elem]["Init"]
					$Comment = $Elements[$Elem]["Comment"]
					if ($index -ne 0) {
						$newContent += ",`r`n"
					}
					$newContent += "`t`t$Name"
					if (![string]::IsNullOrEmpty($Init) -and $Init.Trim() -ne ""){
						$newContent += " := $Init"
					}
					if (![string]::IsNullOrEmpty($Comment) -and $Comment.Trim() -ne ""){
						$newContent += " (*$Comment*)"
					}
					$index++
				}
				$newContent += "`r`n`t`t`);`r`n"
			}
		}
		
		$newContent += "END_TYPE`r`n"
		Set-Content -Path $FilePath -Value $newContent
	}
	function Get-TypeContent {
		param (
			[string]$FilePath
		)
		$content = Get-Content $FilePath -Raw
		$structure = New-Object System.Collections.Specialized.OrderedDictionary
		# Parse STRUCT types
		$typePattern = '(\w+)\s*:\s*STRUCT\s*(?:\(\*(.*?)\*\))?\s*([\S\s]*?)END_STRUCT'
		$matches = [regex]::Matches($content, $typePattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
		foreach ($match in $matches) {
			$structName = $match.Groups[1].Value.Trim()
			$structComment = $match.Groups[2].Value.Trim()
			$elementsContent = $match.Groups[3].Value
			# Create Type
			$structDict = New-Object System.Collections.Specialized.OrderedDictionary
			$structDict.Add('Structure_Comment', $structComment)
			$elements = New-Object System.Collections.Specialized.OrderedDictionary
			$structDict.Add('Structure_Elements', $elements)
			$structure.Add($structName, $structDict)
			# Parse elements
			$elementPattern = '\s*(\w+)\s*:\s*([^;:]+)(?:\s*:=\s*([^;]+))?\s*;(?:\s*\(\*(.*?)\*\))?'
			$elementMatches = [regex]::Matches($elementsContent, $elementPattern)
			foreach ($elemMatch in $elementMatches) {
				$elementName = $elemMatch.Groups[1].Value.Trim()
				$elementType = $elemMatch.Groups[2].Value.Trim()
				$elementInit = $elemMatch.Groups[3].Value.Trim()
				$elementComment = $elemMatch.Groups[4].Value.Trim()
				$elemDict = New-Object System.Collections.Specialized.OrderedDictionary
				$elemDict.Add('Type', $elementType)
				$elemDict.Add('Init', $elementInit)
				$elemDict.Add('Comment', $elementComment)
				$elements.Add($elementName, $elemDict)
			}
		}
		# Parse ENUM types
		$enumPattern = '(\w+)\s*:\s*\(\s*(?:\(\*(.*?)\*\))?\s*([\S\s]*?)\);'
		$matches = [regex]::Matches($content, $enumPattern)
		foreach ($match in $matches) {
			$enumName = $match.Groups[1].Value.Trim()
			$enumComment = $match.Groups[2].Value.Trim()
			$elementsContent = $match.Groups[3].Value
			# Create Enum
			$enumDict = New-Object System.Collections.Specialized.OrderedDictionary
			$enumDict.Add('Enum_Comment', $enumComment)
			$elements = New-Object System.Collections.Specialized.OrderedDictionary
			$enumDict.Add('Enum_Elements', $elements)
			$structure.Add($enumName, $enumDict)
			# Parse enum elements
			$enumElementPattern = '\s*(\w+)(?:\s*:=\s*([^,)]+))?(?:\s*\(\*(.*?)\*\))?(?:,|\s*$)'
			$elementMatches = [regex]::Matches($elementsContent, $enumElementPattern)
			foreach ($elemMatch in $elementMatches) {
				$elementName = $elemMatch.Groups[1].Value.Trim()
				$elementInit = $elemMatch.Groups[2].Value.Trim()
				$elementComment = $elemMatch.Groups[3].Value.Trim()
				$elemDict = New-Object System.Collections.Specialized.OrderedDictionary
				$elemDict.Add('Init', $elementInit)
				$elemDict.Add('Comment', $elementComment)
				$elements.Add($elementName, $elemDict)
			}
		}
		return $structure
	}
################################################################################
# Parameters
################################################################################

################################################################################
# Check project
################################################################################
	Write-Host "AutoGen: Start"
	if($args.Length -lt 1) {
		# Write-Warning output to the Automation Studio console is limited to 110 characters (AS 4.11.5.46 SP)
		Write-Warning "AutoGen: Missing project path argument `$(WIN32_AS_PROJECT_PATH)"
		if($OptionErrorOnArguments) { exit 1 } 
		exit 0
	}
	$LogicalPath = $args[0] + "\Logical\"
	if(-not [System.IO.Directory]::Exists($LogicalPath)) {
		$Path = $args[0]
		Write-Warning "AutoGen: Cannot find Logical folder in $Path"
		if($OptionErrorOnArguments) { exit 1 } 
		exit 0
	}
	$GlobalPath = $LogicalPath + "Global\"
	if(-not [System.IO.Directory]::Exists($GlobalPath)) {
		Write-Warning "AutoGen: Cannot find Global folder"
		if($OptionErrorOnArguments) { exit 1 } 
		exit 0
	}
	$AutoGenPath = $LogicalPath + "AutoGen\"
	if(-not [System.IO.Directory]::Exists($AutoGenPath)) {
		Write-Warning "AutoGen: Cannot find AutoGen folder"
		if($OptionErrorOnArguments) { exit 1 } 
		exit 0
	}
################################################################################
# Read AutoGenOptions
################################################################################
	$Options = New-Object Collections.Specialized.OrderedDictionary
	$OptionsPath = $AutoGenPath + "AutoGenOptions.xml"
	if (Test-Path $OptionsPath) {
		[xml]$XmlOptions = Get-Content $OptionsPath
		Write-Host "Options-"
		foreach ($option in $XmlOptions.Options.ChildNodes) {
			$Options[$option.Name] = $option.InnerText
			Write-Host " - $($option.Name): $($option.InnerText)"
		}
	} else {
		Write-Host "Options file not found at path: $OptionsPath"
		$Options["Enable"] = $false
	}
################################################################################
# Testing
################################################################################
	if ($Options["Enable"]){

	#Find All Global Type Files and Parse them all into $gTypes
		$DirLoc = Get-FileLocations -Dict $DirLoc -SearchPath $GlobalPath -FileName "*.typ" -Category "gTypes" #-ShowOutput
		foreach ($path in $DirLoc["gTypes"]) {
			$Next = Get-TypeContent -FilePath $path
			$gTypes = Merge-Structures -hash1 $gTypes -hash2 $Next
		}

	#ENUM_STRING
		if ($Options["ENUM_STRING"]) {
			$gES = New-StructureDefinition -TypeName "gES_typ"
			foreach ($Typ in $gTypes.Keys) {
				if ($gTypes[$Typ].Enum_Comment -eq "ENUM_STRING") {
					$Count = $gTypes[$Typ].Enum_Elements.Count - 1
					$Init = "["
					foreach ($Elem in $gTypes[$Typ].Enum_Elements.Keys) {
						$Init += "'$Elem', "
					}
					$Init = $Init -replace ", $", "]"
					$gES["gES_typ"]["Structure_Elements"][$Typ] = @{
						"Type" = "ARRAY[0..$($Count)]OF STRING[32]"
						"Init" = $Init
					}
				}
			}
			Add-TypFile -FolderPath $GlobalPath -Name "gES" -Dict $gES -Global
			$globalVars = Get-VarContent -FilePath ($GlobalPath + "Global.var")
			$varDict = @(
				(New-VarDefinition -Name "gES" 	-Type "gES_typ")
			)
			$globalVars = Add-VarDefinitions -VarDictionary $globalVars -Vars $varDict
			Add-VarFile -FolderPath $GlobalPath -Name "Global" -Dict $globalVars -Global
		}

		if ($Options["Monitor"]) {
			$MonitorObj = New-Object Collections.Specialized.OrderedDictionary
			$MonitorPath = $AutoGenPath + "AutoGenMonitor.st"
			
			if (Test-Path $MonitorPath) {
				# Read the file content and replace all backticks (`) with double quotes (")
				$jsonContent = Get-Content -Path $MonitorPath -Raw -Encoding UTF8
				$jsonContent = $jsonContent -replace '\`', '"'

				# Convert JSON string to PowerShell object
				$jsonObject = $jsonContent | ConvertFrom-Json

				# Populate OrderedDictionary with parsed JSON properties
				$jsonObject.PSObject.Properties | ForEach-Object {
					$MonitorObj[$_.Name] = $_.Value
				}

				# Convert back to JSON and output it
				$MonitorObj | ConvertTo-Json -Depth 10
			}
		}
		#$DirLoc = Get-FileLocations -Dict $DirLoc -SearchPath $LogicalPath -FileName "IEC.prg" -Category "Program" -ParentPathOnly -ShowOutput
		# foreach ($path in $DirLoc["Program"]) {
			# if($path -Match "\\Sim$"){
				# Add-ActionFile -FolderPath $path -Name "TestSimAction" -Content "`t//AutoGenerated"
				# $SimStructure = Get-TypeContent -FilePath ($GlobalPath + "Sim.typ")
				# Add-TypFile -FolderPath $path -Name "ES" -Dict $SimStructure
				# break;
			# }
		# }

		# $ParStructure = Get-TypeContent -FilePath ($GlobalPath + "Par.typ")
		# $ServiceStructure = Get-TypeContent -FilePath ($GlobalPath + "Services.typ")
		# $CombinedStructure = Merge-Structures -hash1 $ParStructure -hash2 $ServiceStructure

		# $initialMember = [StructureMember]::new("First", "LREAL", "", "")
		# $structure = New-StructureDefinition -TypeName "MyStruct" -Members $initialMember
		# $moreMembers = @(
			# [StructureMember]::new("Second", "INT", "", ""),
			# [StructureMember]::new("Third", "STRING[80]", "", "Text field")
		# )
		# $structure = Add-StructureMembers -Structure $structure -Members $moreMembers

		# $enumMembers = @(
			# [EnumMember]::new("Zero", "", "Default value"),
			# [EnumMember]::new("One", "", "First option"),
			# [EnumMember]::new("Two", "", "Second option")
		# )
		# $enum = New-EnumDefinition -TypeName "MyEnum" -Members $enumMembers
		# $additionalEnumMembers = @(
			# [EnumMember]::new("Three", "", "Third option"),
			# [EnumMember]::new("Four", "", "Fourth option")
		# )
		# $enum = Add-EnumMembers -Enum $enum -Members $additionalEnumMembers

		# $mergedDefinitions = Merge-TypeDefinitions -Definitions @($structure, $enum)
		# $CombinedStructure = Merge-Structures -hash1 $CombinedStructure -hash2 $mergedDefinitions

		# Add-TypFile -FolderPath $GlobalPath -Name "gES" -Dict $CombinedStructure -Global

		# $globalVars = Get-VarContent -FilePath ($GlobalPath + "Global_GEN.var")
		# $varDict = @(
			# (New-VarDefinition -Name "TESTING_Speed" 	-Type "REAL" 	-Init "50.0" 	-Comment "Vehicle speed" 	-Constant 	),
			# (New-VarDefinition -Name "TESTING_RPM" 		-Type "INT" 	-Init "0" 		-Comment "Engine RPM" 		-Retain		)
		# )
		# $globalVars = Add-VarDefinitions -VarDictionary $globalVars -Vars $varDict
		# Add-VarFile -FolderPath $GlobalPath -Name "Global_GEN" -Dict $globalVars -Global
	}

################################################################################
# Complete
################################################################################
	Write-Host "AutoGen: Complete"

################################################################################
# Build Version
################################################################################
	# Search for directories named $ProgramName
	$Search = Get-ChildItem -Path $LogicalPath -Filter "BuildVersion" -Recurse -Directory -Name
	$BVFound = $False
	# Loop through zero or more directories named $ProgramName
	foreach($SearchItem in $Search) {
		$ProgramPath = $LogicalPath + $SearchItem + "\"
		$SubSearch = Get-ChildItem -Path $ProgramPath -Filter "BuildVersion.ps1" -Name
		if($SubSearch.Count -eq 1) {
			$BVFound = $True
			$BV = $ProgramPath + $SubSearch
			& $BV @args
			break
		}
	}
	if(-NOT $BVFound) {
		Write-Warning "BuildVersion: Unable to locate BuildVer"
	}