-- Base de datos del Bodegón Fruticarnes del Oeste
-- Pega todo este texto en Supabase > SQL Editor y toca "Run".

create table if not exists public.dias (
  fecha text primary key,             -- 2026-11-24
  movs jsonb not null default '[]',   -- ventas y pagos del día
  actualizado timestamptz not null default now()
);

create table if not exists public.productos (
  id text primary key,
  data jsonb not null,                -- nombre, unidad, costo, precio, ajustes...
  actualizado timestamptz not null default now()
);

create table if not exists public.config (
  clave text primary key,
  valor jsonb not null
);

-- Seguridad: solo usuarios con sesión iniciada pueden ver y guardar.
alter table public.dias enable row level security;
alter table public.productos enable row level security;
alter table public.config enable row level security;

drop policy if exists "usuarios del bodegon" on public.dias;
drop policy if exists "usuarios del bodegon" on public.productos;
drop policy if exists "usuarios del bodegon" on public.config;
create policy "usuarios del bodegon" on public.dias for all to authenticated using (true) with check (true);
create policy "usuarios del bodegon" on public.productos for all to authenticated using (true) with check (true);
create policy "usuarios del bodegon" on public.config for all to authenticated using (true) with check (true);

grant select, insert, update, delete on public.dias, public.productos, public.config to authenticated;

-- Para que lo que guarda la administradora aparezca al instante en tu pantalla.
alter table public.dias replica identity full;
alter table public.productos replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.dias, public.productos;
exception when duplicate_object then null; end $$;
