# Guía del participante — Lab AstroShop AI

Bienvenido. Sigue estos pasos para tener tu entorno listo. Toma ~5 minutos.

Tu número de participante te lo asigna el instructor (01, 02 o 03).
En esta guía, reemplaza **0X** por tu número.

---

## Paso 1 — Abre tu Codespace

1. Entra al repositorio del lab (el instructor te da el link).
2. Botón verde **Code** → pestaña **Codespaces** → **Create codespace on main**.
3. Espera 2-3 minutos mientras se construye tu máquina. Se abrirá un VS Code
   en el navegador con todo instalado.

---

## Paso 2 — Activa tu instruction file

En la terminal del Codespace (abajo), ejecuta (reemplaza 0X por tu número):

```bash
cp CLAUDE-0X.md CLAUDE.md
```

Esto le dice al agente que trabaje en TU namespace (astroshop-0X).

---

## Paso 3 — Configura tus tokens

Abre el archivo `.vscode/mcp.json` y reemplaza los marcadores:

- `TU_TOKEN_DYNATRACE` → tu Platform Token de Dynatrace
- `TU_TOKEN_GITHUB` → tu Personal Access Token de GitHub

Guarda el archivo.

---

## Paso 4 — Autentica dtctl

En la terminal:

```bash
dtctl auth login --context astroshop --environment "URL_DEL_TENANT"
```

(El instructor te da la URL del tenant.) Se abrirá una ventana para autenticarte.

---

## Paso 5 — Abre Claude y verifica

1. Abre Claude Code (ícono en la barra lateral, o Ctrl+Shift+P → "Claude").
2. Pregúntale para confirmar que todo quedó bien:

   > ¿Cuál es mi namespace de trabajo?

   Debe responder **astroshop-0X** (tu número).

---

## ¡Listo!

Ya puedes empezar el ejercicio. El instructor te guiará desde aquí.

Tu flujo será:
1. Investigar un incidente con el MCP de Dynatrace
2. Documentarlo con dtctl
3. Proponer el fix con un Pull Request
4. Verificar que se resolvió
