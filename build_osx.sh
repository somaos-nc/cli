#!/bin/bash

# Configuration
APP_NAME="Cli"
VERSION="1.0.2"
BUNDLE_ID="com.gemini.cli"
BUNDLE_DIR="${APP_NAME}.app"
CONTENTS_DIR="${BUNDLE_DIR}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"
RESOURCES_DIR="${CONTENTS_DIR}/Resources"

echo "Building ${APP_NAME} v${VERSION} for macOS..."

# 1. Build the binary
make -f Makefile.macos clean
make -f Makefile.macos

if [ ! -f cli ]; then
    echo "Error: Build failed."
    exit 1
fi

# 2. Create bundle structure
rm -rf "${BUNDLE_DIR}"
mkdir -p "${MACOS_DIR}"
mkdir -p "${RESOURCES_DIR}/assets/fonts"

# 3. Copy binary and assets
mv cli "${MACOS_DIR}/${APP_NAME}"
cp assets/icon.png "${RESOURCES_DIR}/"
cp assets/fonts/UbuntuMono-Regular.ttf "${RESOURCES_DIR}/assets/fonts/"

# 4. Create Info.plist
cat > "${CONTENTS_DIR}/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>${BUNDLE_ID}</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleVersion</key>
    <string>${VERSION}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleIconFile</key>
    <string>icon.png</string>
</dict>
</plist>
EOF

# 5. Create DMG
echo "Creating DMG..."
mkdir -p releases
DMG_NAME="releases/cli_${VERSION}_macOS.dmg"
rm -f "${DMG_NAME}"

# Create a temporary directory for the DMG content
TMP_DMG_DIR="dmg_content"
rm -rf "${TMP_DMG_DIR}"
mkdir -p "${TMP_DMG_DIR}"
cp -R "${BUNDLE_DIR}" "${TMP_DMG_DIR}/"

hdiutil create -volname "${APP_NAME}" -srcfolder "${TMP_DMG_DIR}" -ov -format UDZO "${DMG_NAME}"

echo "Cleaning up..."
rm -rf "${TMP_DMG_DIR}"
# Keep the .app bundle for now if needed, but DMG is the goal

echo "Done! DMG created at ${DMG_NAME}"
