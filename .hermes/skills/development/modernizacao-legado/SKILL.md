---
name: modernizacao-legado
description: "Use when the task involves legacy systems, code archaeology, domain modeling, database reverse engineering, migration planning, or stack modernization (PHP/Laravel/Filament or other modern stacks). Produces traceable technical documentation without altering legacy code, database, configuration, or data."
version: 1.0.0
author: Fernando Dos Santos
license: MIT
metadata:
  hermes:
    tags: [legacy, modernization, archaeology, documentation, php, laravel, filament]
    related_skills: []
---

# Modernizacao de Sistemas Legados

Use esta skill para conduzir uma missao de arqueologia de dominio dentro do Hermes Agent (Nous Research): observar o sistema real, separar regra de negocio de acidente de implementacao e produzir documentacao suficiente para reconstruir o sistema em uma arquitetura moderna.

A saida normal vive em `docs/legacy-modernization/`. A missao e documental: nao editar codigo legado, nao alterar banco, nao executar DML/DDL e nao tratar comportamento defeituoso como requisito.

## Contrato Operacional

1. Comecar por reconhecimento read-only: arvore do projeto, pontos de entrada, stack, configuracoes mascaradas, banco disponivel e camada intermediaria se existir.
2. Registrar progresso em `docs/legacy-modernization/_progresso.md`; toda retomada le esse arquivo antes de continuar.
3. Escrever documentos incrementalmente. Nao acumular uma fase inteira apenas no contexto.
4. Citar evidencia em cada conclusao relevante: `arquivo:linha`, `tabela.coluna`, query de leitura, contagem ou amostra anonimizada.
5. Usar `HIPOTESE`, `VALIDAR COM OWNER`, `FORTE INDICIO` ou `DECISAO CANONICA` quando a confianca importar.
6. Preservar dados pessoais e segredos: anonimizar exemplos e mascarar credenciais.
7. Para missoes longas, manter plano visivel e validar consistencia entre documentos antes do fechamento.

## Parametros Da Missao

Inferir do repositorio sempre que possivel; perguntar apenas quando a resposta for bloqueante:

- raiz do legado;
- local de camada intermediaria, por exemplo `app/`, se existir;
- forma de acesso ao banco: dump, replica, cliente read-only ou phpMyAdmin;
- se a base e producao; producao exige autorizacao explicita;
- stack de destino;
- diretorio de documentacao, padrao `docs/legacy-modernization/`;
- idioma, padrao idioma do usuario.

## Referencias Sob Demanda

- Antes de analisar banco ou dump SQL, ler `references/inspecao-banco.md` (ou `~/.hermes/skills/development/modernizacao-legado/references/inspecao-banco.md` quando instalado globalmente).
- Se a stack de destino for PHP 8.4+ / Laravel / Filament, ler `references/perfil-laravel-filament.md` antes das etapas 7, 8, 9 e ao complementar testes.
- Para executar a missao como persona especializada local, carregar tambem `.hermes/SOUL.md` deste distribution; ele define a postura, o protocolo de sessao e a definicao de pronto do Hermes-agent.

## Separacoes Obrigatorias

Nunca misturar:

```text
regra de negocio real   != implementacao legada
fluxo operacional real  != ordem das telas
entidade de dominio     != tabela existente
campo existente         != campo necessario
camada intermediaria    != arquitetura final
SQL legado              != regra canonica
tela antiga             != caso de uso
comentario no codigo    != documentacao confiavel
```

## Marcadores

Confianca e decisao: `DECISAO CANONICA`, `FORTE INDICIO`, `HIPOTESE`, `REGRA CONFLITANTE`, `LEGADO A PRESERVAR`, `LEGADO A DESCARTAR`, `REESCREVER`, `VALIDAR COM OWNER`, `RISCO CRITICO`.

Classificacao de legado: `REGRA CANONICA`, `COMPORTAMENTO LEGADO`, `GAMBIARRA`, `DUPLICIDADE`, `RISCO`, `CANDIDATO A DESCARTE`, `CANDIDATO A REESCRITA`, `CANDIDATO A PRESERVACAO`.

Classificacao de regras: `REGRA CANONICA`, `REGRA PROVAVEL`, `HIPOTESE`, `REGRA DUPLICADA`, `REGRA CONFLITANTE`, `REGRA OBSOLETA`, `REGRA PERIGOSA`.

Mapeamento com a versao Claude (acentuacao plena -> ASCII puro): `CANONICA` -> `CANONICA`, `PRESERVACAO` -> `PRESERVACAO`, `PROVAVEL` -> `PROVAVEL`, `INDICIO` -> `INDICIO`, `CRITICO` -> `CRITICO`. Mesmo semantico, representacao diferente por encoding policy.

## Etapas E Entregaveis

Preservar a numeracao porque ela codifica dependencias. As etapas 1-3 podem intercalar; a etapa 4 depende delas; etapas 5-6 dependem da 4; etapas 7+ dependem de 5-6. Escrever `00-resumo-executivo.md` por ultimo.

