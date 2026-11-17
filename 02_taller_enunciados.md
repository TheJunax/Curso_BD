# Taller de Consultas SQL — ISP RedAndina

**Motor:** PostgreSQL 13+ (probado en PostgreSQL 16)
**Preparación:**
1. Crear la base: `CREATE DATABASE isp_redandina;`
2. Conectarse a ella y ejecutar `01_isp_redandina.sql`:
   - psql: `psql -U postgres -d isp_redandina -f 01_isp_redandina.sql`
   - pgAdmin: clic derecho en *isp_redandina* → *Query Tool* → abrir el archivo → F5
**Fecha de referencia del taller:** 17 de noviembre de 2026 (úsela donde diga "hoy").

---

## 1. Contexto

RedAndina es un proveedor de internet en Medellín. La base de datos maneja clientes, los planes que contratan, la facturación mensual, los pagos, los tickets de soporte, los técnicos y los equipos instalados (ONT, routers, antenas).

## 2. Modelo de datos

| Tabla | Descripción | Relaciones |
|---|---|---|
| `barrios` | Barrio y comuna | — |
| `planes` | Nombre, velocidad (Mbps), precio, tipo (Hogar/Empresarial) | — |
| `clientes` | Datos personales, estrato, saldo a favor | `id_barrio → barrios` (puede ser NULL) |
| `contratos` | Plan contratado por un cliente, estado, IP | `id_cliente → clientes`, `id_plan → planes` |
| `facturas` | Una por contrato y mes (`periodo`), estado | `id_contrato → contratos` |
| `pagos` | Pagos y abonos a facturas | `id_factura → facturas` |
| `tecnicos` | Técnicos con jerarquía | `id_supervisor → tecnicos` (auto-relación) |
| `tickets` | Casos de soporte | `id_contrato → contratos`, `id_tecnico → tecnicos` (NULL = sin asignar) |
| `equipos` | Inventario de equipos | `id_contrato → contratos` (NULL = en bodega) |

```
barrios 1───N clientes 1───N contratos N───1 planes
                                 │ 1
                 ┌───────────────┼───────────────┐
                 N               N               N
             facturas         tickets         equipos
                 │ 1             N
                 N               │
               pagos          tecnicos ──┐ (supervisor)
                                 └───────┘
```

**Datos "trampa" a propósito** (para que los JOIN den resultados distintos):
- Un cliente sin barrio (`id_barrio` NULL) y un barrio sin clientes.
- Un cliente sin ningún contrato y un plan que nadie ha contratado.
- Un cliente con dos contratos; contratos suspendidos y cancelados.
- Clientes sin correo, facturas con abonos parciales, tickets sin técnico y sin cerrar.

---

## Parte 1 — SELECT básico, filtros y ordenamiento

1. Liste nombres, apellidos y teléfono de todos los clientes.
2. Muestre todos los planes ordenados del más caro al más barato.
3. Liste los clientes de estrato 1 o 2 (use `IN`).
4. Muestre los planes cuyo precio esté entre $80.000 y $200.000 (use `BETWEEN`).
5. Encuentre los clientes cuyo correo sea de Gmail. ¿Qué diferencia hay entre `LIKE` e `ILIKE` en PostgreSQL?
6. ¿Qué clientes no tienen correo registrado? (Cuidado: `= NULL` no funciona.)
7. Muestre los 5 clientes registrados más recientemente.
8. ¿Qué medios de pago distintos se han usado?

## Parte 2 — Funciones, alias y CASE

9. Muestre el nombre completo de cada cliente en una sola columna (`nombre_completo`) y su correo en mayúsculas.
10. Liste los clientes mostrando `'SIN CORREO'` cuando el email sea NULL (use `COALESCE` o `IFNULL`).
11. Calcule la antigüedad en meses de cada cliente a la fecha de referencia y ordene del más antiguo al más nuevo. (Pista: `AGE()` y `EXTRACT()`.)
12. Clasifique cada plan según velocidad: menos de 100 Mbps = *Básica*, menos de 500 = *Media*, el resto = *Alta*.
13. Para cada plan muestre el precio con IVA (19 %) redondeado y el precio por mega.

## Parte 3 — Funciones de agregación, GROUP BY y HAVING

