"use strict";

// THE PIQUINS usa el mismo proyecto Supabase que ALEXVAL, pero sus permisos
// y productos son totalmente independientes mediante RLS.
const cliente = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY, {
  auth: { persistSession: false, autoRefreshToken: true, detectSessionInUrl: true }
});
const campo = (id) => document.getElementById(id);
const mensajes = {
  login: campo("mensajeLogin"),
  guardar: campo("mensajeGuardar"),
  editar: campo("mensajeEditar"),
  productos: campo("mensajeProductos"),
  recuperacion: campo("mensajeRecuperacion")
};
let inventario = [];
// Fotos originales: en The Piquins están como archivos .jpeg de GitHub,
// por lo que NO es necesario copiarlas a Supabase Storage.
function fotoProducto(producto) {
  const foto = producto.imagen || "";
  if (!foto) return null;
  // Solo las URL absolutas apuntan directamente a Supabase Storage.
  // Los nombres de archivo .jpeg viven en la carpeta padre de /admin/.
  if (/^https?:\/\//i.test(foto)) return foto;
  // Mantener espacios, mayúsculas y tildes presentes en nombres originales.
  if (/^(?:\\.|\/|https?:)/i.test(foto) || foto.includes("..") || foto.includes("/") || foto.includes("\\\\")) return null;
  return "../" + encodeURIComponent(foto);
}

let administradoraAutorizada = false;
let comprobandoAcceso = false;
let recuperando = new URLSearchParams(location.hash.replace(/^#/, "")).get("type") === "recovery"
  || new URLSearchParams(location.search).get("type") === "recovery";

function pantalla(nombre) {
  for (const id of ["login", "recuperacion", "panel"]) {
    campo(id).hidden = id !== nombre;
  }
}

function informar(seccion, texto) {
  mensajes[seccion].textContent = texto || "";
}

function buscarTexto(valor) {
  return String(valor ?? "").normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "").toLocaleLowerCase("es").trim();
}

function pesos(valor) {
  if (valor === null || valor === "" || valor === undefined) return "Por cotizar";
  return new Intl.NumberFormat("es-MX", {
    style: "currency", currency: "MXN"
  }).format(Number(valor));
}

function valorPrecio(id) {
  const texto = campo(id).value.trim();
  if (!texto) return null;
  const numero = Number(texto);
  if (!Number.isFinite(numero) || numero < 0) {
    throw new Error("El precio debe ser un número mayor o igual a cero.");
  }
  return numero;
}

// Convierte conflictos de codigo en instrucciones claras para la administradora.
function mensajeErrorGuardado(error) {
  if (error && (error.code === "23505" || String(error.message || "").includes("piquins_productos_codigo_key"))) {
    return "Este código ya está registrado en THE PIQUINS. Busca el producto existente para editarlo o escribe otro código.";
  }
  return error?.message || String(error || "Error desconocido");
}

function codigoNuevo() {
  // UUID aleatorio: no depende del último código ni de otros negocios.
  return "TP-" + crypto.randomUUID().replace(/-/g, "").slice(0, 16).toUpperCase();
}

// Si hay colisión, PostgreSQL no inserta el producto. Es seguro reintentar
// usando otro código nuevo, sin volver a subir la misma fotografía.
function esConflictoCodigo(error) {
  return error?.code === "23505" && (
    String(error?.message || "").includes("piquins_productos_codigo_key") ||
    String(error?.details || "").includes("(codigo)=") ||
    String(error?.message || "").includes("Key (codigo)")
  );
}

async function insertarConCodigoUnico(nuevo) {
  const datos = { ...nuevo };
  for (let intento = 0; intento < 4; intento++) {
    const { error } = await cliente.from(TABLA_PRODUCTOS).insert(datos);
    if (!error) return datos.codigo;
    if (!esConflictoCodigo(error)) {
      throw new Error(mensajeErrorGuardado(error));
    }
    // Un código proporcionado manualmente también se sustituye si ya existe.
    datos.codigo = codigoNuevo();
  }
  throw new Error("No fue posible asignar un código único. Intenta nuevamente.");
}

function codigoRepetido(codigo, idExcluido = null) {
  if (!codigo) return false;
  const buscado = codigo.toLocaleUpperCase("es");
  return inventario.some(p =>
    p.codigo &&
    p.codigo.toLocaleUpperCase("es") === buscado &&
    (idExcluido === null || Number(p.id) !== Number(idExcluido))
  );
}

function datosFormulario(prefijo) {
  const editando = prefijo === "editar";
  const n = (id) => campo(editando ? "editar" + id : id.charAt(0).toLowerCase() + id.slice(1) + "Producto");
  const nombre = n("Nombre").value.trim();
  const categoria = n("Categoria").value.trim();
  if (!nombre || !categoria) throw new Error("Completa el nombre y la categoría.");
  return {
    nombre,
    categoria,
    codigo: n("Codigo").value.trim() || null,
    precio: valorPrecio(editando ? "editarPrecio" : "precioProducto"),
    descripcion: n("Descripcion").value.trim() || null,
    video: n("Video").value.trim() || null
  };
}

function esURLFotoSegura(url) {
  if (!url) return false;
  try {
    const parsed = new URL(url, location.href);
    return ["https:", "http:", "data:"].includes(parsed.protocol);
  } catch (_) {
    return false;
  }
}

async function subirFoto(archivo) {
  if (!archivo) return null;
  const extensiones = {
    "image/jpeg": "jpg", "image/png": "png", "image/webp": "webp"
  };
  const extension = extensiones[archivo.type];
  if (!extension) throw new Error("Solo se permiten imágenes JPG, PNG o WEBP.");
  if (archivo.size > 5 * 1024 * 1024) {
    throw new Error("La fotografía debe pesar menos de 5 MB.");
  }
  const ruta = "catalogo/" + crypto.randomUUID() + "." + extension;
  const { error } = await cliente.storage.from(BUCKET_PRODUCTOS)
    .upload(ruta, archivo, { contentType: archivo.type, upsert: false });
  if (error) throw new Error("No se pudo subir la fotografía: " + error.message);
  const { data } = cliente.storage.from(BUCKET_PRODUCTOS).getPublicUrl(ruta);
  return { ruta, url: data.publicUrl };
}

async function limpiarFoto(ruta) {
  if (ruta) {
    await cliente.storage.from(BUCKET_PRODUCTOS).remove([ruta]);
  }
}

async function validarCuenta() {
  if (comprobandoAcceso) return;
  comprobandoAcceso = true;
  try {
    if (recuperando) {
      pantalla("recuperacion");
      return;
    }
    const { data: { user }, error } = await cliente.auth.getUser();
    if (error || !user) {
      administradoraAutorizada = false;
      pantalla("login");
      return;
    }
    const { data, error: errorPermiso } = await cliente
      .from(TABLA_ADMINISTRADORES)
      .select("usuario_id")
      .eq("usuario_id", user.id)
      .maybeSingle();
    if (errorPermiso) throw new Error("No fue posible verificar permisos.");
    if (!data) {
      administradoraAutorizada = false;
      await cliente.auth.signOut();
      pantalla("login");
      informar("login", "Esta cuenta no tiene permisos para administrar THE PIQUINS.");
      return;
    }
    administradoraAutorizada = true;
    pantalla("panel");
    informar("login", "");
    await cargarProductos();
  } catch (error) {
    administradoraAutorizada = false;
    pantalla("login");
    informar("login", error.message || "No fue posible iniciar sesión.");
  } finally {
    comprobandoAcceso = false;
  }
}

campo("formLogin").addEventListener("submit", async (evento) => {
  evento.preventDefault();
  const boton = evento.currentTarget.querySelector("button[type=submit]");
  boton.disabled = true;
  informar("login", "Comprobando acceso...");
  try {
    const { error } = await cliente.auth.signInWithPassword({
      email: campo("correo").value.trim(),
      password: campo("contrasena").value
    });
    if (error) throw new Error("Correo o contraseña incorrectos.");
    await validarCuenta();
    if (administradoraAutorizada) campo("contrasena").value = "";
  } catch (error) {
    informar("login", error.message || "Error al iniciar sesión.");
  } finally {
    boton.disabled = false;
  }
});

campo("salir").addEventListener("click", async () => {
  await cliente.auth.signOut();
  administradoraAutorizada = false;
  inventario = [];
  campo("formLogin").reset();
  pantalla("login");
  informar("login", "Sesión cerrada.");
});

campo("enviarRecuperacion").addEventListener("click", async () => {
  const email = campo("correo").value.trim();
  if (!email) {
    informar("login", "Primero escribe tu correo en el campo de arriba.");
    campo("correo").focus();
    return;
  }
  try {
    const { error } = await cliente.auth.resetPasswordForEmail(email, {
      redirectTo: location.origin + location.pathname
    });
    if (error) throw error;
    informar("login", "Si el correo está registrado, recibirás un enlace de recuperación.");
  } catch (error) {
    informar("login", "No se pudo solicitar el correo: " + error.message);
  }
});

cliente.auth.onAuthStateChange((evento) => {
  if (evento === "PASSWORD_RECOVERY") {
    recuperando = true;
    pantalla("recuperacion");
  }
});

campo("formRecuperacion").addEventListener("submit", async (evento) => {
  evento.preventDefault();
  const boton = evento.currentTarget.querySelector("button[type=submit]");
  boton.disabled = true;
  try {
    const nueva = campo("nuevaContrasena").value;
    if (nueva.length < 8) throw new Error("Utiliza mínimo 8 caracteres.");
    const { error } = await cliente.auth.updateUser({ password: nueva });
    if (error) throw error;
    await cliente.auth.signOut();
    recuperando = false;
    history.replaceState(null, "", location.pathname);
    campo("formRecuperacion").reset();
    pantalla("login");
    informar("login", "Contraseña actualizada. Inicia sesión nuevamente.");
  } catch (error) {
    informar("recuperacion", "No se pudo cambiar la contraseña: " + error.message);
  } finally {
    boton.disabled = false;
  }
});

async function cargarProductos() {
  if (!administradoraAutorizada) return;
  informar("productos", "Cargando inventario...");
  try {
    const resultados = [];
    const paso = 500;
    for (let inicio = 0; inicio < 10000; inicio += paso) {
      const { data, error } = await cliente.from(TABLA_PRODUCTOS)
        .select("id,codigo,nombre,descripcion,categoria,precio,imagen,video,activo")
        .order("id", { ascending: true })
        .range(inicio, inicio + paso - 1);
      if (error) throw error;
      resultados.push(...(data || []));
      if (!data || data.length < paso) break;
    }
    inventario = resultados;
    informar("productos", "");
    actualizarCategorias();
    dibujarProductos();
    // Los archivos originales se sirven directamente desde GitHub Pages.
  } catch (error) {
    informar("productos", "Error al cargar productos: " + error.message);
  }
}

function actualizarCategorias() {
  const lista = campo("categoriasDisponibles");
  lista.replaceChildren();
  const categorias = [...new Set(inventario.map(p => p.categoria).filter(Boolean))].sort();
  for (const categoria of categorias) {
    const opt = document.createElement("option");
    opt.value = categoria;
    lista.append(opt);
  }
}

function crearBoton(etiqueta, accion, tipo) {
  const boton = document.createElement("button");
  boton.type = "button";
  boton.textContent = etiqueta;
  if (tipo) boton.className = tipo;
  boton.addEventListener("click", accion);
  return boton;
}

function dibujarProductos() {
  const lista = campo("listaProductos");
  lista.replaceChildren();
  const busqueda = buscarTexto(campo("buscarProducto").value);
  const filtro = campo("filtrarEstado").value;
  const filtrados = inventario.filter((producto) => {
    if (filtro === "visibles" && !producto.activo) return false;
    if (filtro === "ocultos" && producto.activo) return false;
    const indice = buscarTexto([producto.nombre, producto.categoria, producto.codigo, producto.descripcion].join(" "));
    return indice.includes(busqueda);
  });
  campo("contadorProductos").textContent =
    filtrados.length + " de " + inventario.length + " productos · " +
    inventario.filter(p => p.activo).length + " visibles · " +
    inventario.filter(p => !p.activo).length + " ocultos";

  if (!filtrados.length) {
    const vacio = document.createElement("p");
    vacio.className = "subtitle";
    vacio.textContent = inventario.length
      ? "No se encontraron productos con esos filtros."
      : "Todavía no hay productos en THE PIQUINS. Agrega el primero arriba.";
    lista.append(vacio);
    return;
  }
  for (const producto of filtrados) {
    const fila = document.createElement("article");
    fila.className = "product-row";
    const miniatura = document.createElement("div");
    miniatura.className = "product-thumb";
    const foto = fotoProducto(producto);
    if (esURLFotoSegura(foto)) {
      const img = document.createElement("img");
      img.src = foto;
      img.alt = "";
      img.loading = "lazy";
      img.addEventListener("error", () => {
        img.remove();
        miniatura.textContent = "Sin foto";
      }, { once: true });
      miniatura.append(img);
    } else miniatura.textContent = "Sin foto";

    const detalle = document.createElement("div");
    const nombre = document.createElement("strong");
    nombre.className = "product-title";
    nombre.textContent = producto.nombre;
    const meta = document.createElement("span");
    meta.className = "product-meta";
    meta.textContent = [producto.codigo, producto.categoria].filter(Boolean).join(" · ");
    const precio = document.createElement("span");
    precio.className = "product-price";
    precio.textContent = pesos(producto.precio);
    const estado = document.createElement("span");
    estado.className = "pill " + (producto.activo ? "pill-active" : "pill-hidden");
    estado.textContent = producto.activo ? "Visible" : "Oculto";
    detalle.append(nombre, meta, precio, estado);

    const acciones = document.createElement("div");
    acciones.className = "product-actions";
    const editar = crearBoton("Editar", () => editarProducto(producto));
    const alternar = crearBoton(producto.activo ? "Ocultar" : "Mostrar", () => cambiarEstado(producto));
    const eliminar = crearBoton("Eliminar", () => eliminarProducto(producto), "danger");
    eliminar.disabled = producto.activo;
    eliminar.title = producto.activo ? "Oculta el producto antes de eliminarlo" : "Eliminar producto oculto";
    acciones.append(editar, alternar, eliminar);
    fila.append(miniatura, detalle, acciones);
    lista.append(fila);
  }
}

async function cambiarEstado(producto) {
  if (!administradoraAutorizada) return;
  informar("productos", "Guardando cambio de visibilidad...");
  const { error } = await cliente.from(TABLA_PRODUCTOS)
    .update({ activo: !producto.activo }).eq("id", producto.id);
  if (error) {
    informar("productos", "No se pudo modificar: " + error.message);
    return;
  }
  await cargarProductos();
}

async function eliminarProducto(producto) {
  if (!administradoraAutorizada || producto.activo) return;
  const respuesta = prompt(
    "Para eliminar definitivamente este producto oculto, escribe su nombre exacto:\n" + producto.nombre
  );
  if (respuesta !== producto.nombre) return;
  informar("productos", "Eliminando producto...");
  const { data, error } = await cliente.from(TABLA_PRODUCTOS)
    .delete().eq("id", producto.id).eq("activo", false).select("id");
  if (error || !data || !data.length) {
    informar("productos", "No se pudo eliminar el producto: " + (error?.message || "Verifica que esté oculto."));
    return;
  }
  if (Number(campo("editarId").value) === Number(producto.id)) {
    campo("seccionEditar").hidden = true;
  }
  await cargarProductos();
}

function editarProducto(producto) {
  campo("editarId").value = producto.id;
  campo("editarNombre").value = producto.nombre;
  campo("editarCategoria").value = producto.categoria;
  campo("editarPrecio").value = producto.precio ?? "";
  campo("editarCodigo").value = producto.codigo ?? "";
  campo("editarDescripcion").value = producto.descripcion ?? "";
  campo("editarVideo").value = producto.video ?? "";
  campo("editarImagen").value = "";
  informar("editar", "");
  campo("seccionEditar").hidden = false;
  campo("seccionEditar").scrollIntoView({ behavior: "smooth", block: "start" });
}

campo("cancelarEdicion").addEventListener("click", () => {
  campo("seccionEditar").hidden = true;
  informar("editar", "");
});

campo("formProducto").addEventListener("submit", async (evento) => {
  evento.preventDefault();
  if (!administradoraAutorizada) return;
  const boton = evento.currentTarget.querySelector("button[type=submit]");
  boton.disabled = true;
  informar("guardar", "Guardando producto...");
  let subida = null;
  try {
    const datos = datosFormulario("");
    // Previene crear dos veces el mismo producto por los errores de versiones anteriores.
    const existente = inventario.find(p =>
      buscarTexto(p.nombre) === buscarTexto(datos.nombre) &&
      buscarTexto(p.categoria) === buscarTexto(datos.categoria) &&
      (p.precio === null ? null : Number(p.precio)) === datos.precio
    );
    if (existente) {
      throw new Error("Este producto ya aparece en el inventario (ID " + existente.id + "). Búscalo y usa Editar en lugar de guardarlo otra vez.");
    }

    // Si no escribió código, creamos uno. Si ya está ocupado, creamos otro.
    const codigoSolicitado = datos.codigo;
    datos.codigo = (codigoSolicitado && !codigoRepetido(codigoSolicitado))
      ? codigoSolicitado : codigoNuevo();
    subida = await subirFoto(campo("imagenProducto").files[0]);
    const nuevo = { ...datos, activo: false, imagen: subida?.url || null };
    const codigoGuardado = await insertarConCodigoUnico(nuevo);
    // La consulta terminó: ya no debemos eliminar la foto si falla la actualización de la lista.
    subida = null;
    // El evento no conserva currentTarget después de un await; usar el formulario por ID.
    campo("formProducto").reset();
    informar("guardar", "¡Producto guardado con código " + codigoGuardado + "! Está oculto hasta que pulses Mostrar.");
    await cargarProductos();
  } catch (error) {
    if (subida?.ruta) await limpiarFoto(subida.ruta);
    informar("guardar", "Error: " + error.message);
  } finally {
    boton.disabled = false;
  }
});

campo("formEditar").addEventListener("submit", async (evento) => {
  evento.preventDefault();
  if (!administradoraAutorizada) return;
  const boton = evento.currentTarget.querySelector("button[type=submit]");
  boton.disabled = true;
  informar("editar", "Guardando cambios...");
  let subida = null;
  try {
    const id = Number(campo("editarId").value);
    if (!inventario.some(p => Number(p.id) === id)) {
      throw new Error("Producto no encontrado. Actualiza la lista.");
    }
    const datos = datosFormulario("editar");
    if (codigoRepetido(datos.codigo, id)) {
      throw new Error("Este código ya está registrado en otro producto de THE PIQUINS. Escribe uno diferente.");
    }
    subida = await subirFoto(campo("editarImagen").files[0]);
    if (subida) datos.imagen = subida.url;
    const { error } = await cliente.from(TABLA_PRODUCTOS).update(datos).eq("id", id);
    if (error) throw new Error(mensajeErrorGuardado(error));
    campo("editarImagen").value = "";
    informar("editar", "¡Cambios guardados correctamente!");
    await cargarProductos();
  } catch (error) {
    if (subida?.ruta) await limpiarFoto(subida.ruta);
    informar("editar", "Error: " + error.message);
  } finally {
    boton.disabled = false;
  }
});

campo("actualizarProductos").addEventListener("click", cargarProductos);
campo("buscarProducto").addEventListener("input", dibujarProductos);
campo("filtrarEstado").addEventListener("change", dibujarProductos);

// No se conserva la sesión después de actualizar la página.
pantalla(recuperando ? "recuperacion" : "login");
if (!recuperando) validarCuenta();
