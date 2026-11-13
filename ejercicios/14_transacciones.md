# Ejercicio 14 — Transacciones y concurrencia

**Datasets:** `universidad`, `tienda`
**Objetivo:** controlar cambios con `BEGIN`, `COMMIT`, `ROLLBACK` y entender ACID.

## Ejercicios

1. Abre una transacción, inserta un departamento y haz `ROLLBACK`. Verifica que no quedó.
2. Repite, pero con `COMMIT`. Verifica que sí quedó.
3. Usa `SAVEPOINT` para insertar dos departamentos y revertir solo el segundo.
4. Explica con un ejemplo qué significa **Atomicidad**.
5. Explica con un ejemplo qué significa **Consistencia** usando una FK.
6. Explica **Aislamiento**: ¿qué problema evita?
7. Explica **Durabilidad**: ¿qué garantiza después de un `COMMIT`?
8. Simula una transferencia de saldo entre dos cuentas (crea la tabla `cuentas` si hace falta):
   - restar de una
   - sumar a la otra
   - `COMMIT`
   - verificar que la suma total no cambió
9. Fuerza un error a mitad de la transferencia y demuestra que `ROLLBACK` deja todo consistente.
10. Consulta el nivel de aislamiento actual con `SHOW transaction_isolation;`.
11. Investiga y explica en una frase cada nivel: `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`.
12. ¿Qué es un deadlock? Da un ejemplo de dos transacciones que se bloquean mutuamente.

## Reto

Implementa una transacción para registrar un pedido en `tienda`:

1. `BEGIN`
2. Insertar pedido
3. Insertar detalles
4. Descontar stock de cada producto
5. Verificar que ningún stock quede negativo
6. Si todo bien, `COMMIT`; si algo falla, `ROLLBACK`

Explica qué pasa si dos usuarios compran el último producto al mismo tiempo.

## Criterio de aceptación

- Se usan transacciones de forma deliberada, no por accidente.
- Se entiende que un `COMMIT` es definitivo.
- Se reconoce el riesgo de concurrencia sobre el stock.

## Checkpoint

1. ¿Qué hace `ROLLBACK`?
2. ¿Qué es ACID?
3. ¿Qué problema resuelve `SERIALIZABLE` y a qué costo?