14. En una sola consulta: total de clientes, cuántos tienen email y cuántos no. (Pista: `COUNT(*)` vs `COUNT(columna)`.)
15. Precio mínimo, máximo y promedio de los planes.
16. Número de clientes por estrato.
17. Cantidad de facturas y valor total por estado (Pendiente, Pagada, Vencida).
18. Número de pagos y valor recaudado por medio de pago, del mayor al menor.
19. Recaudo total por mes en formato `AAAA-MM` (use `TO_CHAR`).
20. ¿Qué contratos han abierto 2 o más tickets? (`HAVING`)

## Parte 4 — JOINs

21. **INNER JOIN:** clientes con el nombre de su barrio y comuna. ¿Cuántas filas salen? ¿Falta alguien? ¿Por qué?
22. **LEFT JOIN:** repita el anterior de forma que aparezcan *todos* los clientes.
23. **Tres tablas:** contratos activos con nombre del cliente, nombre del plan y velocidad.
24. **Anti-join:** clientes que no tienen ningún contrato (use `LEFT JOIN … WHERE … IS NULL`).
25. **RIGHT JOIN:** planes que nunca han sido contratados.
26. Número de clientes por barrio, incluyendo los barrios con 0 clientes. (Pista: ¿`COUNT(*)` o `COUNT(c.id_cliente)`?)
27. **FULL OUTER JOIN:** obtenga todos los clientes y todos los barrios, estén o no relacionados. Luego filtre para dejar solo los que no tienen pareja en el otro lado.
28. **SELF JOIN:** cada técnico con el nombre de su supervisor (el jefe debe aparecer con "(sin jefe)").
29. **SELF JOIN:** para cada técnico, el salario de su jefe y la diferencia salarial.
30. **CROSS JOIN:** genere una tabla de cotización con todos los planes para cada barrio de la Comuna 9.
31. **JOIN múltiple:** detalle de cada ticket con fecha, categoría, prioridad, cliente, barrio, plan y técnico (`'SIN ASIGNAR'` si no tiene). Deben salir los 18 tickets.
32. **Cartera:** para cada factura no pagada muestre cliente, periodo, valor, lo abonado y el saldo. (Hay facturas con abono parcial.)

## Parte 5 — Subconsultas

33. **Escalar:** planes cuyo precio sea mayor al promedio.
34. **IN:** clientes que tienen al menos un contrato suspendido.
35. **NOT EXISTS:** resuelva el ejercicio 24 con `NOT EXISTS`.
36. **Correlacionada:** técnicos que ganan más que el promedio de su propia especialidad.
37. **Tabla derivada (en el FROM):** promedio de tickets atendidos por técnico.
38. **En el SELECT:** cada cliente con su número de contratos.
39. Clientes que hayan pagado alguna vez por Nequi.

## Parte 6 — UNION, CTE y funciones de ventana

40. **UNION ALL:** un directorio con los nombres de clientes y técnicos y una columna `tipo`. ¿Cuál es la diferencia con `UNION`?
41. **CTE (`WITH`):** recaudo total por plan y el porcentaje que representa del total.
42. **CTE recursiva:** muestre la jerarquía de técnicos como ruta (`Jefe > Supervisor > Técnico`) con su nivel.
43. **ROW_NUMBER:** el último pago realizado por cada cliente. Resuélvalo también con `DISTINCT ON`, propio de PostgreSQL.
44. **RANK vs DENSE_RANK:** ranking de técnicos por número de tickets atendidos (incluya los que tienen 0). Explique la diferencia entre ambas columnas.
45. **SUM() OVER:** recaudo por mes y recaudo acumulado.
46. **LAG:** variación del recaudo de cada mes frente al mes anterior.

## Parte 7 — Vistas

47. Cree la vista `v_cartera` con: id del cliente, nombre completo, teléfono, número de facturas no pagadas y deuda total (descontando abonos).
48. Usando la vista, liste los clientes con deuda mayor a $100.000.

## Parte 8 — INSERT, UPDATE y DELETE

