-- =====================================================================
--  SOLUCIONARIO - Taller de consultas SQL (isp_redandina)
--  PostgreSQL 13+ (probado en PostgreSQL 16)
--  Ejecutar conectado a la base isp_redandina.
--  Ojo: varias consultas tienen mas de una solucion valida.
-- =====================================================================

-- ===================== PARTE 1: SELECT BASICO =========================
-- 1
SELECT nombres, apellidos, telefono FROM clientes;
-- 2
SELECT * FROM planes ORDER BY precio_mensual DESC;
-- 3
SELECT nombres, apellidos, estrato FROM clientes WHERE estrato IN (1, 2);
-- 4
SELECT nombre, velocidad_mbps, precio_mensual
FROM planes WHERE precio_mensual BETWEEN 80000 AND 200000;
-- 5  (LIKE distingue mayusculas en PostgreSQL; ILIKE no)
SELECT nombres, apellidos, email FROM clientes WHERE email ILIKE '%@gmail.com';
-- 6
SELECT nombres, apellidos, telefono FROM clientes WHERE email IS NULL;
-- 7
SELECT nombres, apellidos, fecha_registro FROM clientes
ORDER BY fecha_registro DESC LIMIT 5;
-- 8
SELECT DISTINCT medio FROM pagos;

-- ================ PARTE 2: FUNCIONES, ALIAS Y CASE ====================
-- 9  (|| es el operador de concatenacion estandar; CONCAT tambien sirve)
SELECT nombres || ' ' || apellidos AS nombre_completo,
       UPPER(email) AS correo
FROM clientes;
-- 10
SELECT nombres, apellidos, COALESCE(email, 'SIN CORREO') AS email FROM clientes;
-- 11  AGE() devuelve un intervalo: se pasa a meses con EXTRACT
SELECT nombres, fecha_registro,
       EXTRACT(YEAR FROM AGE(DATE '2026-11-17', fecha_registro)) * 12
     + EXTRACT(MONTH FROM AGE(DATE '2026-11-17', fecha_registro)) AS meses_antiguedad
FROM clientes ORDER BY meses_antiguedad DESC;
-- 12
SELECT nombre, velocidad_mbps,
       CASE
         WHEN velocidad_mbps < 100 THEN 'Basica'
         WHEN velocidad_mbps < 500 THEN 'Media'
         ELSE 'Alta'
       END AS categoria_velocidad
FROM planes;
-- 13
SELECT nombre, precio_mensual,
       ROUND(precio_mensual * 1.19, 0)          AS precio_con_iva,
       ROUND(precio_mensual / velocidad_mbps, 2) AS precio_por_mega
FROM planes;

-- ================= PARTE 3: AGREGACION ================================
-- 14
SELECT COUNT(*)                AS total_clientes,
       COUNT(email)            AS con_email,
       COUNT(*) - COUNT(email) AS sin_email
FROM clientes;
-- 15
SELECT MIN(precio_mensual) AS minimo, MAX(precio_mensual) AS maximo,
       ROUND(AVG(precio_mensual), 2) AS promedio
FROM planes;
-- 16
SELECT estrato, COUNT(*) AS cantidad FROM clientes GROUP BY estrato ORDER BY estrato;
-- 17
SELECT estado, COUNT(*) AS cantidad, SUM(valor) AS total
FROM facturas GROUP BY estado;
-- 18
SELECT medio, COUNT(*) AS num_pagos, SUM(valor) AS recaudo
FROM pagos GROUP BY medio ORDER BY recaudo DESC;
-- 19
SELECT TO_CHAR(fecha_pago, 'YYYY-MM') AS mes, SUM(valor) AS recaudo
FROM pagos GROUP BY mes ORDER BY mes;
-- 20
SELECT id_contrato, COUNT(*) AS num_tickets
FROM tickets GROUP BY id_contrato HAVING COUNT(*) >= 2;

-- ====================== PARTE 4: JOINS ================================
-- 21 INNER JOIN (19 filas: Mateo no tiene barrio)
SELECT c.nombres, c.apellidos, b.nombre AS barrio, b.comuna
FROM clientes c
INNER JOIN barrios b ON b.id_barrio = c.id_barrio;
-- 22 LEFT JOIN (20 filas)
SELECT c.nombres, c.apellidos, b.nombre AS barrio
FROM clientes c
LEFT JOIN barrios b ON b.id_barrio = c.id_barrio;
-- 23 JOIN de 3 tablas
SELECT ct.id_contrato, c.nombres || ' ' || c.apellidos AS cliente,
       p.nombre AS plan, p.velocidad_mbps, ct.estado
