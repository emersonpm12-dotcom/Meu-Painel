-- MEU PAINEL - estrutura do banco (rode UMA vez no SQL Editor do Supabase)

create table if not exists public.docs (
  coll text not null,
  id text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (coll, id)
);

alter table public.docs enable row level security;
alter table public.docs replica identity full;

-- Somente usuarios LOGADOS (as 2 contas que voce criar) leem e gravam.
drop policy if exists docs_select on public.docs;
drop policy if exists docs_insert on public.docs;
drop policy if exists docs_update on public.docs;
drop policy if exists docs_delete on public.docs;
create policy docs_select on public.docs for select to authenticated using (true);
create policy docs_insert on public.docs for insert to authenticated with check (true);
create policy docs_update on public.docs for update to authenticated using (true) with check (true);
create policy docs_delete on public.docs for delete to authenticated using (true);

-- Atualiza so alguns campos de um registro (usado ao marcar pago, editar valor etc.)
create or replace function public.doc_update(p_coll text, p_id text, p_patch jsonb)
returns void language sql as $$
  insert into public.docs (coll, id, data) values (p_coll, p_id, p_patch)
  on conflict (coll, id)
  do update set data = public.docs.data || excluded.data, updated_at = now();
$$;

-- Liga o tempo real (um ve o lancamento do outro na hora)
do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='docs') then
    alter publication supabase_realtime add table public.docs;
  end if;
end $$;
