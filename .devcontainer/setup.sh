#!/bin/bash
# Se ejecuta automáticamente al crear el Codespace.
# Instala dtctl y el skill de dtctl para Claude.

set -e
echo "=== Configurando el entorno del lab ==="

# Instalar dtctl (Linux)
echo "[1/2] Instalando dtctl..."
curl -fsSL https://raw.githubusercontent.com/dynatrace-oss/dtctl/main/install.sh | bash || echo "   (revisa la instalación de dtctl manualmente si falló)"

# Instalar el skill de dtctl para Claude (scope proyecto)
echo "[2/2] Instalando el skill de dtctl para Claude..."
export PATH="$PATH:$HOME/.local/bin"
dtctl skills install --for claude 2>/dev/null || echo "   (instala el skill manualmente con: dtctl skills install --for claude)"

echo ""
echo "=== Entorno listo ==="
echo "Recuerda:"
echo "  1. Copia el instruction file de tu participante:  cp CLAUDE-0X.md CLAUDE.md"
echo "  2. Autentica dtctl:  dtctl auth login --context astroshop --environment <URL>"
echo "  3. Configura tus tokens en .vscode/mcp.json"
