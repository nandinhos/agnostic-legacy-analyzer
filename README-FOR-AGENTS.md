# Guia Para Agentes

Este workspace e um repositorio de artefatos para gerar versoes otimizadas da metodologia de modernizacao de sistemas legados em diferentes harnesses de agentes.

O objetivo nao e manter uma unica traducao mecanica entre ferramentas. Cada harness deve gerar sua propria versao idiomatica, usando seus mecanismos nativos de skill, agente, plugin, prompt ou configuracao.

## Escopo Do Workspace

Este projeto guarda:

- a versao original para Claude;
- a versao otimizada para Codex;
- futuras versoes para OpenCode e Hermes;
- documentacao comparativa e guias de instalacao/uso.

O conteudo funcional principal e a metodologia de arqueologia de dominio e modernizacao de sistemas legados: auditar codigo e banco reais, extrair regras, separar acidente de requisito e produzir documentacao para reconstrucao.

## Estrutura Recomendada

```text
.
├── .claude/
│   ├── agents/
│   └── skills/
├── .codex/
│   ├── agents/
│   └── skills/
├── .opencode/
│   └── ...
├── .hermes/
│   └── ...
├── docs/
│   ├── modernizacao-legado-codex.md
│   ├── modernizacao-legado-opencode.md
│   ├── modernizacao-legado-hermes.md
│   └── comparativo-harnesses.md
└── README-FOR-AGENTS.md
```

## Pastas Existentes

### `.claude/`

Contem a versao original para Claude:

- `.claude/skills/modernizacao-legado/SKILL.md`
- `.claude/skills/modernizacao-legado/modernizacao-legado.skill`
- `.claude/agents/nando-arquiteto-modernizacao-legado.md`

Use como referencia sem assumir que o formato serve diretamente para outros harnesses.

### `.codex/`

Contem a versao otimizada para Codex. Status: implementada e polida (Sprint 2).

- `.codex/skills/modernizacao-legado/SKILL.md`
- `.codex/skills/modernizacao-legado/agents/openai.yaml`
- `.codex/skills/modernizacao-legado/references/inspecao-banco.md`
- `.codex/skills/modernizacao-legado/references/perfil-laravel-filament.md`
- `.codex/agents/arquiteto-modernizacao-legado.md`

A versao Codex usa progressive disclosure: o `SKILL.md` fica como contrato operacional enxuto e detalhes ficam em `references/`.

### `.opencode/`

Contem a versao OpenCode:

- `.opencode/skills/modernizacao-legado/SKILL.md`: skill principal OpenCode.
- `.opencode/skills/modernizacao-legado/references/`: references read-only (banco + perfil Laravel/Filament).
- `.opencode/agents/arquiteto-modernizacao-legado.md`: agente local/persona operacional.

A versao OpenCode herda a metodologia do Codex (progressive disclosure, encoding policy ASCII) e o estilo de agent do Claude (persona condensada). Use o proprio harness OpenCode para iterar.

### `.hermes/`

Contem a versao Hermes Agent (Nous Research) da metodologia, no formato de distribuicao:

- `.hermes/distribution.yaml`: manifest da distribuicao.
- `.hermes/SOUL.md`: agent/persona (substitui o `agent.md` de outros harnesses).
- `.hermes/config.yaml`: configuracao do modelo.
- `.hermes/skills/development/modernizacao-legado/`: skill principal + references (inspecao-banco, perfil-laravel-filament).

A versao Hermes herda a metodologia do Codex/OpenCode (progressive disclosure, encoding policy ASCII) e a estrutura de agent do OpenCode (PT pleno no SOUL.md).

### `docs/`

Guarda documentacao voltada a humanos e agentes:

- formas de uso;
- diferencas entre harnesses;
- instalacao local/global;
- limitacoes;
- criterios de validacao;
- comparativo entre versoes.

Documentacao auxiliar deve ficar em `docs/`, nao dentro das skills, quando nao for necessaria para execucao direta da skill.

## Pastas Do Harness Que Podem Aparecer

Alguns ambientes criam placeholders locais, por exemplo:

- `.agents/`
- `.git/`

Se estiverem vazias ou read-only, trate como artefatos do harness atual. Nao usar como fonte funcional do projeto e nao tentar remove-las sem necessidade.

No estado observado deste workspace:

- `.agents/` estava vazia;
- `.git/` estava vazia;
- `git status` nao reconhecia o diretorio como repositorio Git real.

## Regra Para Criar Novas Versoes

Ao criar uma versao para outro harness:

1. Ler primeiro este `README-FOR-AGENTS.md`.
2. Ler a versao original em `.claude/`.
3. Ler a versao Codex em `.codex/` para entender a abstracao ja feita.
4. Usar o proprio harness alvo para gerar uma versao idiomatica.
5. Manter a mesma funcionalidade central.
6. Adaptar formato, nomes e metadados ao runtime alvo.
7. Criar ou atualizar documentacao em `docs/`.
8. Registrar diferencas importantes entre versoes.
9. Validar com o mecanismo nativo do harness, quando existir.

## Funcionalidade Minima A Preservar

Toda versao deve preservar estes elementos:

- missao documental, sem alterar codigo legado, banco, configuracao ou dados;
- reconhecimento read-only;
- inventario do legado;
- inspecao de banco somente leitura;
- avaliacao de camada intermediaria;
- matriz comparativa entre legado, banco e camada intermediaria;
- dominio canonico;
- regras de negocio com evidencia;
- modelagem nova de banco;
- camada de aplicacao;
- UI administrativa;
- permissoes e auditoria;
- plano conceitual de migracao;
- estrategia de testes;
- roadmap;
- ADRs;
- riscos e pontos abertos;
- resumo executivo final.

## Saida Padrao Da Metodologia

Quando a metodologia for usada em um projeto legado real, a saida padrao deve ser:

```text
docs/legacy-modernization/
├── README.md
├── _progresso.md
├── 00-resumo-executivo.md
├── 01-inventario-legado.md
├── 02-banco-de-dados-atual.md
├── 03-camada-intermediaria.md
├── 04-comparativo-legado-banco-intermediario.md
├── 05-dominio-canonico.md
├── 06-regras-de-negocio.md
├── 07-modelagem-banco-novo.md
├── 08-camada-de-aplicacao.md
├── 09-ui-administrativa.md
├── 10-perfis-acesso-auditoria.md
├── 11-plano-conceitual-migracao.md
├── 12-testes.md
├── 13-roadmap-modernizacao.md
├── 14-decisoes-arquiteturais.md
└── 15-riscos-pontos-abertos.md
```

O `00-resumo-executivo.md` deve ser escrito por ultimo.

## Criterios De Qualidade

Uma versao esta boa quando:

- aciona no harness certo sem depender de instrucoes externas excessivas;
- separa claramente skill, agente/persona, referencias e documentacao;
- nao duplica blocos longos desnecessariamente;
- usa carregamento sob demanda quando o harness permitir;
- preserva a regra de evidencia antes de conclusao;
- deixa claro o que e regra canonica, hipotese, risco ou pendencia;
- consegue orientar outro agente a produzir `docs/legacy-modernization/` sem contexto da conversa original.

## Cuidados

- Nao transformar a versao de um harness em fonte absoluta para outro.
- Nao remover artefatos de outros harnesses sem pedido explicito.
- Nao misturar documentacao de instalacao dentro da skill quando o harness recomenda manter a skill enxuta.
- Nao incluir segredos, dados pessoais reais ou exemplos sensiveis.
- Nao alterar a metodologia central sem registrar a diferenca em `docs/`.

