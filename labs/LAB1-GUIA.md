# Lab 1 


* **Ambiente:** Dynatrace Playground (AstroShop) — MCP `dynatrace-playground`
* **Objetivo:** aprender a construir un instruction file que convierte a un agente genérico en un analista de observabilidad riguroso y eficiente.


## La idea del lab

Un agente de IA sin contexto es como un analista nuevo brillante que no conoce tu
ambiente: sabe DQL en general, pero no sabe TU aplicación, ni tu método, ni tus
reglas. El instruction file es el manual que le das.

En este lab construyes ese manual en **5 pasos**. En cada paso agregas una capa y
observas cómo el agente analiza mejor: más enfocado, más eficiente y más honesto.

#
---
#

## Habilitar el entorno

## Repositorios

* [Repo con Claude](https://github.com/leidyruizrr/lcrr-astroshop-participantes) 


## Paso 1 - token de Github
* Crear Token de Github en la ruta [Link](https://github.com/settings/personal-access-tokens)
* Developer settings → Personal access tokens → Fine-grained tokens
* Generate new token
* Repository access: All repositories
* Permissions → Repository: Contents (Read/write) y Pull requests (Read/write)
* Generate token → copiar el token y guardarlo

## Paso 2 - Crear el Codespace

1. Entrar al link del repositorio [Repo con Claude](https://github.com/leidyruizrr/lcrr-astroshop-participantes)
2. Haz clic en el botón verde **Code**.
3. Selecciona la pestaña **Codespaces**.
4. Haz clic en **Create codespace on main**.
5. Espera 2-3 minutos mientras GitHub prepara el entorno (se abrirá VS Code en el navegador).


## Paso 3  - Iniciar el Workspace & Iniciar el MCP server

1. Ubicar el archivo  `.mcp.json` y agregar el Token de Github creado previamente
2. Abrir la terminal y ejecutar el comando `cp labs/LAB1-paso-0.md CLAUDE.md` esto creará el archivo de instrucciones base.
3. Abrir la paleta de comandos (`Ctrl+Shift+P`) y ejecuta **Reload Window**. Para que cargue los cambios.
4. Abrir el Chat `Ctrl+Alt+I` → Cambiar a Claude Code
5. Autenticarse con la cuenta de la suscripción
6. Preguntar algo como: 
```
¿A qué tenant de Dynatrace estoy conectado?
```
> IMPORTANTE: cada vez que edites `CLAUDE.md`,
> **abre un chat NUEVO** para que relea el archivo.

#
---
#

# Ejercico 1 - (Herramientas + Ambiente)

`Prompt de Referencia`:
```
Analiza los problemas que ha tenido la aplicación astroshop en las últimas 2 horas, identifica el problema más crítico, explícame la causa raíz, muestra las consultas realizadas y sus resultados.
```

---

## Ejercico 2 — Método de análisis y las fuentes de datos

Reemplaza tu instruction file por el del paso 1:
```
cp labs/LAB1-paso-1.md CLAUDE.md
```
(O agrega tú mismo las secciones "Método de análisis" y "Fuentes de datos".)

Abre chat nuevo, lanza el prompt de referencia.



---

## Ejercico 3 — Tips y Reglas de eficiencia

Reemplaza tu instruction file por el del paso 2:
```
cp labs/LAB1-paso-2.md CLAUDE.md
```

Abre chat nuevo, lanza el prompt de referencia.


---

## Paso 4 — Rigor (anti-alucinación) y Formato de salida

Reemplaza tu instruction file por el del paso 3:

```
cp labs/LAB1-paso-3.md CLAUDE.md
```

Abre chat nuevo, lanza el prompt de referencia.

---


## Si te quedas atrás

Copia el paso correspondiente y continúa:
```
cp labs/LAB1-paso-0.md CLAUDE.md
cp labs/LAB1-paso-1.md CLAUDE.md
cp labs/LAB1-paso-2.md CLAUDE.md
cp labs/LAB1-paso-3.md CLAUDE.md
cp labs/LAB1-paso-4.md CLAUDE.md
```