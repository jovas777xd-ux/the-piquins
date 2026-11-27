-- THE PIQUINS: COMPARACION SIMPLE, VERSION 3
-- Crear una consulta NUEVA en Supabase SQL Editor. Pegar SOLO este texto.
-- Consulta de lectura: no cambia productos ni fotos.
-- Revisar visualmente los fondos negros antes de actualizar imagenes.

SELECT
  codigo,
  nombre,
  imagen AS foto_actual,
  CASE
    WHEN codigo LIKE 'PHOTO-%' THEN SUBSTRING(codigo FROM 7)
    WHEN codigo LIKE 'BAT-%' THEN SUBSTRING(codigo FROM 5) || '.jpeg'
  END AS archivo_original,
  'https://jovas777xd-ux.github.io/the-piquins/' ||
    CASE
      WHEN codigo LIKE 'PHOTO-%' THEN SUBSTRING(codigo FROM 7)
      WHEN codigo LIKE 'BAT-%' THEN SUBSTRING(codigo FROM 5) || '.jpeg'
    END AS foto_original_github,
  CASE
    WHEN imagen LIKE 'https://wwamrosmrcjnlsaagdyg.supabase.co/storage/%'
      THEN 'CONSERVAR FOTO NUEVA DE SUPABASE'
    WHEN imagen IS NULL OR TRIM(imagen) = ''
      THEN 'SIN IMAGEN EN BD'
    WHEN imagen LIKE 'https://jovas777xd-ux.github.io/the-piquins/%'
      THEN 'FOTO DE GITHUB'
    WHEN imagen ~* '^https?://'
      THEN 'REVISAR FOTO EXTERNA'
    ELSE 'NOMBRE DE ARCHIVO ORIGINAL'
  END AS revision
FROM public.piquins_productos
WHERE codigo LIKE 'PHOTO-%' OR codigo LIKE 'BAT-%'
ORDER BY nombre;