FROM contratos ct
JOIN clientes c ON c.id_cliente = ct.id_cliente
JOIN planes   p ON p.id_plan    = ct.id_plan
WHERE ct.estado = 'Activo';
-- 24 Anti-join: clientes sin contrato
SELECT c.id_cliente, c.nombres, c.apellidos
FROM clientes c
LEFT JOIN contratos ct ON ct.id_cliente = c.id_cliente
WHERE ct.id_contrato IS NULL;
-- 25 RIGHT JOIN: planes que nadie tiene (o tuvo)
SELECT p.nombre, p.precio_mensual
FROM contratos ct
RIGHT JOIN planes p ON p.id_plan = ct.id_plan
WHERE ct.id_contrato IS NULL;
-- 26 Clientes por barrio incluyendo los de 0
--    COUNT(*) daria 1 en Aranjuez (cuenta la fila con NULLs); COUNT(c.id_cliente) da 0
SELECT b.nombre, COUNT(c.id_cliente) AS num_clientes
FROM barrios b
LEFT JOIN clientes c ON c.id_barrio = b.id_barrio
GROUP BY b.id_barrio, b.nombre
ORDER BY num_clientes DESC;
-- 27 FULL OUTER JOIN (PostgreSQL SI lo soporta)
SELECT c.nombres, b.nombre AS barrio
FROM clientes c
FULL OUTER JOIN barrios b ON b.id_barrio = c.id_barrio;
--    Solo los "huerfanos" de ambos lados:
SELECT c.nombres, b.nombre AS barrio
FROM clientes c
FULL OUTER JOIN barrios b ON b.id_barrio = c.id_barrio
WHERE c.id_cliente IS NULL OR b.id_barrio IS NULL;
-- 28 SELF JOIN
SELECT t.nombre AS tecnico, t.especialidad,
       COALESCE(s.nombre, '(sin jefe)') AS supervisor
FROM tecnicos t
LEFT JOIN tecnicos s ON s.id_tecnico = t.id_supervisor;
-- 29 SELF JOIN: diferencia salarial con el jefe
SELECT t.nombre, t.salario, s.nombre AS jefe, s.salario AS salario_jefe,
       s.salario - t.salario AS diferencia
FROM tecnicos t JOIN tecnicos s ON s.id_tecnico = t.id_supervisor;
-- 30 CROSS JOIN
SELECT b.nombre AS barrio, p.nombre AS plan, p.precio_mensual
FROM barrios b CROSS JOIN planes p
WHERE b.comuna LIKE 'Comuna 9%'
ORDER BY b.nombre, p.precio_mensual;
-- 31 JOIN multiple: detalle de los 18 tickets
SELECT tk.id_ticket, tk.fecha_apertura, tk.categoria, tk.prioridad,
       c.nombres || ' ' || c.apellidos AS cliente,
       b.nombre AS barrio, p.nombre AS plan,
       COALESCE(te.nombre, 'SIN ASIGNAR') AS tecnico
FROM tickets tk
JOIN contratos ct      ON ct.id_contrato = tk.id_contrato
JOIN clientes  c       ON c.id_cliente   = ct.id_cliente
LEFT JOIN barrios  b   ON b.id_barrio    = c.id_barrio
JOIN planes    p       ON p.id_plan      = ct.id_plan
LEFT JOIN tecnicos te  ON te.id_tecnico  = tk.id_tecnico
ORDER BY tk.fecha_apertura;
-- 32 Cartera por factura
SELECT f.id_factura, c.nombres || ' ' || c.apellidos AS cliente,
       f.periodo, f.valor,
       COALESCE(SUM(pg.valor), 0)           AS abonado,
       f.valor - COALESCE(SUM(pg.valor), 0) AS saldo
