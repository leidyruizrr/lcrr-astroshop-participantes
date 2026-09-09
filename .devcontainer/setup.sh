#!/bin/bash
# Se ejecuta automáticamente al crear el Codespace.
# Instala dtctl, el skill, configura dtctl e inyecta el token de Dynatrace en el mcp.json.

set -e
echo "=== Configurando el entorno del lab ==="

# --- 1. Instalar dtctl ---
echo "[1/4] Instalando dtctl..."
curl -fsSL https://raw.githubusercontent.com/dynatrace-oss/dtctl/main/install.sh | bash || echo "   (revisa dtctl manualmente si falló)"
export PATH="$PATH:$HOME/.local/bin"

# --- 2. Instalar el skill de dtctl para Claude ---
echo "[2/4] Instalando el skill de dtctl para Claude..."
dtctl skills install --for claude 2>/dev/null || echo "   (instala el skill con: dtctl skills install --for claude)"

# --- 3. Configurar dtctl con el token de Dynatrace ---
echo "[3/4] Configurando dtctl..."
if [ -n "$DT_PLATFORM_TOKEN" ]; then
  echo 'export DTCTL_TOKEN_STORAGE=file' >> ~/.bashrc
  export DTCTL_TOKEN_STORAGE=file
  dtctl config set-credentials lab-token --token "$DT_PLATFORM_TOKEN" 2>/dev/null
  dtctl config set-context astroshop \
    --environment "https://ulk04354.sprint.apps.dynatracelabs.com" \
    --token-ref lab-token 2>/dev/null
  dtctl config use-context astroshop 2>/dev/null
  echo "   dtctl configurado."
else
  echo "   AVISO: no se encontró DT_PLATFORM_TOKEN."
fi

# --- 4. Inyectar el token de Dynatrace en el mcp.json ---
echo "[4/4] Configurando el MCP de Dynatrace..."
if [ -n "$DT_PLATFORM_TOKEN" ] && [ -f ".vscode/mcp.json" ]; then
  sed -i "s|TU_TOKEN_DYNATRACE|${DT_PLATFORM_TOKEN}|g" .vscode/mcp.json
  echo "   Token de Dynatrace inyectado en el MCP."
else
  echo "   AVISO: no se pudo inyectar el token de Dynatrace en el mcp.json."
fi

echo ""
echo "=========================================="
echo "  Entorno listo"
echo "=========================================="
echo "El MCP de Dynatrace y dtctl ya estan configurados."
echo ""
echo "Solo faltan 3 pasos:"
echo "  1. Copia tu instruction file:   cp CLAUDE-0X.md CLAUDE.md   (X = tu numero)"
echo "  2. Pon tu token de GitHub en .vscode/mcp.json (reemplaza TU_TOKEN_GITHUB)"
echo "  3. Recarga la ventana:  Ctrl+Shift+P > Reload Window"
echo ""
