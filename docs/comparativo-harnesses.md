# Comparativo de Harnesses

Este documento é a referência cross-harness do workspace. Reunimos em uma matriz única as diferenças idiomáticas entre os cinco harnesses para os quais a metodologia de modernização de sistemas legados foi portada: Claude, Codex, OpenCode, Hermes (Nous Research) e Antigravity CLI (Google). Use-o como ponto de entrada antes de criar uma nova versão para outro harness ou antes de decidir qual harness adotar em um projeto.

A metodologia central é a mesma em todos (arqueologia de domínio, missão documental, marcadores canônicos de regras). O que muda é o **formato de empacotamento**: cada harness tem seus próprios caminhos, metadados, encoding policy e convenção de agente/persona. As tabelas abaixo destilam exatamente essas diferenças, observadas diretamente nos arquivos versionados deste repositório.

## Matriz de Harnesses

| Feature | Claude | Codex | OpenCode | Hermes | Antigravity |
| ------- | ------ | ----- | -------- | ------ | ----------- |
| Localização da skill | `.claude/skills/<name>/SKILL.md` | `.codex/skills/<name>/SKILL.md` | `.opencode/skills/<name>/SKILL.md` | `.hermes/skills/<category>/<name>/SKILL.md` | `.antigravity/skills/<name>/SKILL.md` |
| Localização da persona/agente | `.claude/agents/<name>.md` | `.codex/agents/<name>.md` | `.opencode/agents/<name>.md` | `.hermes/SOUL.md` (substitui `agent.md`) | `.antigravity/agents/<name>.md` |
| Arquivo de metadados extras | apenas frontmatter YAML no `SKILL.md` | `.codex/skills/<name>/agents/openai.yaml` (chaves `interface`) | apenas frontmatter YAML no `SKILL.md` | `.hermes/distribution.yaml` + `.hermes/config.yaml` | apenas frontmatter YAML no `SKILL.md` |
| Encoding policy do `SKILL.md` | PT pleno (com acentos) | ASCII puro | ASCII puro | ASCII puro | ASCII puro |
| Encoding da persona/agente | PT pleno | ASCII puro | PT pleno | PT pleno (no `SOUL.md`) | PT pleno |
| Campos de frontmatter da persona | `name`, `description`, `model` | `name`, `description`, `skill` | `name`, `description`, `model` | (sem frontmatter — `SOUL.md` é markdown puro) | `name`, `description`, `model` |
| Campos de frontmatter do `SKILL.md` | `name`, `description` | `name`, `description` | `name`, `description` | `name`, `description`, `version`, `author`, `license`, `metadata.hermes.tags`, `metadata.hermes.related_skills` | `name`, `description` |
| Categoria intermediária na pasta | não | não | não | sim — `skills/<category>/<name>/` (ex.: `development/`) | não |
| `references/` carregado sob demanda | opcional | sim (progressive disclosure explícito) | sim | sim | sim |
| Bloco de checagem/verificação dentro da skill | não documentado | não documentado | não documentado | sim (bloco curto no `SKILL.md`) | sim (em formato de nota no `SKILL.md`) |
| Distribuição própria (manifest) | não | não | não | sim — `.hermes/distribution.yaml` | não |
| Build artefact binário | sim — `.claude/skills/<name>/<name>.skill` (ZIP instalável) | não | não | não | não |
| Persona com texto em PT pleno | sim | sim | sim | sim | sim |
| `version: 1.0.0` no frontmatter do `SKILL.md` | (com esta fase, sim) | (no openai.yaml, sim) | (com esta fase, sim) | sim (pré-existente) | (com esta fase, sim) |
| Suporte a `references/` read-only | sim | sim | sim | sim | sim |

> Observação sobre "Categoria intermediária": apenas o Hermes obriga a um nível de categoria (por exemplo `development/`, `writing/`, `data/`) entre `skills/` e o nome da skill. Nos outros quatro, a skill fica diretamente em `skills/<name>/`.

## Equivalência de Caminhos

Use esta tabela quando souber o que quer fazer mas não souber em qual harness está olhando.

