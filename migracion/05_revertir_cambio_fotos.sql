-- THE PIQUINS - DESHACER SOLO EL CAMBIO DE RUTAS DEL SCRIPT 04
-- Utilizar si se descubre que las fotos del repositorio original no son
-- las deseadas. No afecta productos nuevos ni otras tiendas.
-- Solo revierte filas cuya imagen TODAVÍA coincide con la URL propuesta.
begin;
update public.piquins_productos p
set imagen = b.imagen_anterior
from public.piquins_respaldo_fotos_20261127 b
where p.codigo = b.codigo
  and p.imagen = b.url_propuesta;
commit;
