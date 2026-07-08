# Agnostic Legacy Analyzer

Workflows agnosticos para agentes analisarem sistemas legados, extrairem dominio e planejarem modernizacao com evidencia rastreavel.

## Objetivo

Este repositorio organiza versoes otimizadas de uma metodologia de arqueologia de dominio para diferentes harnesses de agentes, como Claude, Codex, OpenCode e Hermes.

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
.claude/   Versao original para Claude
.codex/    Versao otimizada para Codex
.opencode/ Reservada para versao OpenCode
.hermes/   Reservada para versao Hermes
docs/      Documentacao de uso, instalacao e diferencas
```

Leia primeiro `README-FOR-AGENTS.md` se voce for um agente ou estiver criando uma nova versao para outro harness.

## Principio Central

A analise e documental e read-only. Codigo legado, banco, configuracao e dados nao devem ser alterados. Toda conclusao importante deve apontar para evidencia: arquivo e linha, tabela e coluna, query de leitura, contagem ou amostra anonimizada.

## Status

- Claude: versao inicial existente.
- Codex: versao otimizada criada.
- OpenCode: pendente.
- Hermes: pendente.

## Guias

- [`README-FOR-AGENTS.md`](README-FOR-AGENTS.md): entry point para agentes. Estrutura recomendada, regras para criar novas versoes por harness, saida padrao da metodologia, criterios de qualidade.
- [`docs/modernizacao-legado-codex.md`](docs/modernizacao-legado-codex.md): guia de uso da versao Codex (instalacao, fluxo, validacao).
