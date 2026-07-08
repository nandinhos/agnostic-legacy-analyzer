# Inspecao Somente Leitura Do Banco Legado

Use este playbook na etapa 2 ou quando o banco for a principal fonte de evidencia. O objetivo e extrair comportamento real sem risco operacional.

## Regras Inviolaveis

1. Executar somente comandos de leitura. Nunca `INSERT`, `UPDATE`, `DELETE`, `ALTER`, `DROP` ou `TRUNCATE`.
2. Base de producao exige autorizacao explicita do owner; preferir dump, replica ou usuario read-only.
3. Anonimizar toda amostra levada para documentacao: nomes, documentos, e-mails, telefones e enderecos viram placeholders.
4. Mascarar credenciais em docs: `DB_PASS=***`.
5. Em tabelas grandes, `COUNT` e `GROUP BY` podem pesar; usar estatisticas do catalogo ou rodar fora de horario critico.

## MySQL / MariaDB

Visao geral:

```sql
SHOW TABLES;
SELECT table_name, table_rows, ROUND(data_length / 1024 / 1024, 1) AS mb
FROM information_schema.tables
WHERE table_schema = DATABASE()
ORDER BY data_length DESC;
```

Estrutura e indices:

```sql
SHOW CREATE TABLE nome_tabela;
SHOW INDEX FROM nome_tabela;
```

Foreign keys declaradas:

```sql
SELECT table_name, column_name, referenced_table_name, referenced_column_name
FROM information_schema.key_column_usage
WHERE table_schema = DATABASE()
  AND referenced_table_name IS NOT NULL;
```

Estados reais em campo generico:

```sql
SELECT status, COUNT(*)
FROM nome_tabela
GROUP BY status
ORDER BY 2 DESC;
```

Volume e amostra recente:

```sql
SELECT COUNT(*) FROM nome_tabela;
SELECT MIN(data_criacao), MAX(data_criacao) FROM nome_tabela;
SELECT * FROM nome_tabela ORDER BY id DESC LIMIT 20;
```

## PostgreSQL

Catalogo e constraints:

```sql
SELECT relname AS tabela, n_live_tup AS linhas_aprox
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

SELECT conrelid::regclass AS tabela, conname, pg_get_constraintdef(oid)
FROM pg_constraint
WHERE contype = 'f';
```

No `psql`, usar `\dt+` e `\d nome_tabela`. As consultas de `GROUP BY`, `COUNT`, `MIN/MAX` e amostragem seguem a mesma logica do MySQL.

## Heuristicas De Banco Legado

Foreign key ausente nao significa relacionamento ausente. Procurar joins e filtros no codigo (`JOIN nome_tabela`, `WHERE ... coluna_id`) e registrar o relacionamento implicito com `arquivo:linha`.

Campos genericos escondem regras. Para `status`, `tipo`, `situacao`, `categoria`, `obs` e `descricao`, enumerar valores reais e procurar cada valor no codigo.

Campos serializados e JSON devem ser abertos. Registrar estrutura interna e decidir se vira coluna, tabela propria, value object ou descarte.

Tabela suspeita de orfa so pode ser classificada apos busca no codigo e verificacao temporal (`MAX(data)` ou equivalente).

Tabelas duplicadas ou de backup (`clientes_old`, `clientes2`, `clientes_bkp`) devem ter estrutura, volume e data maxima comparados antes de qualquer decisao.

Sinais de risco de migracao: charset/collation mistos, datas em `varchar`, dinheiro em `float`, placeholders como `0000-00-00`, string vazia em `NOT NULL`, contagens divergentes entre tabelas relacionadas e regras escondidas em texto livre.

## Registro Por Tabela

Preencher o modelo da skill: nome; finalidade aparente; finalidade real; colunas; relacionamentos explicitos; relacionamentos implicitos com evidencia; volume; qualidade dos dados; risco de migracao; entidade canonica; destino.