49. Registre un contrato para Paula Andrea Suárez (id 20) en el plan *Hogar 100*, con inicio hoy e IP `100.64.0.99`. Obtenga el `id_plan` con una subconsulta, no lo escriba a mano, y use `RETURNING` para ver el id del contrato creado.
50. Suba 5 % el precio de los planes de tipo Hogar, redondeando a la centena.
51. **UPDATE con JOIN (`UPDATE … FROM`):** marque como *Vencida* las facturas pendientes cuya fecha de vencimiento ya pasó y que pertenezcan a contratos suspendidos.
52. Elimine del inventario los equipos dañados que no estén asociados a ningún contrato.

## Parte 9 — Transacciones

> En PostgreSQL cada sentencia suelta se confirma sola (autocommit). Una transacción se abre con `BEGIN` (o `START TRANSACTION`) y se cierra con `COMMIT` o `ROLLBACK`. Consulte el nivel de aislamiento con `SHOW transaction_isolation;`.

53. **COMMIT:** registre el pago total de la factura de noviembre del contrato 2 por PSE y márquela como *Pagada*, todo dentro de una transacción.
54. **ROLLBACK:** dentro de una transacción borre todos los tickets cerrados, cuente los tickets que quedan, y luego haga `ROLLBACK`. Vuelva a contar. ¿Qué pasó?
55. **SELECT … FOR UPDATE:** el cliente 4 tiene $20.000 de saldo a favor. En una transacción, bloquee su fila, abone ese saldo a su factura de noviembre del contrato 18 y deje el saldo en 0. ¿Para qué sirve el bloqueo?
56. **SAVEPOINT:** instale para el contrato nuevo de Paula (ejercicio 49) una ONT de bodega, cree un savepoint, luego "por error" instale todas las antenas de bodega, deshaga solo ese error con `ROLLBACK TO SAVEPOINT`, instale un router y haga `COMMIT`. Verifique qué equipos quedaron.
56b. **Transacción abortada:** dentro de un `BEGIN`, intente poner estrato 9 a un cliente (viola el `CHECK`) y luego ejecute cualquier `SELECT`. ¿Qué mensaje sale? ¿Cómo lo evitaría con un `SAVEPOINT`?
57. **Atomicidad en un procedimiento (PL/pgSQL):** cree `sp_traslado_plan(contrato, plan_nuevo)` que cancele el contrato actual, cree uno nuevo para el mismo cliente con el plan nuevo y mueva los equipos. Si algo falla (por ejemplo, un plan que no existe) se debe deshacer todo; use un bloque `EXCEPTION` y `RAISE NOTICE` para informar. Pruébelo con `(7, 99)` y luego con `(7, 3)`.
58. **Niveles de aislamiento (dos sesiones):** abra dos consolas. Demuestre la diferencia entre `READ UNCOMMITTED` (lectura sucia), `READ COMMITTED` (lectura no repetible) y `REPEATABLE READ` usando el precio del plan 1. Documente qué ve cada sesión en cada paso. ¿Por qué en PostgreSQL no se puede producir una lectura sucia?

## Parte 10 — Índices y plan de ejecución

59. Ejecute `EXPLAIN` sobre una búsqueda de clientes por apellido con `LIKE 'Rios%'`. Cree un índice sobre `apellidos` (con `varchar_pattern_ops`) y repita. Pruebe también con `LIKE '%Rios'`. ¿Cuándo aparece *Seq Scan* y cuándo *Index Scan*? Pruebe `EXPLAIN ANALYZE`.
    > Como las tablas son pequeñas, PostgreSQL siempre preferirá *Seq Scan*. Para practicar, ejecute antes `SET enable_seqscan = off;` (y al final `RESET enable_seqscan;`).
60. Cree un índice compuesto que favorezca buscar facturas por `estado` y `fecha_vencimiento`, y verifíquelo con `EXPLAIN`.

## Bonus — Trigger

61. Cree una función de trigger en PL/pgSQL y un trigger `AFTER INSERT` sobre `pagos` que marque la factura como *Pagada* cuando la suma de sus pagos cubra el valor. Pruébelo completando la factura de noviembre del contrato 18.

---

### Recomendaciones
- Los ejercicios 49 en adelante **modifican datos**. Si quiere repetir, vuelva a ejecutar `01_isp_redandina.sql` y la base queda como nueva.
- Haga las partes 1–7 antes de las 8–10, porque los resultados de consulta cambian después de los UPDATE/DELETE.
- Resuelva primero sin mirar `03_solucionario.sql`.
