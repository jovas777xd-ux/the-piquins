-- THE PIQUINS - RESTAURAR REFERENCIAS FOTOGRÁFICAS ORIGINALES
-- Paso B: EJECUTAR SOLO DESPUÉS de revisar la comparación del archivo 03.
-- Esta operación se limita a los 218 códigos originales de The Piquins.
-- NO modifica otras tiendas, no borra fotografías ni edita sus productos.
-- No reemplaza las URLs de fotos NUEVAS subidas desde el panel a Supabase.
-- Guarda copia de los valores anteriores para poder revertir.
-- Si se quiere conservar una imagen en particular, ponerle primero una URL
-- Supabase Storage nueva; esas direcciones nunca serán reemplazadas.
-- Si los archivos originales del catálogo NO son las fotos deseadas de fondo
-- negro, no ejecutar: se requiere primero disponer de las fotos correctas.

begin;

-- El inventario importado tiene 218 códigos originales verificados en GitHub.
-- Crea solo una tabla temporal de correspondencia: no toca datos de tiendas.
create temporary table piquins_fotos_oficiales (
  codigo text primary key,
  archivo text not null,
  url_oficial text not null
) on commit drop;

insert into piquins_fotos_oficiales (codigo, archivo, url_oficial)
values
  ('PHOTO-abejitas.jpeg', 'abejitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/abejitas.jpeg'),
  ('PHOTO-abejorro.jpeg', 'abejorro.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/abejorro.jpeg'),
  ('PHOTO-abejorromixi.jpeg', 'abejorromixi.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/abejorromixi.jpeg'),
  ('PHOTO-abejorromixivampirito.jpeg', 'abejorromixivampirito.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/abejorromixivampirito.jpeg'),
  ('PHOTO-abejorrospiderman.jpeg', 'abejorrospiderman.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/abejorrospiderman.jpeg'),
  ('PHOTO-adrenocromo.jpeg', 'adrenocromo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/adrenocromo.jpeg'),
  ('PHOTO-adventuretime.jpeg', 'adventuretime.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/adventuretime.jpeg'),
  ('PHOTO-afrodita.jpeg', 'afrodita.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/afrodita.jpeg'),
  ('PHOTO-araña.jpeg', 'araña.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ara%C3%B1a.jpeg'),
  ('PHOTO-arañitas.jpeg', 'arañitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ara%C3%B1itas.jpeg'),
  ('PHOTO-avispon.jpeg', 'avispon.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/avispon.jpeg'),
  ('PHOTO-avisponbolsa.jpeg', 'avisponbolsa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/avisponbolsa.jpeg'),
  ('PHOTO-batman.jpeg', 'batman.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/batman.jpeg'),
  ('PHOTO-bazuca2pulgadas.jpeg', 'bazuca2pulgadas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bazuca2pulgadas.jpeg'),
  ('PHOTO-bazuquin.jpeg', 'bazuquin.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bazuquin.jpeg'),
  ('PHOTO-billetes.jpeg', 'billetes.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/billetes.jpeg'),
  ('PHOTO-bobesponja.jpeg', 'bobesponja.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bobesponja.jpeg'),
  ('PHOTO-bolabarbie.jpeg', 'bolabarbie.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bolabarbie.jpeg'),
  ('PHOTO-boladehumogorila.jpeg', 'boladehumogorila.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/boladehumogorila.jpeg'),
  ('PHOTO-boladehumomega.jpeg', 'boladehumomega.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/boladehumomega.jpeg'),
  ('PHOTO-boladeluzchavo.jpeg', 'boladeluzchavo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/boladeluzchavo.jpeg'),
  ('PHOTO-bombon.jpeg', 'bombon.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bombon.jpeg'),
  ('PHOTO-brainroots.jpeg', 'brainroots.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/brainroots.jpeg'),
  ('PHOTO-buscapie.jpeg', 'buscapie.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/buscapie.jpeg'),
  ('PHOTO-cajitasbob.jpeg', 'cajitasbob.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cajitasbob.jpeg'),
  ('PHOTO-cajitasilbato.jpeg', 'cajitasilbato.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cajitasilbato.jpeg'),
  ('PHOTO-camelia.jpeg', 'camelia.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/camelia.jpeg'),
  ('PHOTO-cameliagrande.jpeg', 'cameliagrande.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cameliagrande.jpeg'),
  ('PHOTO-cameliasminions.jpeg', 'cameliasminions.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cameliasminions.jpeg'),
  ('PHOTO-cameliasositos.jpeg', 'cameliasositos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cameliasositos.jpeg'),
  ('PHOTO-capibaracracker.jpeg', 'capibaracracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/capibaracracker.jpeg'),
  ('PHOTO-capibarasluminosos.jpeg', 'capibarasluminosos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/capibarasluminosos.jpeg'),
  ('PHOTO-caramelito.jpeg', 'caramelito.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/caramelito.jpeg'),
  ('PHOTO-caramelogrande.jpeg', 'caramelogrande.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/caramelogrande.jpeg'),
  ('PHOTO-caramelojumbo.jpeg', 'caramelojumbo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/caramelojumbo.jpeg'),
  ('PHOTO-caramelomediano.jpeg', 'caramelomediano.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/caramelomediano.jpeg'),
  ('PHOTO-catarinas.jpeg', 'catarinas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/catarinas.jpeg'),
  ('PHOTO-cervesitas.jpeg', 'cervesitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cervesitas.jpeg'),
  ('PHOTO-charrovolador.jpeg', 'charrovolador.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/charrovolador.jpeg'),
  ('PHOTO-chupacabras.jpeg', 'chupacabras.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/chupacabras.jpeg'),
  ('PHOTO-cigarros.jpeg', 'cigarros.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cigarros.jpeg'),
  ('PHOTO-cigarrospallmall.jpeg', 'cigarrospallmall.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cigarrospallmall.jpeg'),
  ('PHOTO-colorsmokebomb.jpeg', 'colorsmokebomb.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/colorsmokebomb.jpeg'),
  ('PHOTO-cometa.jpeg', 'cometa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cometa.jpeg'),
  ('PHOTO-cometaespecial.jpeg', 'cometaespecial.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cometaespecial.jpeg'),
  ('PHOTO-cometaespecialmorado.jpeg', 'cometaespecialmorado.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cometaespecialmorado.jpeg'),
  ('PHOTO-cometin.jpeg', 'cometin.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cometin.jpeg'),
  ('PHOTO-cometon.jpeg', 'cometon.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cometon.jpeg'),
  ('PHOTO-crackerboom.jpeg', 'crackerboom.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/crackerboom.jpeg'),
  ('PHOTO-crayones.jpeg', 'crayones.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/crayones.jpeg'),
  ('PHOTO-cueteblanco.jpeg', 'cueteblanco.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cueteblanco.jpeg'),
  ('PHOTO-cueteblancoespecial.jpeg', 'cueteblancoespecial.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cueteblancoespecial.jpeg'),
  ('PHOTO-dollar.jpeg', 'dollar.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/dollar.jpeg'),
  ('PHOTO-dragonballzcracker.jpeg', 'dragonballzcracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/dragonballzcracker.jpeg'),
  ('PHOTO-duvalin.jpeg', 'duvalin.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/duvalin.jpeg'),
  ('PHOTO-elcahvocracker.jpeg', 'elcahvocracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/elcahvocracker.jpeg'),
  ('PHOTO-emoji.jpeg', 'emoji.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/emoji.jpeg'),
  ('PHOTO-escorpiones.jpeg', 'escorpiones.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/escorpiones.jpeg'),
  ('PHOTO-escupidordecracker.jpeg', 'escupidordecracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/escupidordecracker.jpeg'),
  ('PHOTO-escupidordediamantina.jpeg', 'escupidordediamantina.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/escupidordediamantina.jpeg'),
  ('PHOTO-escupidorspiderman.jpeg', 'escupidorspiderman.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/escupidorspiderman.jpeg'),
  ('PHOTO-espantasuegras.jpeg', 'espantasuegras.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/espantasuegras.jpeg'),
  ('PHOTO-flash.jpeg', 'flash.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/flash.jpeg'),
  ('PHOTO-flashdecolor.jpeg', 'flashdecolor.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/flashdecolor.jpeg'),
  ('PHOTO-florerodecolor.jpeg', 'florerodecolor.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/florerodecolor.jpeg'),
  ('PHOTO-frozen.jpeg', 'frozen.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/frozen.jpeg'),
  ('PHOTO-gallinitas.jpeg', 'gallinitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/gallinitas.jpeg'),
  ('PHOTO-garapiñados.jpeg', 'garapiñados.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/garapi%C3%B1ados.jpeg'),
  ('PHOTO-gritito.jpeg', 'gritito.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/gritito.jpeg'),
  ('PHOTO-harleyquinn.jpeg', 'harleyquinn.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/harleyquinn.jpeg'),
  ('PHOTO-hormiguero.jpeg', 'hormiguero.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/hormiguero.jpeg'),
  ('PHOTO-huevodepato.jpeg', 'huevodepato.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/huevodepato.jpeg'),
  ('PHOTO-intensamente.jpeg', 'intensamente.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/intensamente.jpeg'),
  ('PHOTO-juguitos.jpeg', 'juguitos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/juguitos.jpeg'),
  ('PHOTO-jumping.jpeg', 'jumping.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/jumping.jpeg'),
  ('PHOTO-liloystitchcracker.jpeg', 'liloystitchcracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/liloystitchcracker.jpeg'),
  ('PHOTO-llorona.jpeg', 'llorona.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/llorona.jpeg'),
  ('PHOTO-luciernagas.jpeg', 'luciernagas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luciernagas.jpeg'),
  ('PHOTO-luciernagasespeciales.jpeg', 'luciernagasespeciales.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luciernagasespeciales.jpeg'),
  ('PHOTO-luzdebengala.jpeg', 'luzdebengala.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luzdebengala.jpeg'),
  ('PHOTO-luzdebengalaespecial.jpeg', 'luzdebengalaespecial.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luzdebengalaespecial.jpeg'),
  ('PHOTO-luzdebengalagrande.jpeg', 'luzdebengalagrande.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luzdebengalagrande.jpeg'),
  ('PHOTO-luzdebengalamediana.jpeg', 'luzdebengalamediana.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/luzdebengalamediana.jpeg'),
  ('PHOTO-mamut.jpeg', 'mamut.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mamut.jpeg'),
  ('PHOTO-mansionadams.jpeg', 'mansionadams.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mansionadams.jpeg'),
  ('PHOTO-maruchan.jpeg', 'maruchan.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/maruchan.jpeg'),
  ('PHOTO-mazapan.jpeg', 'mazapan.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mazapan.jpeg'),
  ('PHOTO-mazapancrackerconcolor.jpeg', 'mazapancrackerconcolor.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mazapancrackerconcolor.jpeg'),
  ('PHOTO-medusas.jpeg', 'medusas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/medusas.jpeg'),
  ('PHOTO-mexicanitosdecolores.jpeg', 'mexicanitosdecolores.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mexicanitosdecolores.jpeg'),
  ('PHOTO-minadecracker.jpeg', 'minadecracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/minadecracker.jpeg'),
  ('PHOTO-minicangrejito.jpeg', 'minicangrejito.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/minicangrejito.jpeg'),
  ('PHOTO-minimcqueen.jpeg', 'minimcqueen.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/minimcqueen.jpeg'),
  ('PHOTO-minioncracker.jpeg', 'minioncracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/minioncracker.jpeg'),
  ('PHOTO-minions.jpeg', 'minions.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/minions.jpeg'),
  ('PHOTO-miniovnimixi.jpeg', 'miniovnimixi.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/miniovnimixi.jpeg'),
  ('PHOTO-misil.jpeg', 'misil.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/misil.jpeg'),
  ('PHOTO-misilconluz.jpeg', 'misilconluz.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/misilconluz.jpeg'),
  ('PHOTO-misiles25shots.jpeg', 'misiles25shots.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/misiles25shots.jpeg'),
  ('PHOTO-mosaico.jpeg', 'mosaico.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mosaico.jpeg'),
  ('PHOTO-mosaicocolores.jpeg', 'mosaicocolores.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mosaicocolores.jpeg'),
  ('PHOTO-olaf.jpeg', 'olaf.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/olaf.jpeg'),
  ('PHOTO-ollagrande.jpeg', 'ollagrande.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ollagrande.jpeg'),
  ('PHOTO-ollamediana.jpeg', 'ollamediana.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ollamediana.jpeg'),
  ('PHOTO-ollitas.jpeg', 'ollitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ollitas.jpeg'),
  ('PHOTO-orugas.jpeg', 'orugas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/orugas.jpeg'),
  ('PHOTO-ovni.jpeg', 'ovni.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ovni.jpeg'),
  ('PHOTO-ovnigalactico.jpeg', 'ovnigalactico.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ovnigalactico.jpeg'),
  ('PHOTO-ovnimixi.jpeg', 'ovnimixi.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ovnimixi.jpeg'),
  ('PHOTO-paletamicky.jpeg', 'paletamicky.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/paletamicky.jpeg'),
  ('PHOTO-paletaspider.jpeg', 'paletaspider.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/paletaspider.jpeg'),
  ('PHOTO-paletastitch.jpeg', 'paletastitch.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/paletastitch.jpeg'),
  ('PHOTO-palomadeluz.jpeg', 'palomadeluz.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/palomadeluz.jpeg'),
  ('PHOTO-palomamediana.jpeg', 'palomamediana.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/palomamediana.jpeg'),
  ('PHOTO-patitos.jpeg', 'patitos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/patitos.jpeg'),
  ('PHOTO-pato.jpeg', 'pato.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pato.jpeg'),
  ('PHOTO-peppapig.jpeg', 'peppapig.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/peppapig.jpeg'),
  ('PHOTO-pirinolas.jpeg', 'pirinolas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pirinolas.jpeg'),
  ('PHOTO-pistolitafreefire.jpeg', 'pistolitafreefire.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pistolitafreefire.jpeg'),
  ('PHOTO-pitufisorpresas.jpeg', 'pitufisorpresas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pitufisorpresas.jpeg'),
  ('PHOTO-pulgas.jpeg', 'pulgas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pulgas.jpeg'),
  ('PHOTO-pulgasdecracker.jpeg', 'pulgasdecracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/pulgasdecracker.jpeg'),
  ('PHOTO-r15.jpeg', 'r15.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/r15.jpeg'),
  ('PHOTO-rehiletecosmico.jpeg', 'rehiletecosmico.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rehiletecosmico.jpeg'),
  ('PHOTO-revelaciondesexo.jpeg', 'revelaciondesexo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/revelaciondesexo.jpeg'),
  ('PHOTO-revelacionpirostar.jpeg', 'revelacionpirostar.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/revelacionpirostar.jpeg'),
  ('PHOTO-rifas.jpeg', 'rifas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rifas.jpeg'),
  ('PHOTO-rockstar.jpeg', 'rockstar.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rockstar.jpeg'),
  ('PHOTO-rosadecracker.jpeg', 'rosadecracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rosadecracker.jpeg'),
  ('PHOTO-rosadelluz.jpeg', 'rosadelluz.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rosadelluz.jpeg'),
  ('PHOTO-sabritas.jpeg', 'sabritas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/sabritas.jpeg'),
  ('PHOTO-silbato.jpeg', 'silbato.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/silbato.jpeg'),
  ('PHOTO-silbatoloco.jpeg', 'silbatoloco.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/silbatoloco.jpeg'),
  ('PHOTO-silbatolocourba.jpeg', 'silbatolocourba.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/silbatolocourba.jpeg'),
  ('PHOTO-silbatotoroloco.jpeg', 'silbatotoroloco.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/silbatotoroloco.jpeg'),
  ('PHOTO-sonic.jpeg', 'sonic.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/sonic.jpeg'),
  ('PHOTO-sorullo.jpeg', 'sorullo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/sorullo.jpeg'),
  ('PHOTO-supermario.jpeg', 'supermario.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/supermario.jpeg'),
  ('PHOTO-supersonaja.jpeg', 'supersonaja.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/supersonaja.jpeg'),
  ('PHOTO-tamalitos.jpeg', 'tamalitos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tamalitos.jpeg'),
  ('PHOTO-tanquedeguerra.jpeg', 'tanquedeguerra.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tanquedeguerra.jpeg'),
  ('PHOTO-tarolitosdeluz.jpeg', 'tarolitosdeluz.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tarolitosdeluz.jpeg'),
  ('PHOTO-thewalkingdeathcracker.jpeg', 'thewalkingdeathcracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/thewalkingdeathcracker.jpeg'),
  ('PHOTO-torbellino.jpeg', 'torbellino.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/torbellino.jpeg'),
  ('PHOTO-toritos.jpeg', 'toritos.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/toritos.jpeg'),
  ('PHOTO-tormentaluminosa.jpeg', 'tormentaluminosa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tormentaluminosa.jpeg'),
  ('PHOTO-tornado.jpeg', 'tornado.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tornado.jpeg'),
  ('PHOTO-tortuguitas.jpeg', 'tortuguitas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tortuguitas.jpeg'),
  ('PHOTO-trabuco.jpeg', 'trabuco.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabuco.jpeg'),
  ('PHOTO-trabucodecolores.jpeg', 'trabucodecolores.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabucodecolores.jpeg'),
  ('PHOTO-trabucoespecial.jpeg', 'trabucoespecial.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabucoespecial.jpeg'),
  ('PHOTO-trabucoluzycracker.jpeg', 'trabucoluzycracker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabucoluzycracker.jpeg'),
  ('PHOTO-trabucomixi.jpeg', 'trabucomixi.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabucomixi.jpeg'),
  ('PHOTO-trabuquitoluminoso.jpeg', 'trabuquitoluminoso.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trabuquitoluminoso.jpeg'),
  ('PHOTO-trompito.jpeg', 'trompito.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/trompito.jpeg'),
  ('PHOTO-unicornio.jpeg', 'unicornio.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/unicornio.jpeg'),
  ('PHOTO-Vara Chiflador.jpeg', 'Vara Chiflador.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/Vara%20Chiflador.jpeg'),
  ('PHOTO-vara pajarera.jpeg', 'vara pajarera.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/vara%20pajarera.jpeg'),
  ('PHOTO-varaurba.jpeg', 'varaurba.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/varaurba.jpeg'),
  ('PHOTO-venom.jpeg', 'venom.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/venom.jpeg'),
  ('PHOTO-volcan de diamantina.jpeg', 'volcan de diamantina.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/volcan%20de%20diamantina.jpeg'),
  ('BAT-tortasoldado', 'tortasoldado.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tortasoldado.jpeg'),
  ('BAT-alegria', 'alegria.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/alegria.jpeg'),
  ('BAT-amazonas', 'amazonas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/amazonas.jpeg'),
  ('BAT-armonia', 'armonia.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/armonia.jpeg'),
  ('BAT-azteca', 'azteca.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/azteca.jpeg'),
  ('BAT-bigbang', 'bigbang.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bigbang.jpeg'),
  ('BAT-bolero', 'bolero.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/bolero.jpeg'),
  ('BAT-borabora', 'borabora.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/borabora.jpeg'),
  ('BAT-brasil', 'brasil.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/brasil.jpeg'),
  ('BAT-brillante', 'brillante.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/brillante.jpeg'),
  ('BAT-celebracion', 'celebracion.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/celebracion.jpeg'),
  ('BAT-confetideluces', 'confetideluces.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/confetideluces.jpeg'),
  ('BAT-cosmopolitan', 'cosmopolitan.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/cosmopolitan.jpeg'),
  ('BAT-españa', 'españa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/espa%C3%B1a.jpeg'),
  ('BAT-espectacular', 'espectacular.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/espectacular.jpeg'),
  ('BAT-estelar', 'estelar.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/estelar.jpeg'),
  ('BAT-europa', 'europa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/europa.jpeg'),
  ('BAT-fantasia', 'fantasia.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fantasia.jpeg'),
  ('BAT-felicidad', 'felicidad.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/felicidad.jpeg'),
  ('BAT-felizaño', 'felizaño.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/feliza%C3%B1o.jpeg'),
  ('BAT-feria', 'feria.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/feria.jpeg'),
  ('BAT-festival', 'festival.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/festival.jpeg'),
  ('BAT-fiesta', 'fiesta.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fiesta.jpeg'),
  ('BAT-fiestahawaiana', 'fiestahawaiana.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fiestahawaiana.jpeg'),
  ('BAT-fiestalatina', 'fiestalatina.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fiestalatina.jpeg'),
  ('BAT-fiestaregia', 'fiestaregia.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fiestaregia.jpeg'),
  ('BAT-fortuna', 'fortuna.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/fortuna.jpeg'),
  ('BAT-happy', 'happy.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/happy.jpeg'),
  ('BAT-hawai', 'hawai.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/hawai.jpeg'),
  ('BAT-jackspot', 'jackspot.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/jackspot.jpeg'),
  ('BAT-japon', 'japon.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/japon.jpeg'),
  ('BAT-lasvegas', 'lasvegas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/lasvegas.jpeg'),
  ('BAT-mariachis5estrellas', 'mariachis5estrellas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mariachis5estrellas.jpeg'),
  ('BAT-maya', 'maya.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/maya.jpeg'),
  ('BAT-medianoche', 'medianoche.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/medianoche.jpeg'),
  ('BAT-mexicopower', 'mexicopower.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/mexicopower.jpeg'),
  ('BAT-nochedefiesta', 'nochedefiesta.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/nochedefiesta.jpeg'),
  ('BAT-nochemagica', 'nochemagica.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/nochemagica.jpeg'),
  ('BAT-olmeca', 'olmeca.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/olmeca.jpeg'),
  ('BAT-paraiso', 'paraiso.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/paraiso.jpeg'),
  ('BAT-poker', 'poker.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/poker.jpeg'),
  ('BAT-ranchera', 'ranchera.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ranchera.jpeg'),
  ('BAT-remolinosmulticolor', 'remolinosmulticolor.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/remolinosmulticolor.jpeg'),
  ('BAT-ruleta', 'ruleta.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/ruleta.jpeg'),
  ('BAT-rumba', 'rumba.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/rumba.jpeg'),
  ('BAT-salsa', 'salsa.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/salsa.jpeg'),
  ('BAT-samba', 'samba.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/samba.jpeg'),
  ('BAT-showbravo', 'showbravo.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/showbravo.jpeg'),
  ('BAT-showcaribe', 'showcaribe.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/showcaribe.jpeg'),
  ('BAT-showverbena', 'showverbena.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/showverbena.jpeg'),
  ('BAT-sonrisas', 'sonrisas.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/sonrisas.jpeg'),
  ('BAT-storm', 'storm.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/storm.jpeg'),
  ('BAT-supershow', 'supershow.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/supershow.jpeg'),
  ('BAT-tequila', 'tequila.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tequila.jpeg'),
  ('BAT-tierra', 'tierra.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tierra.jpeg'),
  ('BAT-tornadocake', 'tornadocake.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/tornadocake.jpeg'),
  ('BAT-USA', 'USA.jpeg', 'https://jovas777xd-ux.github.io/the-piquins/USA.jpeg');