| Para encontrar... | Claude | Codex | OpenCode | Hermes | Antigravity |
| ----------------- | ------ | ----- | -------- | ------ | ----------- |
| Skill principal da metodologia | `.claude/skills/modernizacao-legado/SKILL.md` | `.codex/skills/modernizacao-legado/SKILL.md` | `.opencode/skills/modernizacao-legado/SKILL.md` | `.hermes/skills/development/modernizacao-legado/SKILL.md` | `.antigravity/skills/modernizacao-legado/SKILL.md` |
| Persona operacional do arquiteto | `.claude/agents/nando-arquiteto-modernizacao-legado.md` | `.codex/agents/arquiteto-modernizacao-legado.md` | `.opencode/agents/arquiteto-modernizacao-legado.md` | `.hermes/SOUL.md` (único por agente) | `.antigravity/agents/arquiteto-modernizacao-legado.md` |
| Metadados/manifest da skill | (no próprio frontmatter) | `.codex/skills/modernizacao-legado/agents/openai.yaml` | (no próprio frontmatter) | `.hermes/distribution.yaml` (por skill) | (no próprio frontmatter) |
| Configuração de modelo | (no frontmatter da persona) | (no frontmatter da persona) | (no frontmatter da persona) | `.hermes/config.yaml` | (no frontmatter da persona) |
| Playbook read-only de banco | `.claude/skills/modernizacao-legado/references/inspecao-banco.md` | `.codex/skills/modernizacao-legado/references/inspecao-banco.md` | `.opencode/skills/modernizacao-legado/references/inspecao-banco.md` | `.hermes/skills/development/modernizacao-legado/references/inspecao-banco.md` | `.antigravity/skills/modernizacao-legado/references/inspecao-banco.md` |
| Perfil de stack alvo (Laravel/Filament) | `.claude/skills/modernizacao-legado/references/perfil-laravel-filament.md` | `.codex/skills/modernizacao-legado/references/perfil-laravel-filament.md` | `.opencode/skills/modernizacao-legado/references/perfil-laravel-filament.md` | `.hermes/skills/development/modernizacao-legado/references/perfil-laravel-filament.md` | `.antigravity/skills/modernizacao-legado/references/perfil-laravel-filament.md` |
| Documentação voltada ao humano | `docs/` | `docs/modernizacao-legado-codex.md` e este comparativo | `docs/modernizacao-legado-opencode.md` | `docs/modernizacao-legado-hermes.md` | `docs/` (mesma raiz) |
| Guia para futuros agentes | `README-FOR-AGENTS.md` (raiz) | mesmo | mesmo | mesmo | mesmo |

## Convenções de Encoding

| Aspecto | Claude | Codex | OpenCode | Hermes | Antigravity |
| ------- | ------ | ----- | -------- | ------ | ----------- |
| `SKILL.md` | PT pleno, com acentos | ASCII puro | ASCII puro | ASCII puro | ASCII puro |
| Persona / agente | PT pleno, com acentos | ASCII puro | PT pleno | PT pleno (no `SOUL.md`, sem frontmatter) | PT pleno |
| Arquivos em `references/` | segue policy do `SKILL.md` | ASCII puro | ASCII puro | ASCII puro | ASCII puro |
| Arquivos de metadados/manifest | YAML/JSON UTF-8 quando houver | ASCII puro | ASCII puro | ASCII puro | ASCII puro |
| Mapeamento entre as duas formas | (origem) | `CANÔNICA` → `CANONICA`, `PROVÁVEL` → `PROVAVEL`, `INDÍCIO` → `INDICIO`, `CRÍTICO` → `CRITICO`, `PRESERVAÇÃO` → `PRESERVACAO` | idem Codex | idem Codex | idem Codex |

> Os harnesses de ASCII puro documentam o mapeamento com a versão Claude exatamente na seção "Mapeamento com a versão Claude" do bloco `## Marcadores` de cada `SKILL.md`. Esse mapeamento é a regra canônica que o script `scripts/check-marker-drift.sh` usa para comparar os marcadores sem ruído de encoding.

## Equivalência de Marcadores