FROM facturas f
JOIN contratos ct  ON ct.id_contrato = f.id_contrato
JOIN clientes c    ON c.id_cliente   = ct.id_cliente
LEFT JOIN pagos pg ON pg.id_factura  = f.id_factura
WHERE f.estado <> 'Pagada'
GROUP BY f.id_factura, c.nombres, c.apellidos
ORDER BY saldo DESC;
-- (Agrupar por la PK f.id_factura permite usar f.periodo y f.valor sin listarlos)

-- ==================== PARTE 5: SUBCONSULTAS ===========================
-- 33
SELECT nombre, precio_mensual FROM planes
WHERE precio_mensual > (SELECT AVG(precio_mensual) FROM planes);
-- 34
SELECT nombres, apellidos FROM clientes
WHERE id_cliente IN (SELECT id_cliente FROM contratos WHERE estado = 'Suspendido');
-- 35
SELECT c.nombres, c.apellidos FROM clientes c
WHERE NOT EXISTS (SELECT 1 FROM contratos ct WHERE ct.id_cliente = c.id_cliente);
-- 36 Correlacionada
SELECT t.nombre, t.especialidad, t.salario FROM tecnicos t
WHERE t.salario > (SELECT AVG(t2.salario) FROM tecnicos t2
                   WHERE t2.especialidad = t.especialidad);
-- 37 Tabla derivada (en PostgreSQL el alias es obligatorio)
SELECT ROUND(AVG(x.n), 2) AS promedio_tickets_por_tecnico
FROM (SELECT id_tecnico, COUNT(*) AS n FROM tickets
      WHERE id_tecnico IS NOT NULL GROUP BY id_tecnico) AS x;
-- 38
SELECT c.nombres, c.apellidos,
       (SELECT COUNT(*) FROM contratos ct WHERE ct.id_cliente = c.id_cliente) AS num_contratos
FROM clientes c ORDER BY num_contratos DESC;
-- 39
SELECT c.nombres, c.apellidos FROM clientes c
WHERE c.id_cliente IN (
  SELECT ct.id_cliente FROM contratos ct
  JOIN facturas f ON f.id_contrato = ct.id_contrato
  JOIN pagos pg   ON pg.id_factura = f.id_factura
  WHERE pg.medio = 'Nequi');

-- ========= PARTE 6: UNION, CTE Y FUNCIONES DE VENTANA =================
-- 40
SELECT nombres || ' ' || apellidos AS nombre, 'Cliente' AS tipo FROM clientes
UNION ALL
SELECT nombre, 'Tecnico' FROM tecnicos
ORDER BY tipo, nombre;
-- 41 CTE
WITH recaudo_plan AS (
  SELECT p.nombre AS plan, SUM(pg.valor) AS total
  FROM pagos pg
  JOIN facturas f   ON f.id_factura   = pg.id_factura
  JOIN contratos ct ON ct.id_contrato = f.id_contrato
  JOIN planes p     ON p.id_plan      = ct.id_plan
  GROUP BY p.nombre
)
SELECT plan, total,
       ROUND(100 * total / (SELECT SUM(total) FROM recaudo_plan), 1) AS porcentaje
FROM recaudo_plan ORDER BY total DESC;
-- 42 CTE recursiva
WITH RECURSIVE jerarquia AS (
  SELECT id_tecnico, nombre, id_supervisor, 0 AS nivel, nombre::TEXT AS ruta
  FROM tecnicos WHERE id_supervisor IS NULL
  UNION ALL
  SELECT t.id_tecnico, t.nombre, t.id_supervisor, j.nivel + 1,
         j.ruta || ' > ' || t.nombre
  FROM tecnicos t JOIN jerarquia j ON t.id_supervisor = j.id_tecnico
)
SELECT nivel, ruta FROM jerarquia ORDER BY ruta;
-- 43 ROW_NUMBER: ultimo pago de cada cliente
WITH pagos_cliente AS (
  SELECT c.nombres, c.apellidos, pg.fecha_pago, pg.valor,
         ROW_NUMBER() OVER (PARTITION BY c.id_cliente
                            ORDER BY pg.fecha_pago DESC, pg.id_pago DESC) AS rn
  FROM pagos pg
  JOIN facturas f   ON f.id_factura   = pg.id_factura
  JOIN contratos ct ON ct.id_contrato = f.id_contrato
  JOIN clientes c   ON c.id_cliente   = ct.id_cliente
)
SELECT nombres, apellidos, fecha_pago, valor FROM pagos_cliente WHERE rn = 1;
--    Alternativa propia de PostgreSQL: DISTINCT ON
SELECT DISTINCT ON (c.id_cliente) c.nombres, c.apellidos, pg.fecha_pago, pg.valor
FROM pagos pg
JOIN facturas f   ON f.id_factura   = pg.id_factura
JOIN contratos ct ON ct.id_contrato = f.id_contrato
JOIN clientes c   ON c.id_cliente   = ct.id_cliente
ORDER BY c.id_cliente, pg.fecha_pago DESC, pg.id_pago DESC;
-- 44 RANK vs DENSE_RANK
SELECT te.nombre, COUNT(tk.id_ticket) AS tickets,
       RANK()       OVER (ORDER BY COUNT(tk.id_ticket) DESC) AS rnk,
       DENSE_RANK() OVER (ORDER BY COUNT(tk.id_ticket) DESC) AS dense_rnk
