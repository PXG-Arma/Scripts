@echo off
@title PXG Registry Generator (v2.9)
@cd /d "%~dp0"

@:: Start the Generator Logic (Executing lines starting with ::: as a single block)
@powershell -NoProfile -ExecutionPolicy Bypass -Command "$f='%~f0'; $c = (Get-Content $f | Where-Object { $_ -like '::: *' } | ForEach-Object { $_ -replace '^::: ?', '' }) -join [Environment]::NewLine; if($c){ Invoke-Expression $c }"

@exit /b

::: $root = Get-Item "."
::: $registryFile = "Factions_Registry.sqf"
::: $factionFiles = @('Loadoutlist.sqf', 'Supplies.sqf', 'Weapons.sqf', 'Ammo.sqf', 'Uniforms.sqf', 'Gear.sqf', 'Vehicles.sqf', 'Vehicles_recolour.sqf')
::: 
::: # Pre-Read Registry for Delta Analysis
::: $legacy = @{}
::: if (Test-Path $registryFile) {
:::     try {
:::         $raw = Get-Content $registryFile -Raw
:::         $matches = [regex]::Matches($raw, '\[\s*"([^"]+)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*\]')
:::         foreach ($m in $matches) {
:::             $id = ($m.Groups[1].Value, $m.Groups[2].Value, $m.Groups[3].Value, $m.Groups[4].Value, $m.Groups[5].Value) | ForEach-Object { $_.Trim() }
:::             $legacy[$id -join "|"] = $true
:::         }
:::     } catch { }
::: }
::: 
::: Write-Host "Scanning factions in: $($root.FullName)..." -ForegroundColor Cyan
::: 
::: # Discovery logic
::: $foundPaths = Get-ChildItem -Path $root.FullName -Recurse -File -ErrorAction SilentlyContinue | Where-Object { 
:::     $factionFiles -contains $_.Name -and $_.FullName -notlike '*\common\*' 
::: } | Select-Object -ExpandProperty DirectoryName -Unique
::: 
::: $registryData = @()
::: foreach ($p in $foundPaths) {
:::     $rel = $p.Replace($root.FullName, "").TrimStart("\").TrimStart("/")
:::     $parts = $rel -split '[\\/]'
:::     $side = $parts[0].ToUpper()
:::     $fac = if($parts.Count -gt 1){ $parts[1] } else { "" }
:::     
:::     $obj = [PSCustomObject]@{ Side=$side; Faction=$fac; Sub=""; Era=""; Camo=""; Status="NEW" }
:::     $rem = $parts | Select-Object -Skip 2
:::     
:::     if ($rem.Count -ge 3){ $obj.Sub=$rem[0]; $obj.Era=$rem[1]; $obj.Camo=$rem[2] }
:::     elseif ($rem.Count -eq 2){ $obj.Era=$rem[0]; $obj.Camo=$rem[1] }
:::     elseif ($rem.Count -eq 1){ $obj.Era=$rem[0] }
:::     
:::     $id = ($obj.Side, $obj.Faction, $obj.Sub, $obj.Era, $obj.Camo) -join "|"
:::     if ($legacy.ContainsKey($id)){ $obj.Status="UNCHANGED"; $legacy.Remove($id) }
:::     $registryData += $obj
::: }
::: 
::: $removed = @()
::: foreach ($key in $legacy.Keys) {
:::     $p = $key -split '\|'
:::     $removed += [PSCustomObject]@{ Side=$p[0]; Faction=$p[1]; Sub=$p[2]; Era=$p[3]; Camo=$p[4]; Status="REMOVED" }
::: }
::: 
::: # Explicit Sorting for consistent file output
::: $registryData = $registryData | Sort-Object -Property Side, Faction, Sub, Era, Camo
::: 
::: # Reporting & Row Building
::: Write-Host "`nDELTA REPORT:" -ForegroundColor Cyan
::: Write-Host ("-" * 102)
::: 
::: $currentSide = ""
::: $fileRows = @()
::: foreach ($e in $registryData) {
:::     if ($e.Side -ne $currentSide) {
:::         $currentSide = $e.Side
:::         $fileRows += ""
:::         $fileRows += "    //                        --$currentSide--"
:::     }
:::     
:::     # Console Display
:::     $disp = if ($e.Sub) { "$($e.Faction) ($($e.Sub))" } else { $e.Faction }
:::     $color = "Gray"
:::     if($e.Status -eq "NEW"){$color="Green"} elseif($e.Status -eq "UNCHANGED"){$color="Yellow"}
:::     Write-Host (" [{0,-9}] {1,-10} | {2,-45} | Era: {3,-10} | Camo: {4}" -f $e.Status, $e.Side, $disp, $e.Era, $e.Camo) -ForegroundColor $color
:::     
:::     # Row Construction
:::     $qS = "`"$($e.Side)`"".PadRight(10)
:::     $qF = "`"$($e.Faction)`"".PadRight(25)
:::     $qSub = "`"$($e.Sub)`"".PadRight(15)
:::     $qE = "`"$($e.Era)`"".PadRight(12)
:::     $qC = "`"$($e.Camo)`"".PadRight(12)
:::     $fileRows += "    [$qS,  $qF,  $qSub,  $qE,  $qC]"
::: }
::: 
::: foreach ($r in $removed) {
:::     $disp = if ($r.Sub) { "$($r.Faction) ($($r.Sub))" } else { $r.Faction }
:::     Write-Host (" [REMOVED  ] {0,-10} | {1,-45} | Era: {2,-10} | Camo: {1}" -f $r.Side, $disp, $r.Era, $r.Camo) -ForegroundColor Red
::: }
::: Write-Host ("-" * 102)
::: 
::: # Finalization & Writing
::: if ($registryData.Count -gt 0) {
:::     $contentBody = @()
:::     for ($i=0; $i -lt $fileRows.Count; $i++) {
:::         $line = $fileRows[$i]
:::         if ($line -match "\[") {
:::             $isLastEntry = $true
:::             for ($k=$i+1; $k -lt $fileRows.Count; $k++){ if($fileRows[$k] -match "\["){$isLastEntry=$false; break} }
:::             if (-not $isLastEntry) { $line += "," }
:::         }
:::         $contentBody += $line
:::     }
:::     
:::     $header = "/*`n    PXG Faction Master Registry`n    ----------------------------`n    AUTO-GENERATED ON: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n*/`n`n["
:::     $content = $header + ($contentBody -join "`n") + "`n]"
:::     [System.IO.File]::WriteAllText($registryFile, $content)
:::     Write-Host "`nSuccess: Registry updated. (New=$(($registryData|? Status -eq 'NEW').Count) | Removed=$($removed.Count))"
::: } else {
:::     Write-Host "`nWarning: No factions found. Registry not modified." -ForegroundColor Red
::: }
::: 
::: # --- Smart Exit Section ---
::: Write-Host "`nGenerator Finished." -ForegroundColor Cyan
::: $timeout = 5
::: $timer = [Diagnostics.Stopwatch]::StartNew()
::: $keep = $false
::: while ($timer.Elapsed.TotalSeconds -lt $timeout) {
:::     if ($Host.UI.RawUI.KeyAvailable) {
:::         $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
:::         if ($k.Character -eq 'k' -or $k.Character -eq 'K') { $keep = $true; break }
:::     }
:::     $rem = [math]::Max(0, [math]::Ceiling($timeout - $timer.Elapsed.TotalSeconds))
:::     Write-Host ("`rClosing in $rem seconds... Press [K] to KEEP window open.   ") -NoNewline
:::     Start-Sleep -m 100
::: }
::: if ($keep) {
:::     Write-Host "`n`n[KEEP] Window staying open. Press [ENTER] or [ESC] to exit." -ForegroundColor Green
:::     $Host.UI.RawUI.FlushInputBuffer()
:::     while ($true) {
:::         if ($Host.UI.RawUI.KeyAvailable) {
:::             $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
:::             if ($k.VirtualKeyCode -eq 27 -or $k.VirtualKeyCode -eq 13) { break }
:::         }
:::         Start-Sleep -m 100
:::     }
::: }
