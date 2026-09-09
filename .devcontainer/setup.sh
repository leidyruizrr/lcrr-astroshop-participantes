#!/bin/bash
# Se ejecuta automáticamente al crear el Codespace.
# Instala dtctl, el skill, y configura dtctl con el token de Dynatrace.

set -e
echo "=== Configurando el entorno del lab ==="

# --- 1. Instalar dtctl ---
echo "[1/3] Instalando dtctl..."
curl -fsSL https://raw.githubusercontent.com/dynatrace-oss/dtctl/main/install.sh | bash || echo "   (revisa dtctl manualmente si falló)"
export PATH="$PATH:$HOME/.local/bin"

# --- 2. Instalar el skill de dtctl para Claude ---
echo "[2/3] Instalando el skill de dtctl para Claude..."
dtctl skills install --for claude 2>/dev/null || echo "   (instala el skill con: dtctl skills install --for claude)"

# --- 3. Configurar dtctl con el token de Dynatrace (desde el Codespaces Secret) ---
echo "[3/3] Configurando dtctl..."
if [ -n "$DT_PLATFORM_TOKEN" ]; then
  # Persistir la variable de storage para futuras sesiones de terminal
  echo 'export DTCTL_TOKEN_STORAGE=file' >> ~/.bashrc
  export DTCTL_TOKEN_STORAGE=file

  dtctl config set-credentials lab-token --token "$DT_PLATFORM_TOKEN" 2>/dev/null
  dtctl config set-context astroshop \
    --environment "https://ulk04354.sprint.apps.dynatracelabs.com" \
    --token-ref lab-token 2>/dev/null
  dtctl config use-context astroshop 2>/dev/null
  echo "   dtctl configurado y listo."
else
  echo "   AVISO: no se encontró DT_PLATFORM_TOKEN. Configura dtctl manualmente."
fi

echo ""
echo "=========================================="
echo "  Entorno listo"
echo "=========================================="
echo "Faltan solo 2 pasos manuales:"
echo "  1. Copia tu instruction file:   cp CLAUDE-0X.md CLAUDE.md   (X = tu número)"
echo "  2. Pon tus tokens en .vscode/mcp.json  y recarga la ventana (Ctrl+Shift+P > Reload Window)"
echo ""
