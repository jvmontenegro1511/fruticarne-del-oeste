# Guía: publicar la app del Bodegón Fruticarnes del Oeste

Vas a usar tres servicios gratuitos:

- **Supabase:** guarda los datos (cierres, inventario) y los usuarios con contraseña.
- **GitHub:** guarda los archivos de la app.
- **Vercel:** publica la app en internet con un enlace propio.

Tiempo: unos 30 minutos. Se puede hacer desde el teléfono, pero desde una computadora es más cómodo.

---

## Parte 1 — Supabase (la base de datos)

**Paso 1. Crea la cuenta y el proyecto**
1. Entra a **supabase.com** y toca **Start your project**.
2. Regístrate con tu correo (o con GitHub, si ya creaste esa cuenta).
3. Toca **New project**:
   - **Name:** `fruticarnes`
   - **Database Password:** inventa una y **guárdala** en un lugar seguro.
   - **Region:** *East US (North Virginia)*.
4. Toca **Create new project** y espera 1 o 2 minutos a que termine.

**Paso 2. Crea las tablas**
1. En el menú de la izquierda entra a **SQL Editor**.
2. Abre el archivo **schema.sql** (viene en el paquete), copia **todo** su contenido y pégalo en el editor.
3. Toca **Run**. Debe salir *Success. No rows returned*.

**Paso 3. Cierra el registro público y crea los usuarios**
1. Ve a **Authentication → Sign In / Providers** y **desactiva** *Allow new users to sign up*. Así nadie que encuentre el enlace se puede registrar; solo entran las personas que tú crees. Guarda los cambios.
2. Ve a **Authentication → Users → Add user → Create new user**.
3. Crea **tu usuario**: tu correo, una contraseña y marca **Auto Confirm User**.
4. Repite el paso con **el correo de la administradora** y una contraseña temporal. Ella la puede cambiar después dentro de la app con el botón *Cambiar contraseña*.

**Paso 4. Copia las dos claves de conexión**
1. Ve a **Project Settings** (el engranaje) → **API Keys** (o **Data API**).
2. Copia el **Project URL**. Tiene esta forma: `https://abcdxyz.supabase.co`
3. Copia la clave **anon public**. Si ves una pestaña *Legacy API keys*, está ahí. Si no aparece, usa la **Publishable key** (empieza con `sb_publishable_`).
4. ⚠️ **Nunca** uses la clave *service_role* ni la *secret*: esas son privadas.

Guarda las dos cosas en tus notas; las vas a pegar en el paso 6.

---

## Parte 2 — GitHub (guardar los archivos)

**Paso 5. Sube los archivos**
1. Descomprime el archivo **fruticarnes-vercel.zip**. En iPhone, tócalo en la app *Archivos*; en Android, ábrelo con *Files* o *Archivos*.
2. Entra a **github.com** y crea una cuenta gratis.
3. Toca **+ → New repository**:
   - **Repository name:** `fruticarnes`
   - Márcalo como **Private**.
   - Toca **Create repository**.
4. En la página del repositorio toca **uploading an existing file**.
5. Selecciona **todos** los archivos de la carpeta: `index.html`, `config.js`, `logo.png`, `icon-192.png`, `icon-512.png`, `manifest.json`, `schema.sql`, `GUIA.md`.
6. Toca **Commit changes**.

**Paso 6. Pon tus claves en config.js** *(ya viene lleno en tu paquete; sáltalo)*
1. Dentro del repositorio abre **config.js** y toca el lápiz ✏️ (*Edit*).
2. Reemplaza `PEGA_AQUI_TU_PROJECT_URL` por tu Project URL y `PEGA_AQUI_TU_ANON_PUBLIC_KEY` por tu clave anon o publishable. Deja las comillas.

   Así debe quedar:
   ```js
   window.FRUTI_CONFIG = {
     url: "https://abcdxyz.supabase.co",
     key: "eyJhbGciOi...la clave completa..."
   };
   ```
3. Toca **Commit changes**.

---

## Parte 3 — Vercel (publicar la app)

**Paso 7. Publica**
1. Entra a **vercel.com** y toca **Sign Up → Continue with GitHub**. Elige el plan *Hobby* (gratis).
2. Toca **Add New… → Project**.
3. Busca el repositorio **fruticarnes** y toca **Import**. Si no aparece, toca *Adjust GitHub App Permissions* y dale acceso.
4. En **Framework Preset** deja **Other**. No cambies nada más.
5. Toca **Deploy**. En menos de un minuto te da un enlace, por ejemplo **https://fruticarnes.vercel.app**.

**Paso 8. Prueba**
1. Abre el enlace y entra con **tu** correo y contraseña.
2. En **Inventario**, agrega un producto de prueba.
3. Abre el mismo enlace en otro teléfono o en otra pestaña: el producto debe aparecer ahí también. Después lo puedes borrar.

Si sale *"Falta configurar la conexión"*, revisa el paso 6. Si sale *"Correo o contraseña incorrectos"*, revisa el paso 3.

---

## Parte 4 — Enviarlo a la administradora

1. Mándale por WhatsApp el **enlace de Vercel**, **su correo** y **su contraseña temporal**.
2. Ella lo abre en el navegador del teléfono (Chrome o Safari) y entra.
3. Para tenerlo como app en la pantalla del teléfono:
   - **Android (Chrome):** menú ⋮ → *Agregar a la pantalla principal* (o *Instalar app*).
   - **iPhone (Safari):** botón Compartir → *Agregar a inicio*.
4. Ella debe tocar **Cambiar contraseña** y poner una suya.

---

## Para después

- **Hacer cambios a la app:** pídeselos a Claude, sube el `index.html` nuevo a GitHub (*Add file → Upload files*, reemplaza el anterior) y Vercel la actualiza solo en un minuto.
- **Agregar otra persona:** Supabase → Authentication → Users → *Add user*.
- **Quitarle el acceso a alguien:** Supabase → Authentication → Users → los tres puntos de esa persona → *Delete user*.
- **Copia de seguridad:** en Supabase → *Table Editor* → tabla `dias` o `productos` → *Export to CSV*.
- **Si un proyecto gratis de Supabase pasa una semana sin uso, se pausa.** Si la usan a diario no pasa. Si llegara a pausarse, entra a supabase.com y toca *Restore*.