create table if not exists public.piquins_respaldo_fotos_20261127 (
  codigo text primary key,
  imagen_anterior text,
  url_propuesta text not null,
  respaldado_en timestamptz not null default now()
);
alter table public.piquins_respaldo_fotos_20261127 enable row level security;
-- Sin políticas ni GRANT a anon/authenticated: solo SQL Editor/propietario.
insert into public.piquins_respaldo_fotos_20261127
  (codigo, imagen_anterior, url_propuesta)
select p.codigo, p.imagen, m.url_oficial
from public.piquins_productos p
join piquins_fotos_oficiales m on m.codigo = p.codigo
where p.imagen is distinct from m.url_oficial
  and (
    p.imagen is null
    or p.imagen !~* '^https?://'
    or p.imagen like 'https://jovas777xd-ux.github.io/the-piquins/%'
  )
on conflict (codigo) do nothing;

update public.piquins_productos p
set imagen = m.url_oficial
from piquins_fotos_oficiales m
where p.codigo = m.codigo
  and p.imagen is distinct from m.url_oficial
  and (
    p.imagen is null
    or p.imagen !~* '^https?://'
    or p.imagen like 'https://jovas777xd-ux.github.io/the-piquins/%'
  );

select
  count(*) as respaldos_guardados,
  (select count(*) from public.piquins_productos p
   join piquins_fotos_oficiales m on m.codigo = p.codigo
   where p.imagen = m.url_oficial) as originales_con_url_estandar,
  (select count(*) from public.piquins_productos p
   where p.imagen like 'https://wwamrosmrcjnlsaagdyg.supabase.co/storage/%')
   as fotos_de_supabase_preservadas
from public.piquins_respaldo_fotos_20261127;
commit;
