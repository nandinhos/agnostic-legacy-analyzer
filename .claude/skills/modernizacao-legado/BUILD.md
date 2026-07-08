# Build do Pacote `.skill`

Documenta o que é o arquivo `modernizacao-legado.skill`, como foi gerado, e quando regenerar.

## O que é

O arquivo `modernizacao-legado.skill` é um bundle instalável no ecossistema Claude (ZIP, magic bytes `PK`). O `SKILL.md` desta pasta é o source of truth; o `.skill` é o artefato distribuível.

## Conteúdo

```text
Archive:  .claude/skills/modernizacao-legado/modernizacao-legado.skill
  Length      Date    Time    Name
---------  ---------- -----   ----
    17600  2026-07-08 14:08   modernizacao-legado/SKILL.md
     6888  2026-07-08 14:07   modernizacao-legado/references/perfil-laravel-filament.md
     4593  2026-07-08 14:07   modernizacao-legado/references/inspecao-banco.md
---------                     -------
    29081                     3 files
```

## Como regenerar

```bash
cd .claude/skills/modernizacao-legado
zip -r modernizacao-legado.skill . -x '*.bak' '*.tmp' 'BUILD.md'
```

## Quando regenerar

Sempre que houver mudança em `SKILL.md` ou em qualquer arquivo dentro de `references/`. O `.skill` deve entrar no mesmo commit que a alteração.

## Validação

Para conferir que o `.skill` está em sincronia com os fontes:

```bash
unzip -l .claude/skills/modernizacao-legado/modernizacao-legado.skill
```

Compare o output com a seção "Conteúdo" acima. Se algum arquivo esperado não estiver lá, o bundle está defasado.