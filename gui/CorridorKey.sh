#!/usr/bin/env bash
# CorridorKey 2.0 desktop UI. Run it, or drag clips or folders onto it.
cd "$(dirname "$0")/.." || exit 1

# uv sync creates .venv; a manual setup may have made venv.
if [ -x ".venv/bin/python" ]; then
    PYTHON=".venv/bin/python"
elif [ -x "venv/bin/python" ]; then
    PYTHON="venv/bin/python"
else
    PYTHON="python3"
fi

if ! "$PYTHON" -c "import PySide6" 2>/dev/null; then
    echo "Installing the UI toolkit (PySide6)..."
    # uv environments have no pip, so install through uv when it is available.
    if command -v uv >/dev/null 2>&1 && [ "$PYTHON" != python3 ]; then
        uv pip install --python "$PYTHON" PySide6-Essentials || exit 1
    else
        "$PYTHON" -m pip install PySide6-Essentials || exit 1
    fi
fi

"$PYTHON" -m gui "$@"
