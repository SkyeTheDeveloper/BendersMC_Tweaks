#!/usr/bin/env bash
set -euo pipefail

readonly CURRENT_VERSION="1.2.2"
readonly MIN_MC_VERSION="26.1"
readonly MAX_MC_VERSION="26.2"
readonly FILE_NAME="BendersMC_Tweaks-${CURRENT_VERSION}-${MIN_MC_VERSION}_${MAX_MC_VERSION}.zip"
readonly FILE_DESTINATION="zipped_packs"

echo "Zipping BendersMC Tweaks v${CURRENT_VERSION} for Minecraft ${MIN_MC_VERSION}-${MAX_MC_VERSION}..."

if zip -9 -r -q "${FILE_NAME}" assets/ LICENSE NOTICE.md pack.mcmeta pack.png; then
    mkdir -p "${FILE_DESTINATION}"
    if mv -f "${FILE_NAME}" "${FILE_DESTINATION}/"; then
        echo "BendersMC Tweaks was zipped and moved into the ${FILE_DESTINATION} folder!"
    else
        printf "Moving file to %s failed...\n" "${FILE_DESTINATION}"
        exit 1
    fi
else
    printf "Zipping failed...\nRe-clone this repository and re-run this script...\n"
    exit 1
fi