FROM tecnicos te LEFT JOIN tickets tk ON tk.id_tecnico = te.id_tecnico
GROUP BY te.id_tecnico, te.nombre;
-- 45 SUM OVER: acumulado
SELECT mes, recaudo, SUM(recaudo) OVER (ORDER BY mes) AS acumulado
FROM (SELECT TO_CHAR(fecha_pago,'YYYY-MM') AS mes, SUM(valor) AS recaudo
      FROM pagos GROUP BY 1) m;
-- 46 LAG
SELECT mes, recaudo,
       LAG(recaudo) OVER (ORDER BY mes)           AS mes_anterior,
       recaudo - LAG(recaudo) OVER (ORDER BY mes) AS variacion
FROM (SELECT TO_CHAR(fecha_pago,'YYYY-MM') AS mes, SUM(valor) AS recaudo
      FROM pagos GROUP BY 1) m;

-- ======================= PARTE 7: VISTAS ==============================
-- 47
CREATE OR REPLACE VIEW v_cartera AS
SELECT c.id_cliente, c.nombres || ' ' || c.apellidos AS cliente, c.telefono,
       COUNT(*) AS facturas_pendientes, SUM(s.saldo) AS deuda
FROM (SELECT f.id_factura, f.id_contrato,
             f.valor - COALESCE(SUM(pg.valor), 0) AS saldo
      FROM facturas f LEFT JOIN pagos pg ON pg.id_factura = f.id_factura
      WHERE f.estado <> 'Pagada'
      GROUP BY f.id_factura) AS s
JOIN contratos ct ON ct.id_contrato = s.id_contrato
JOIN clientes c   ON c.id_cliente   = ct.id_cliente
GROUP BY c.id_cliente;
-- 48
SELECT * FROM v_cartera WHERE deuda > 100000 ORDER BY deuda DESC;

-- ============== PARTE 8: INSERT, UPDATE, DELETE =======================
-- 49  RETURNING devuelve la fila insertada (muy util para saber el id nuevo)
INSERT INTO contratos (id_cliente, id_plan, fecha_inicio, estado, ip_asignada)
VALUES (20, (SELECT id_plan FROM planes WHERE nombre = 'Hogar 100'),
        DATE '2026-11-17', 'Activo', '100.64.0.99')
RETURNING id_contrato;
-- 50
UPDATE planes SET precio_mensual = ROUND(precio_mensual * 1.05, -2)
WHERE tipo = 'Hogar'
RETURNING nombre, precio_mensual;
-- 51 UPDATE con JOIN: en PostgreSQL se usa UPDATE ... FROM
UPDATE facturas f
SET estado = 'Vencida'
FROM contratos ct
WHERE ct.id_contrato = f.id_contrato
  AND f.estado = 'Pendiente'
  AND f.fecha_vencimiento < DATE '2026-11-17'
  AND ct.estado = 'Suspendido';
-- 52
DELETE FROM equipos WHERE estado = 'Danado' AND id_contrato IS NULL
RETURNING serial, modelo;

-- ===================== PARTE 9: TRANSACCIONES =========================
-- 53 COMMIT
BEGIN;
  INSERT INTO pagos (id_factura, fecha_pago, valor, medio)
  SELECT id_factura, DATE '2026-11-17', valor, 'PSE'
  FROM facturas WHERE id_contrato = 2 AND periodo = '2026-11-01';
  UPDATE facturas SET estado = 'Pagada'
  WHERE id_contrato = 2 AND periodo = '2026-11-01';
