$projGuid = [guid]::NewGuid().ToString('B').ToUpper()
$name = '4GBPatcher'
$vcxproj = "$name.vcxproj"
$sln = "$name.sln"

$xml = @"
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <ItemGroup Label="ProjectConfigurations">
    <ProjectConfiguration Include="Debug|Win32">
      <Configuration>Debug</Configuration>
      <Platform>Win32</Platform>
    </ProjectConfiguration>
    <ProjectConfiguration Include="Release|Win32">
      <Configuration>Release</Configuration>
      <Platform>Win32</Platform>
    </ProjectConfiguration>
  </ItemGroup>
  <PropertyGroup Label="Globals">
    <VCProjectVersion>17.0</VCProjectVersion>
    <ProjectGuid>$projGuid</ProjectGuid>
    <RootNamespace>4GBPatcher</RootNamespace>
    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
  </PropertyGroup>
  <Import Project="`$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
  <PropertyGroup Condition="'`$(Configuration)|`$(Platform)'=='Debug|Win32'" Label="Configuration">
    <ConfigurationType>Application</ConfigurationType>
    <UseDebugLibraries>true</UseDebugLibraries>
    <PlatformToolset>v143</PlatformToolset>
    <CharacterSet>Unicode</CharacterSet>
  </PropertyGroup>
  <PropertyGroup Condition="'`$(Configuration)|`$(Platform)'=='Release|Win32'" Label="Configuration">
    <ConfigurationType>Application</ConfigurationType>
    <UseDebugLibraries>false</UseDebugLibraries>
    <PlatformToolset>v143</PlatformToolset>
    <CharacterSet>Unicode</CharacterSet>
  </PropertyGroup>
  <Import Project="`$(VCTargetsPath)\Microsoft.Cpp.props" />
  <ImportGroup Label="ExtensionSettings"></ImportGroup>
  <ImportGroup Label="PropertySheets" Condition="'`$(Configuration)|`$(Platform)'=='Debug|Win32'">
    <Import Project="`$(UserRootDir)\Microsoft.Cpp.`$(Platform).user.props" Condition="exists('`$(UserRootDir)\Microsoft.Cpp.`$(Platform).user.props')" Label="LocalAppDataPlatform" />
  </ImportGroup>
  <ImportGroup Label="PropertySheets" Condition="'`$(Configuration)|`$(Platform)'=='Release|Win32'">
    <Import Project="`$(UserRootDir)\Microsoft.Cpp.`$(Platform).user.props" Condition="exists('`$(UserRootDir)\Microsoft.Cpp.`$(Platform).user.props')" Label="LocalAppDataPlatform" />
  </ImportGroup>
  <ItemDefinitionGroup Condition="'`$(Configuration)|`$(Platform)'=='Debug|Win32'">
    <ClCompile>
      <WarningLevel>Level3</WarningLevel>
      <SDLCheck>true</SDLCheck>
      <PreprocessorDefinitions>_DEBUG;_WINDOWS;%(PreprocessorDefinitions)</PreprocessorDefinitions>
      <ConformanceMode>true</ConformanceMode>
      <LanguageStandard>stdcpp17</LanguageStandard>
    </ClCompile>
    <Link>
      <SubSystem>Windows</SubSystem>
      <GenerateDebugInformation>true</GenerateDebugInformation>
    </Link>
  </ItemDefinitionGroup>
  <ItemDefinitionGroup Condition="'`$(Configuration)|`$(Platform)'=='Release|Win32'">
    <ClCompile>
      <WarningLevel>Level3</WarningLevel>
      <SDLCheck>true</SDLCheck>
      <PreprocessorDefinitions>NDEBUG;_WINDOWS;%(PreprocessorDefinitions)</PreprocessorDefinitions>
      <ConformanceMode>true</ConformanceMode>
      <LanguageStandard>stdcpp17</LanguageStandard>
    </ClCompile>
    <Link>
      <SubSystem>Windows</SubSystem>
      <GenerateDebugInformation>true</GenerateDebugInformation>
    </Link>
  </ItemDefinitionGroup>
  <ItemGroup>
    <ClCompile Include="4GBPatcher.cpp" />
  </ItemGroup>
  <ItemGroup>
    <ClInclude Include="4GBPatcher.h" />
    <ClInclude Include="PathHandler.h" />
    <ClInclude Include="Resource.h" />
    <ClInclude Include="Utils.h" />
  </ItemGroup>
  <Import Project="`$(VCTargetsPath)\Microsoft.Cpp.targets" />
  <ImportGroup Label="ExtensionTargets"></ImportGroup>
</Project>
"@

$xml | Set-Content -Path $vcxproj -Encoding UTF8

$slnText = "Microsoft Visual Studio Solution File, Format Version 12.00`r`n"
$slnText += "# Visual Studio Version 17`r`n"
$slnText += "VisualStudioVersion = 17.0.0.0`r`n"
$slnText += "MinimumVisualStudioVersion = 10.0.40219.1`r`n"
$slnText += "Project(`"{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}`") = `"$name`", `"$vcxproj`", `"$projGuid`"`r`n"
$slnText += "EndProject`r`n"
$slnText += "Global`r`n"
$slnText += "`tGlobalSection(SolutionConfigurationPlatforms) = preSolution`r`n"
$slnText += "`t`tDebug|Win32 = Debug|Win32`r`n"
$slnText += "`t`tRelease|Win32 = Release|Win32`r`n"
$slnText += "`tEndGlobalSection`r`n"
$slnText += "`tGlobalSection(ProjectConfigurationPlatforms) = postSolution`r`n"
$slnText += "`t`t$projGuid.Debug|Win32.ActiveCfg = Debug|Win32`r`n"
$slnText += "`t`t$projGuid.Debug|Win32.Build.0 = Debug|Win32`r`n"
$slnText += "`t`t$projGuid.Release|Win32.ActiveCfg = Release|Win32`r`n"
$slnText += "`t`t$projGuid.Release|Win32.Build.0 = Release|Win32`r`n"
$slnText += "`tEndGlobalSection`r`n"
$slnText += "EndGlobal`r`n"

$slnText | Set-Content -Path $sln -Encoding UTF8 -NoNewline

Write-Host "Done. Open $sln in Visual Studio."
