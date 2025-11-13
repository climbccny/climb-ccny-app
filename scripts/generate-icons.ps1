Param(
  [string]$Source = "public\favicon.png"
)

Write-Host "Generating icon variants from: $Source"

if (-not (Test-Path $Source)) {
  Write-Error "Source file not found: $Source. Place your PNG at public\\favicon.png or pass -Source <path>."
  exit 1
}

$magick = Get-Command magick -ErrorAction SilentlyContinue
if (-not $magick) {
  Write-Error "ImageMagick 'magick' not found. Install from https://imagemagick.org or via Chocolatey: choco install imagemagick"
  exit 1
}

$publicDir = "public"
if (-not (Test-Path $publicDir)) { New-Item -ItemType Directory -Path $publicDir | Out-Null }

$apple = Join-Path $publicDir "apple-touch-icon.png"
$fav16 = Join-Path $publicDir "favicon-16x16.png"
$fav32 = Join-Path $publicDir "favicon-32x32.png"
$ico   = Join-Path $publicDir "favicon.ico"

# Create 180x180 Apple touch icon (square canvas)
magick "$Source" -resize 180x180 -background none -gravity center -extent 180x180 "$apple"
if ($LASTEXITCODE -ne 0) { Write-Error "Failed creating $apple"; exit 1 }

# Create 16px and 32px PNGs (square canvas)
magick "$Source" -resize 16x16 -background none -gravity center -extent 16x16 "$fav16"
if ($LASTEXITCODE -ne 0) { Write-Error "Failed creating $fav16"; exit 1 }
magick "$Source" -resize 32x32 -background none -gravity center -extent 32x32 "$fav32"
if ($LASTEXITCODE -ne 0) { Write-Error "Failed creating $fav32"; exit 1 }

# Build multi-size ICO
magick "$fav16" "$fav32" "$ico"
if ($LASTEXITCODE -ne 0) { Write-Error "Failed creating $ico"; exit 1 }

Write-Host "Done. Generated:"
Write-Host " - $apple"
Write-Host " - $fav16"
Write-Host " - $fav32"
Write-Host " - $ico"
