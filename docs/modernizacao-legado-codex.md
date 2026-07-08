# Modernizacao De Legado No Codex

Este workspace contem uma versao otimizada para Codex da metodologia de modernizacao de sistemas legados originalmente organizada para Claude.

## Arquivos Criados

- `.codex/skills/modernizacao-legado/SKILL.md`: skill principal Codex.
- `.codex/skills/modernizacao-legado/agents/openai.yaml`: metadados de interface da skill.
- `.codex/skills/modernizacao-legado/references/inspecao-banco.md`: playbook read-only para banco legado.
- `.codex/skills/modernizacao-legado/references/perfil-laravel-filament.md`: perfil de destino PHP 8.4+ / Laravel / Filament.
- `.codex/agents/arquiteto-modernizacao-legado.md`: agente local/persona operacional para missoes longas.
- `docs/modernizacao-legado-codex.md`: este guia.

## Para Que Serve

A skill guia o Codex em missoes de arqueologia de dominio e modernizacao de sistemas legados. Ela transforma codigo, banco e camada intermediaria em documentacao tecnica rastreavel para reconstrucao.

Ela deve ser usada quando a tarefa envolver:

- sistema legado em producao;
- codigo PHP antigo ou procedural;
- camada MVC parcial em `app/`;
- extracao de regras de negocio;
- leitura de banco ou dump;
- comparacao entre legado, banco e camada intermediaria;
- plano de migracao;
- reconstrucao em Laravel + Filament ou outra stack moderna.

## Como Usar A Skill

Uso explicito:

```text
Use $modernizacao-legado para auditar este sistema legado e produzir docs/legacy-modernization/.
```

Uso com parametros:

```text
Use $modernizacao-legado. O legado esta em ./legacy, a camada intermediaria em ./app, o dump esta em ./database/dump.sql e a stack alvo e Laravel + Filament.
```

Uso por etapa:

```text
Use $modernizacao-legado para executar apenas as etapas 0 a 2: reconhecimento, inventario e banco atual.
```

Saida esperada por padrao:

```text
docs/legacy-modernization/
  README.md
  _progresso.md
  00-resumo-executivo.md
  01-inventario-legado.md
  ...
  15-riscos-pontos-abertos.md
```

## Como Usar O Agente Local

O arquivo `.codex/agents/arquiteto-modernizacao-legado.md` define a persona e o protocolo de sessao para missoes longas.

Uso recomendado:

```text
Use a skill $modernizacao-legado e siga tambem o agente local .codex/agents/arquiteto-modernizacao-legado.md.
```

Observacao: skills Codex sao o mecanismo principal de descoberta. O arquivo em `.codex/agents/` e um artefato local de instrucao/persona; sua ativacao automatica depende do harness ou do prompt usado. Por isso, a skill principal contem o fluxo completo mesmo sem o agente.

## Diferencas Entre Claude E Codex

Na versao Claude:

- a skill fica em `.claude/skills/modernizacao-legado/SKILL.md`;
- o agente fica em `.claude/agents/nando-arquiteto-modernizacao-legado.md`;
- o pacote `.skill` e um ZIP instalavel no ecossistema Claude;
- a skill original carrega mais conteudo diretamente no `SKILL.md`.

Na versao Codex:

- a skill fica em `.codex/skills/modernizacao-legado/`;
- `SKILL.md` foi reduzido e organizado por progressive disclosure;
- detalhes de banco e Laravel/Filament foram movidos para `references/`;
- `agents/openai.yaml` fornece metadados de UI;
- `.codex/agents/arquiteto-modernizacao-legado.md` guarda a persona operacional local;
- a documentacao de uso fica fora da skill, em `docs/`, para nao poluir o pacote.

## Instalacao Local

Neste workspace, a skill ja esta criada em:

```text
.codex/skills/modernizacao-legado
```

Se o harness Codex carregar skills do workspace, basta invocar `$modernizacao-legado`.

Para instalar globalmente no ambiente do usuario, copie a pasta da skill para o diretório de skills do Codex:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R .codex/skills/modernizacao-legado "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Se quiser manter tambem o agente local em escopo global:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/agents"
cp .codex/agents/arquiteto-modernizacao-legado.md "${CODEX_HOME:-$HOME/.codex}/agents/"
```

## Validacao

Validar a estrutura da skill:

```bash
python3 "${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py" .codex/skills/modernizacao-legado
```

Conferir metadados:

```bash
sed -n '1,120p' .codex/skills/modernizacao-legado/agents/openai.yaml
```

> Se a skill `skill-creator` não estiver instalada no seu Codex, instale-a antes de validar. O caminho acima assume o layout padrao da skill system do Codex.

## Regras De Seguranca

- A missao e documental.
- Codigo legado, banco, configuracao e dados nao devem ser alterados.
- Banco de producao exige autorizacao explicita.
- Amostras de dados devem ser anonimizadas.
- Segredos devem ser mascarados.
- Toda decisao tecnica relevante deve ter evidencia.
