# Agnostic Legacy Analyzer

Workflows agnosticos para agentes analisarem sistemas legados, extrairem dominio e planejarem modernizacao com evidencia rastreavel.

## Objetivo

Este repositorio organiza versoes otimizadas de uma metodologia de arqueologia de dominio para diferentes harnesses de agentes: Claude (Code), Codex, OpenCode, Hermes (Agent) e Antigravity (CLI).

A metodologia ajuda a transformar um sistema legado real em documentacao tecnica suficiente para reconstrucao:

- inventario do legado;
- leitura segura do banco atual;
- extracao de regras de negocio;
- separacao entre requisito real e acidente de implementacao;
- dominio canonico;
- modelagem de banco novo;
- camada de aplicacao;
- UI administrativa;
- permissoes e auditoria;
- plano conceitual de migracao;
- estrategia de testes;
- roadmap e ADRs.

## Estrutura

```text
.claude/     Versao Claude Code (skill + agent + 2 references)
.codex/      Versao Codex CLI (skill + agent + 2 references + 3 advanced)
.opencode/   Versao OpenCode (skill + agent + 2 references)
.hermes/     Versao Hermes Agent (distribution + SOUL + skill + 2 references)
.antigravity/ Versao Antigravity CLI (skill + agent + 2 references)
docs/        Documentacao de uso, instalacao, comparativo
scripts/     Scripts de validacao (check-marker-drift.sh)
```

Leia primeiro `README-FOR-AGENTS.md` se voce for um agente ou estiver criando uma nova versao para outro harness.

## Principio Central

A analise e documental e read-only. Codigo legado, banco, configuracao e dados nao devem ser alterados. Toda conclusao importante deve apontar para evidencia: arquivo e linha, tabela e coluna, query de leitura, contagem ou amostra anonimizada.

## Status

- Claude: versao inicial implementada.
- Codex: versao otimizada implementada.
- OpenCode: versao implementada.
- Hermes: versao implementada.
- Antigravity: versao implementada.
- Polish cross-harness: CI de drift de marcadores + comparativo-harnesses.md.

## Guias

- [`README-FOR-AGENTS.md`](README-FOR-AGENTS.md): entry point para agentes. Estrutura recomendada, regras para criar novas versoes por harness, saida padrao da metodologia, criterios de qualidade.
- [`docs/modernizacao-legado-codex.md`](docs/modernizacao-legado-codex.md): guia de uso da versao Codex (instalacao, fluxo, validacao).
- [`docs/comparativo-harnesses.md`](docs/comparativo-harnesses.md): matriz 5×N dos harnesses suportados, com paths, encoding, convencoes e equivalencias.
- [`scripts/check-marker-drift.sh`](scripts/check-marker-drift.sh): CI de drift de marcadores. Rode antes de commit ou em pipeline.