COMMIT;

-- 54 ROLLBACK
BEGIN;
  DELETE FROM tickets WHERE fecha_cierre IS NOT NULL;
  SELECT COUNT(*) AS tickets_dentro_de_la_tx FROM tickets;   -- 4
ROLLBACK;
SELECT COUNT(*) AS tickets_despues_rollback FROM tickets;    -- 18

-- 55 SELECT ... FOR UPDATE
BEGIN;
  SELECT saldo_favor FROM clientes WHERE id_cliente = 4 FOR UPDATE;  -- bloquea la fila
  INSERT INTO pagos (id_factura, fecha_pago, valor, medio)
  SELECT id_factura, DATE '2026-11-17', 20000, 'Efectivo'
  FROM facturas WHERE id_contrato = 18 AND periodo = '2026-11-01';
  UPDATE clientes SET saldo_favor = saldo_favor - 20000 WHERE id_cliente = 4;
COMMIT;
-- Si otra sesion intenta usar el mismo saldo al tiempo, queda esperando
-- hasta el COMMIT, y entonces ve saldo 0 -> no se gasta dos veces.

-- 56 SAVEPOINT
BEGIN;
  UPDATE equipos SET estado = 'Instalado',
         id_contrato = (SELECT MAX(id_contrato) FROM contratos WHERE id_cliente = 20)
  WHERE id_equipo = (SELECT id_equipo FROM equipos
                     WHERE tipo = 'ONT' AND estado = 'Bodega' ORDER BY id_equipo LIMIT 1);
  SAVEPOINT ont_instalada;
  UPDATE equipos SET estado = 'Instalado',
         id_contrato = (SELECT MAX(id_contrato) FROM contratos WHERE id_cliente = 20)
  WHERE tipo = 'Antena' AND estado = 'Bodega';   -- error: se instalaron TODAS las antenas
  ROLLBACK TO SAVEPOINT ont_instalada;            -- se deshace solo esto
  UPDATE equipos SET estado = 'Instalado',
         id_contrato = (SELECT MAX(id_contrato) FROM contratos WHERE id_cliente = 20)
  WHERE id_equipo = (SELECT id_equipo FROM equipos
                     WHERE tipo = 'Router' AND estado = 'Bodega' ORDER BY id_equipo LIMIT 1);
COMMIT;
SELECT serial, modelo, tipo FROM equipos
WHERE id_contrato = (SELECT MAX(id_contrato) FROM contratos WHERE id_cliente = 20);

-- 56b (PROPIO DE POSTGRESQL) Un error dentro de una transaccion la "aborta":
--  BEGIN;
--    UPDATE clientes SET estrato = 9 WHERE id_cliente = 1;  -- viola el CHECK -> ERROR
--    SELECT 1;  -- ERROR: current transaction is aborted, commands ignored until end of transaction block
--  ROLLBACK;
--  Con un SAVEPOINT antes del UPDATE, basta ROLLBACK TO SAVEPOINT para seguir trabajando.

-- 57 Atomicidad en un procedimiento
--  En PL/pgSQL un bloque con EXCEPTION funciona como un savepoint implicito:
--  si algo falla dentro del bloque, TODO lo que hizo el bloque se deshace.
CREATE OR REPLACE PROCEDURE sp_traslado_plan(p_contrato INT, p_plan_nuevo INT)
LANGUAGE plpgsql
AS $$
DECLARE
  v_nuevo INT;
BEGIN
  -- 1. Cancelar contrato actual
  UPDATE contratos
  SET estado = 'Cancelado', fecha_fin = CURRENT_DATE, ip_asignada = NULL
  WHERE id_contrato = p_contrato;
  -- 2. Crear el nuevo (falla por la FK si el plan no existe)
  INSERT INTO contratos (id_cliente, id_plan, fecha_inicio, estado)
  SELECT id_cliente, p_plan_nuevo, CURRENT_DATE, 'Activo'
  FROM contratos WHERE id_contrato = p_contrato
  RETURNING id_contrato INTO v_nuevo;
  -- 3. Mover los equipos
  UPDATE equipos SET id_contrato = v_nuevo WHERE id_contrato = p_contrato;
  RAISE NOTICE 'OK: plan cambiado, contrato nuevo %', v_nuevo;
EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR: cambio de plan revertido (%)', SQLERRM;
END;
$$;
CALL sp_traslado_plan(7, 99);   -- plan 99 no existe -> todo se revierte
SELECT id_contrato, estado FROM contratos WHERE id_contrato = 7;   -- sigue Activo
CALL sp_traslado_plan(7, 3);    -- funciona
SELECT id_contrato, id_cliente, id_plan, estado FROM contratos WHERE id_cliente = 7;

-- 58 Aislamiento (en DOS sesiones; no se ejecuta en este script)
--  Sesion A: BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
--            SELECT precio_mensual FROM planes WHERE id_plan = 1;   -- valor X
--  Sesion B: UPDATE planes SET precio_mensual = 70000 WHERE id_plan = 1;  -- autocommit
--  Sesion A: SELECT precio_mensual FROM planes WHERE id_plan = 1;   -- ya ve 70000
--            COMMIT;            --> "lectura no repetible"
--
--  Repetir con BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--  la segunda lectura de A sigue viendo X hasta su COMMIT.
--  Ademas, si A intenta UPDATE sobre esa misma fila despues del cambio de B:
--  ERROR: could not serialize access due to concurrent update
--
--  READ UNCOMMITTED: PostgreSQL lo acepta pero se comporta como READ COMMITTED,
--  asi que NUNCA hay lecturas sucias (B dentro de BEGIN ... sin COMMIT -> A no ve nada).
--  SHOW transaction_isolation;  -- nivel actual (por defecto: read committed)

-- ============= PARTE 10: INDICES Y PLAN DE EJECUCION ==================
-- 59  Con tablas tan pequenas el planificador prefiere Seq Scan siempre;
--     para ver el indice en accion se desactiva el seq scan (solo para practicar).
SET enable_seqscan = off;
EXPLAIN SELECT * FROM clientes WHERE apellidos LIKE 'Rios%';
-- varchar_pattern_ops permite usar el indice con LIKE 'prefijo%'
-- (un indice normal solo sirve para LIKE si la base usa collation "C")
CREATE INDEX idx_clientes_apellidos ON clientes (apellidos varchar_pattern_ops);
EXPLAIN SELECT * FROM clientes WHERE apellidos LIKE 'Rios%';    -- Index Scan / Bitmap
EXPLAIN SELECT * FROM clientes WHERE apellidos LIKE '%Rios';    -- no puede usar el indice
-- EXPLAIN ANALYZE ejecuta la consulta y muestra tiempos reales:
EXPLAIN ANALYZE SELECT * FROM clientes WHERE apellidos LIKE 'Rios%';
-- 60 Indice compuesto
CREATE INDEX idx_facturas_estado_venc ON facturas (estado, fecha_vencimiento);
EXPLAIN SELECT * FROM facturas
WHERE estado = 'Vencida' AND fecha_vencimiento < DATE '2026-11-01';
RESET enable_seqscan;

-- ========================= BONUS: TRIGGER =============================
-- 61 En PostgreSQL un trigger se hace en dos pasos: funcion + trigger
CREATE OR REPLACE FUNCTION fn_pago_cierra_factura() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF (SELECT SUM(valor) FROM pagos WHERE id_factura = NEW.id_factura)
     >= (SELECT valor FROM facturas WHERE id_factura = NEW.id_factura) THEN
    UPDATE facturas SET estado = 'Pagada' WHERE id_factura = NEW.id_factura;
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_pago_cierra_factura ON pagos;
CREATE TRIGGER trg_pago_cierra_factura
AFTER INSERT ON pagos
FOR EACH ROW EXECUTE FUNCTION fn_pago_cierra_factura();
-- Prueba: completar la factura de noviembre del contrato 18 (ya tenia abono de 20000)
INSERT INTO pagos (id_factura, fecha_pago, valor, medio)
SELECT id_factura, DATE '2026-11-17', valor - 20000, 'Nequi'
FROM facturas WHERE id_contrato = 18 AND periodo = '2026-11-01';
SELECT id_factura, valor, estado FROM facturas
WHERE id_contrato = 18 AND periodo = '2026-11-01';   -- Pagada
