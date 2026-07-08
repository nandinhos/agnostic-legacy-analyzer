# Scripts do Repositório

Scripts auxiliares versionados para validação e operação do repositório.
Devem rodar em qualquer máquina com bash + grep + sed (sem dependências
externas) e usam apenas encoding ASCII puro.

## `check-marker-drift.sh`

Verifica que os 7 marcadores canônicos da seção `## Marcadores` / `Classificacao
de regras` dos cinco `SKILL.md` da metodologia de modernização de legados estão
consistentes entre as versões:

- `.claude/skills/modernizacao-legado/SKILL.md`
- `.codex/skills/modernizacao-legado/SKILL.md`
- `.opencode/skills/modernizacao-legado/SKILL.md`
- `.hermes/skills/development/modernizacao-legado/SKILL.md`
- `.antigravity/skills/modernizacao-legado/SKILL.md`

A versão Claude usa PT pleno com acentos; as outras quatro usam ASCII puro.
O script normaliza ambas as representações para ASCII puro (via `sed` com
escapes `\xHH`) antes de comparar contra o conjunto canônico esperado:
`REGRA CANONICA`, `REGRA PROVAVEL`, `HIPOTESE`, `REGRA DUPLICADA`,
`REGRA CONFLITANTE`, `REGRA OBSOLETA`, `REGRA PERIGOSA`.

### Como rodar

```bash
bash scripts/check-marker-drift.sh
```

Rode da raiz do repositório ou de qualquer subdiretório — o script resolve o
caminho absoluto a partir da própria localização (`$(dirname "$0")/..`).

### Códigos de saída

| Código | Significado |
| ------ | ----------- |
| `0`    | OK. Os 7 marcadores estão consistentes nos 5 arquivos. |
| `1`    | DRIFT detectado. Algum arquivo está faltando um marcador ou tem um marcador extra. A lista do que foi encontrado versus o esperado é impressa. |
| `2`    | Erro interno (não conseguiu chegar ao diretório do repositório). |

### Saída esperada em caso de sucesso

```
OK: marcadores consistentes entre 5 versoes (Claude, Codex, OpenCode, Hermes, Antigravity).
```

### Quando usar

- Antes de `git commit` ou `git push` que mexa em qualquer `SKILL.md`.
- Em pipeline de CI, como gate que falha se algum agente alterar apenas
  uma versão e esquecer de propagar para as outras.
