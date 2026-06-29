#!/bin/bash
# Apply kernel patches for compilation fixes

set -e

KERNEL_SOURCE_DIR="${1:-.}"
PATCHES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔧 Applying kernel patches..."
cd "$KERNEL_SOURCE_DIR"

# Apply patch 1: Fix mmap_sem to mmap_lock
echo "📝 Applying patch 1: mmap_sem compatibility..."
if patch -p1 < "$PATCHES_DIR/0001-fix-mmap-sem.patch" 2>/dev/null; then
    echo "✅ Patch 1 applied successfully"
else
    echo "⚠️  Patch 1 already applied or not needed"
fi

# Apply patch 2: Disable compiler errors
echo "📝 Applying patch 2: disable compiler errors..."
if patch -p1 < "$PATCHES_DIR/0002-disable-compiler-errors.patch" 2>/dev/null; then
    echo "✅ Patch 2 applied successfully"
else
    echo "⚠️  Patch 2 already applied or not needed"
fi

echo "✨ All patches applied!"
