#!/bin/bash

siasync -address "$SIA_API_ADDRESS" \
-agent "$SIA_API_AGENT" \
-archive $SIASYNC_ARCHIVE \
-debug $SIASYNC_DEBUG \
-subfolder "$SIASYNC_SUBFOLDER" \
-include "$SIASYNC_INCLUDE" \
-include-hidden $SIASYNC_INCLUDE_HIDDEN \
-exlude "$SIASYNC_EXCLUDE" \
-data-pieces $SIASYNC_DATA_PIECES \
-parity-pieces $SIASYNC_PARITY_PIECES \
-size-only $SIASYNC_SIZE_ONLY \
-sync-only $SIASYNC_SYNC_ONLY \
-dry-run $SIASYNC_DRY_RUN \
"$@"

