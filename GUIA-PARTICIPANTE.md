# Guía del participante — Lab AstroShop AI

# Lab 2


* **Ambiente:** Dynatrace ulk04354 
* **Objetivo:** Autoremediación usando MCP + dtctl


## Objetivo 

En este lab aprenderás a usar el agente de IA no solo para consultar datos, sino para crear recursos en Dynatrace a partir de una investigación: partiendo de un incidente detectado, le pedirás que documente los hallazgos en un notebook, defina un SLO de disponibilidad para el servicio afectado y arme un dashboard de monitoreo. La meta es que el agente convierta el diagnóstico en artefactos concretos y reutilizables de observabilidad, usando la herramienta correcta para cada tarea hasta completar la autoremediación del problema integrandose con otras herramientas.

#
Flujo de trabajo:
1. Investigar un incidente
2. Documentarlo con dtctl
3. Proponer el fix con un Pull Request
4. Verificar que se resolvió

#
---
#


## Paso 1  - Configurar el workspace

1. Ubicar el archivo  `.mcp.json` y descomentar el bloque de `dynatrace-lab`
2. Abrir la terminal y ejecutar el siguiente comando: esto creará el instruction file de este nuevo laboratorio
  * Reemplazar el X por el identificador dado a cada participante `CLAUDE-01, CLAUDE-02, CLAUDE-03, etc`
```
cp CLAUDE-0X.md CLAUDE.md
```
3. Abrir la paleta de comandos (`Ctrl+Shift+P`) y ejecuta **Reload Window**. Para que cargue los cambios.
4. Abrir el Chat `Ctrl+Alt+I` → Cambiar a Claude Code
5. Autenticarse con la cuenta de la suscripción
6. Preguntar algo como: 
```
¿A qué tenant de Dynatrace estoy conectado?
```

#
---
#

# Ejercico 1 - Investigación Inicial

`Prompt`:
```
¿Cómo está el namespace astroshop en este momento?
```



## Ejercico 2 — Analisis Causa Raiz

`Prompt`:
```
¿Cómo llegaste a esa conclusión? ¿Puedes ubicar en el código dónde se origina esto?
```

## Ejercico 3 — Documentar Hallazgos

`Prompt`:
```
Documenta este incidente para el equipo de la siguiente manera:
* Crea un notebook en el ambiente de Dynatrace con todo el analisis realizado, agrega las consultas DQL y causa raíz. 
* Deja el notebook publico para que todos en el ambiente lo puedan ver.
```

## Ejercico 3 — Crear Artefactos de Observabilidad

`Prompt`:
```
Necesitamos vigilar mejor este servicio a futuro. Crea un SLO  de disponibilidad para el servicio payment que aparece afectado en el problema activo, hazlo en el ambiente de Dynatrace.
```

`Prompt`:
```
Necesito que cada vez que este servicio se degrade me llegue una notificación a mi correo: example@gmail.com, crea una alerta en el ambiente de Dynatrace para que se notifique el problema.
```

`Prompt`:
```
Crea un Dashboard base de observabilidad en el ambiente de Dynatrace donde pueda ver la salud de mi aplicación.
Deja el dashboard publico para que todos puedan verlo.
```

## Ejercico 4 — Proponer Fix

`Prompt`:
```
Necesitamos resolver esto. Prepara el cambio para que lo revise antes de aplicarlo.
```


## Ejercico 4 — Validacion de la resolución

`Prompt`:
```
Ya apliqué el cambio. ¿Se resolvió?
```


