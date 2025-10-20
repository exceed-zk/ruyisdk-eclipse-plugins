# RuyiSDK Eclipse 插件版本更新脚本 (PowerShell)
# 用法: .\update-version.ps1 <新版本号>
# 例如: .\update-version.ps1 0.0.5

param(
    [Parameter(Mandatory=$true)]
    [string]$NewVersion
)

$ErrorActionPreference = "Stop"

$QualifierVersion = "$NewVersion.qualifier"
$SnapshotVersion = "$NewVersion-SNAPSHOT"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "更新版本号到: $NewVersion" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 更新根 pom.xml
Write-Host "📝 更新根 pom.xml..." -ForegroundColor Yellow
$content = Get-Content "pom.xml" -Raw
$content = $content -replace '<version>[0-9]+\.[0-9]+\.[0-9]+-SNAPSHOT</version>', "<version>$SnapshotVersion</version>"
Set-Content "pom.xml" $content -NoNewline

# 2. 更新 feature.xml
Write-Host "📝 更新 feature.xml..." -ForegroundColor Yellow
$featureXml = "features\org.ruyisdk.feature\feature.xml"
if (Test-Path $featureXml) {
    $content = Get-Content $featureXml -Raw
    $content = $content -replace 'version="[0-9]+\.[0-9]+\.[0-9]+\.qualifier"', "version=`"$QualifierVersion`""
    Set-Content $featureXml $content -NoNewline
}

# 3. 更新 category.xml
Write-Host "📝 更新 category.xml..." -ForegroundColor Yellow
$categoryXml = "repository\category.xml"
if (Test-Path $categoryXml) {
    $content = Get-Content $categoryXml -Raw
    $content = $content -replace 'version="[0-9]+\.[0-9]+\.[0-9]+\.qualifier"', "version=`"$QualifierVersion`""
    Set-Content $categoryXml $content -NoNewline
}

# 4. 更新所有插件的 MANIFEST.MF
Write-Host "📝 更新所有插件的 MANIFEST.MF..." -ForegroundColor Yellow
Get-ChildItem -Path "plugins" -Filter "MANIFEST.MF" -Recurse | ForEach-Object {
    Write-Host "   - $($_.FullName)" -ForegroundColor Gray
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace 'Bundle-Version: [0-9]+\.[0-9]+\.[0-9]+\.qualifier', "Bundle-Version: $QualifierVersion"
    Set-Content $_.FullName $content -NoNewline
}

# 5. 更新所有模块的 pom.xml
Write-Host "📝 更新模块 pom.xml..." -ForegroundColor Yellow
$modulePoms = @(
    "features\org.ruyisdk.feature\pom.xml",
    "repository\pom.xml"
)

Get-ChildItem -Path "plugins" -Filter "pom.xml" -Recurse | ForEach-Object {
    $modulePoms += $_.FullName
}

foreach ($pom in $modulePoms) {
    if (Test-Path $pom) {
        Write-Host "   - $pom" -ForegroundColor Gray
        $content = Get-Content $pom -Raw
        $content = $content -replace '<version>[0-9]+\.[0-9]+\.[0-9]+-SNAPSHOT</version>', "<version>$SnapshotVersion</version>"
        Set-Content $pom $content -NoNewline
    }
}

Write-Host ""
Write-Host "✅ 版本更新完成！" -ForegroundColor Green
Write-Host ""
Write-Host "📋 下一步操作：" -ForegroundColor Cyan
Write-Host "   1. 检查修改: git diff"
Write-Host "   2. 本地构建测试: mvn clean verify"
Write-Host "   3. 提交更改: git add . ; git commit -m 'chore: bump version to $NewVersion'"
Write-Host "   4. 推送到远程: git push origin main"
Write-Host "   5. 创建标签: git tag v$NewVersion ; git push origin v$NewVersion"
Write-Host ""

