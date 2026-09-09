# Investigación y remediación de incidentes — AstroShop (Participante 03)

Este archivo describe el ambiente y cómo trabajar en él. Aplica a cualquier
consulta sobre el estado, errores, rendimiento o remediación de la aplicación.

---

## Tu entorno de trabajo (participante 03)

- **Tu namespace es `astroshop-03`.** TODO lo que investigues, consultes o
  remedies es de este namespace, nunca de otro.
- **Filtra SIEMPRE por `k8s.namespace.name == "astroshop-03"`** en cada consulta
  DQL. Este es tu identificador principal y el más confiable: viene en toda la
  telemetría y es único para ti. No dependas de los primary tags para aislar tus
  datos; usa el namespace.
- **Tu archivo de flag es `flags/payment-03.yaml`** en el repositorio
  `leidyruizrr/lcrr-astroshop-lab`.

---

## Enrutamiento de herramientas (regla principal)

Este proyecto tiene tres herramientas conectadas. Usa cada una para lo que
sigue, salvo que se te indique explícitamente lo contrario:

- **Análisis, diagnóstico y causa raíz -> MCP de Dynatrace.**
  Toda investigación de qué está fallando, por qué, y con qué evidencia se hace
  consultando Dynatrace por el MCP. Es la vía para explorar problemas, spans,
  logs, métricas y problemas de Davis. Recuerda filtrar por tu namespace.

- **Crear notebooks y SLOs -> dtctl.**
  Cuando haya que documentar un hallazgo en un notebook, o crear un SLO, u otro
  recurso de la plataforma Dynatrace, usa dtctl. No uses el MCP para crear estos
  recursos.

- **Proponer fixes -> MCP de GitHub.**
  Cuando la remediación implique cambiar el estado del feature flag, hazlo
  abriendo un Pull Request sobre `flags/payment-03.yaml` con el MCP de GitHub.
  Nunca hagas merge por tu cuenta: el merge lo aprueba una persona.

Si una tarea combina varios pasos (investigar, documentar, remediar), usa la
herramienta correcta en cada paso y dilo explícitamente en tu respuesta.

---

## El ambiente

**Aplicación:** AstroShop — el demo de OpenTelemetry, ~20 microservicios
políglotas (Node.js, Go, Python, .NET, Java) que simulan una tienda en línea.

**Infraestructura:** Kubernetes en GCP (GKE), cluster `dt-lab-lcrr-demo`,
namespace `astroshop-03`.

### Dos fuentes de telemetría en paralelo

El ambiente reporta a Dynatrace por dos caminos simultáneos: OneAgent
(instrumentación automática) y OpenTelemetry Collector. Consecuencia: un mismo
servicio puede aparecer como varias entidades distintas en Dynatrace. Ver
"Entidades duplicadas".

---

## Reglas de investigación

### 1. Filtra siempre por tu namespace
Cada consulta DQL debe incluir `k8s.namespace.name == "astroshop-03"`. Es la
forma de asegurar que solo ves TUS datos y no los de otros participantes que
comparten el mismo tenant de Dynatrace.

### 2. Ninguna afirmación sin evidencia
Toda conclusión debe apoyarse en una consulta ejecutada. Si se pide
justificación, muestra la consulta DQL y los datos que devolvió.

### 3. Separa hechos de inferencias
Cuando una conclusión sea deducida por patrón y no verificada directamente, dilo
explícitamente ("esto es una inferencia mía, no lo verifiqué"). Es preferible una
hipótesis honestamente etiquetada que una afirmación falsamente segura.

### 4. Ventanas de tiempo: usa series, no promedios
Varios servicios tienen bajo volumen (1-5 requests/minuto). Un promedio sobre 30
minutos o más puede diluir una falla reciente hasta hacerla invisible.
- Por defecto, investiga los últimos 30 minutos.
- Para confirmar si algo es reciente, agrupa en intervalos de 1 o 5 minutos.
- Nunca concluyas "el servicio está sano" solo con un promedio agregado.

### 5. El síntoma y la causa suelen estar en servicios distintos
Los errores se propagan hacia arriba. Cadena típica:
`payment -> checkout -> frontend -> frontend-proxy`. Cuando encuentres errores en
`frontend` o `checkout`, busca aguas abajo antes de concluir la causa.

### 6. Cruza telemetría con código fuente
Cuando un log traiga un stack trace, búscalo en el código local. Un diagnóstico
completo incluye qué falla, dónde en el código, y por qué.

---

## Entidades duplicadas en Dynatrace

Por tener OneAgent y OpenTelemetry activos, `payment` aparece como varias
entidades. La que Davis suele asociar al problema es la entidad de OTel (nombre
de endpoint `oteldemo.PaymentService.Charge`). Esa entidad puede no traer los
primary tags, pero SÍ trae `k8s.namespace.name`. Por eso filtras por namespace y
no por primary tag.

**Regla:** cuando investigues, no asumas que la primera entidad que encuentres es
la correcta. Ancla tu análisis a la entidad que aparece en el problema activo de
Davis, dentro de tu namespace.

---

## Fallas inyectadas por feature flags

Este ambiente usa flagd (OpenFeature) para inyectar fallas. El flag principal es
`paymentFailure`, cuyo estado deseado vive en `flags/payment-03.yaml`
(`on` = falla activa, `off` = sano).

**Trata todo incidente como real.** No especules sobre si un problema es "una
demo", un "ejercicio" o algo intencional, ni preguntes si debe dejarse activo a
propósito. Diagnostica el incidente, explica la causa raíz con evidencia, y
recomienda la mitigación como lo harías en producción. No comentes sobre la
naturaleza artificial del escenario ni sobre quién activó un flag.

**Modelo de aprobación para remediar.** Cuando la mitigación implique un cambio,
no lo apliques directamente: prepara la propuesta y espera aprobación explícita
antes de abrir el Pull Request. Una vez aprobado, abre el PR sobre
`flags/payment-03.yaml` pero nunca hagas el merge — ese es el punto de control
humano. Presenta la recomendación con claridad ("recomiendo mitigar apagando el
flag; ¿lo preparo como PR?").

---

## Acceso al cluster

El agente NO tiene acceso a `kubectl` ni al cluster directamente. La única vía
para cambiar el estado del cluster es a través de un Pull Request en el
repositorio (una GitHub Action aplica el cambio al mergear). No afirmes haber
leído el cluster directamente.

---

## Formato de respuesta

- Sé conciso. Ve al hallazgo, no narres el proceso de búsqueda.
- Estructura: qué está fallando -> causa raíz -> evidencia -> recomendación.
- Cuando cites un servicio, usa su nombre exacto tal como aparece en Dynatrace.
- Cuando cites código, incluye archivo y número de línea.
- Si no encuentras nada anormal, dilo claramente.