A seção `## Marcadores` de cada `SKILL.md` define o vocabulário que a metodologia usa para classificar evidências e regras. Após normalização para ASCII puro, os 7 marcadores da linha "Classificação de regras" devem ser idênticos nos cinco arquivos — é o que `scripts/check-marker-drift.sh` garante. Resumo compacto abaixo:

| Marcador (forma PT pleno, no Claude) | Forma ASCII puro (Codex, OpenCode, Hermes, Antigravity) | Significado |
| ------------------------------------- | ---------------------------------------------------------- | ----------- |
| `REGRA CANÔNICA` | `REGRA CANONICA` | Regra de negócio confirmada por evidência no banco e/ou código, sem conflito. |
| `REGRA PROVÁVEL` | `REGRA PROVAVEL` | Alta confiança, mas com lacuna de evidência; precisa de uma consulta a mais. |
| `HIPÓTESE` | `HIPOTESE` | Afirmação plausível, mas ainda sem prova documental. |
| `REGRA DUPLICADA` | `REGRA DUPLICADA` | Existe em mais de um lugar do legado; precisa decidir uma fonte canônica. |
| `REGRA CONFLITANTE` | `REGRA CONFLITANTE` | Código e banco (ou duas camadas) dizem coisas diferentes; precisa de decisão. |
| `REGRA OBSOLETA` | `REGRA OBSOLETA` | Codificada, mas nenhum caminho de UI nem dado recente a exercita. |
| `REGRA PERIGOSA` | `REGRA PERIGOSA` | Codificada com vetor de risco (segurança, integridade, LGPD); não replicar sem análise. |

> Além desses sete, cada `SKILL.md` traz outros dois blocos (`Confiança de afirmações` e `Classificação de itens do legado`) com vocabulário adicional. Eles também estão normalizados entre as cinco versões — o script `check-marker-drift.sh` valida especificamente o bloco "Classificação de regras" porque é o mais crítico para classificação de regras de negócio extraídas do legado.

## Como Criar uma Nova Versão

1. Ler primeiro `README-FOR-AGENTS.md` (raiz) e este `docs/comparativo-harnesses.md` para entender o baseline.
2. Ler `.claude/skills/modernizacao-legado/SKILL.md` (a origem) e, em paralelo, `.codex/skills/modernizacao-legado/SKILL.md` (a abstração mais limpa, com progressive disclosure já aplicado).
3. Estudar qual é o mecanismo nativo de skill+agente do harness alvo — alguns têm pasta de categoria intermediária, outros exigem arquivo de manifesto próprio (ex.: Hermes), outros não passam de frontmatter.
4. Portar a metodologia usando o próprio harness alvo como ferramenta de iteração — não traduzir mecanicamente, deixar o harness apontar caminhos idiomáticos.
5. Manter a mesma funcionalidade central (ver seção "Funcionalidade Mínima A Preservar" em `README-FOR-AGENTS.md`).
6. Adaptar encoding, nomes e metadados ao runtime (ex.: Claude aceita PT pleno; Codex/Hermes preferem ASCII puro na skill).
7. Adicionar a skill ao array `FILES` em `scripts/check-marker-drift.sh` para que o CI pegue drift futuro.
8. Criar/atualizar uma página em `docs/` para a nova versão e atualizar este comparativo com a nova linha de matriz.
9. Validar com `bash scripts/check-marker-drift.sh` e com o mecanismo nativo de validação do harness, quando existir.

## Quando Usar Qual

A escolha do harness é quase sempre ditada pelo projeto (onde a skill vai ser carregada). Em ordem decrescente de carga cognitiva para o owner: **Claude** é a experiência mais "polida" para uso interativo e tem o único build artefact binário (`.skill`); **Codex** é a versão de progressive disclosure mais enxuta, ideal quando o agente já é o Codex; **OpenCode** é a referência se você quer rodar a mesma metodologia dentro de uma stack opencode-native; **Hermes** é a escolha se você precisa de um manifesto de distribuição versionado e do bloco de checagem embutido na skill; **Antigravity CLI** é a escolha se o seu ambiente usa o CLI do Google Antigravity e você quer manter uma skill `.antigravity/` dedicada. Para uma comparação mais ampla de cada versão (não só paths/encoding) veja os documentos específicos em `docs/`.