0. Reconhecimento e plano: criar `README.md` e `_progresso.md`.
1. `01-inventario-legado.md`: paginas, includes, autenticacao, permissoes, formularios, relatorios, uploads, rotinas, integracoes.
2. `02-banco-de-dados-atual.md`: tabelas, colunas, volumes, estados reais, relacionamentos explicitos e implicitos.
3. `03-camada-intermediaria.md`: classes, responsabilidades reais, divergencias e reaproveitamento possivel.
4. `04-comparativo-legado-banco-intermediario.md`: funcionalidade x codigo x banco x camada intermediaria x regra canonica.
5. `05-dominio-canonico.md`: modulos, entidades, agregados, value objects, enums, eventos e de-para de nomes. Detalhes em `references/etapa-5-dominio-canonico.md`.
6. `06-regras-de-negocio.md`: regras com evidencia, criticidade, risco e recomendacao. Detalhes em `references/etapa-6-regras-negocio.md`.
7. `07-modelagem-banco-novo.md`: modelo novo orientado a dominio, nao copia do schema atual.
8. `08-camada-de-aplicacao.md`: actions, services, policies, queries, DTOs, eventos e testes necessarios.
9. `09-ui-administrativa.md`: UI derivada do dominio; telas legadas sao evidencia, nao molde.
10. `10-perfis-acesso-auditoria.md`: matriz de permissoes, acoes criticas, justificativas e trilha.
11. `11-plano-conceitual-migracao.md`: de-para, transformacoes, saneamento, validacoes e riscos.
12. `12-testes.md`: testes de dominio, regras, autorizacao, relatorios, calculos, migracao e regressao observada.
13. `13-roadmap-modernizacao.md`: fases, dependencias, tarefas pequenas, entregaveis, riscos e aceite.
14. `14-decisoes-arquiteturais.md`: ADRs com contexto, decisao, alternativas rejeitadas e consequencias.
15. `15-riscos-pontos-abertos.md`: riscos, perguntas ao owner e pendencias consolidadas.
16. Fechamento: `00-resumo-executivo.md`, README atualizado e verificacao de consistencia.

## Modelos De Registro

Os 6 modelos (item de inventario, tabela, classe intermediaria, entidade canonica, regra, ADR) estao detalhados em `references/modelos-registro.md`. Carregue esse arquivo ao iniciar a etapa correspondente.

## Disciplina Hermes

Esta skill e a versao Hermes Agent (Nous Research) da mesma metodologia. Veja `.codex/skills/modernizacao-legado/SKILL.md`, `.claude/skills/modernizacao-legado/SKILL.md` e `.opencode/skills/modernizacao-legado/SKILL.md` para as outras versoes. A equivalencia cross-harness vive em `docs/comparativo-harnesses.md` quando existir.

- Usar `rg`/`rg --files` para reconhecimento.
- Usar `apply_patch` para escrever documentacao gerada no workspace (default habilitado em `.hermes/config.yaml`).
- Nao alterar codigo de producao, dados, migracoes, seeds ou configuracao do legado.
- Se uma validacao precisar de banco de producao, parar e pedir autorizacao explicita.
- Se encontrar credenciais, nao transcrever; registrar apenas a existencia mascarada.
- Quando delegar a subagente/CLI, passar escopo fechado e exigir escrita direta no documento-alvo; revisar antes de integrar.
- **Encoding policy:** esta skill e suas references usam ASCII puro (sem acentos). Marcadores canonicos sao grafados sem acentuacao (`CANONICA`, `PRESERVACAO`, `PROVAVEL`, `INDICIO`). A versao Claude do mesmo skill usa acentuacao plena; isso e intencional e o mapeamento Claude->Hermes vive na secao "Marcadores" deste arquivo. Qualquer divergencia alem das listadas ali e drift a ser corrigido.

## Verification Checklist

Antes de declarar a missao como pronta, o Hermes-agent deve confirmar cada item abaixo:

- [ ] Reconhecimento read-only concluido (etapa 0): `README.md` e `_progresso.md` criados e atualizados.
- [ ] Etapas 1-6 documentadas com evidencia (`arquivo:linha`, `tabela.coluna`, query, contagem) e marcador de confianca quando aplicavel.
- [ ] Etapas 7-15 escritas a partir do dominio canonico, sem copiar schema ou UI legada como molde.
- [ ] Validacao de consistencia rodada: entidade canonica -> tabela, regra canonica -> onde vive e como se testa, tela -> caso de uso, risco critico -> etapa 15, renome -> de-para.
- [ ] `00-resumo-executivo.md` escrito por ultimo, sintetizando o que o sistema faz, o que e canonico vs acidental, e por onde comecar a reconstrucao.
- [ ] Nenhum codigo legado, banco, configuracao, migracao, seed ou dado foi alterado durante a missao; credenciais estao mascaradas; amostras estao anonimizadas.
- [ ] Cross-harness equivalence verificada: esta entrega e consistente com `.codex/`, `.claude/` e `.opencode/` para os mesmos pontos da metodologia; diferencas estao registradas em `docs/comparativo-harnesses.md` quando existirem.

## Fechamento

A missao esta pronta quando outra pessoa consegue, lendo apenas `docs/legacy-modernization/`, responder: o que o sistema faz, quais regras sao reais, quais sao acidentais, quais tabelas sustentam cada funcionalidade, quais entidades devem existir na arquitetura nova, o que migrar, sanear ou descartar, o que aproveitar da camada intermediaria, como testar e por onde comecar a reconstrucao.
