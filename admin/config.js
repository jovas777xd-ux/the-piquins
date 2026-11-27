// Configuración PUBLICA de THE PIQUINS.
// Usa el proyecto de Supabase de ALEXVAL, pero NO sus tablas ni su bucket.
// La protección real está en las políticas RLS y en piquins_administradores.
// Nunca pongas contraseñas, sb_secret_ ni service_role aquí.
const SUPABASE_URL = "https://wwamrosmrcjnlsaagdyg.supabase.co";
const SUPABASE_KEY = "sb_publishable_KGIVJ7X6-6HtagspP0se3Q_vr1l1UOR";
const TABLA_PRODUCTOS = "piquins_productos";
const TABLA_ADMINISTRADORES = "piquins_administradores";
const BUCKET_PRODUCTOS = "piquins-productos";
