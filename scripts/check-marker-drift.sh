#!/bin/bash
# Verifica que os marcadores canonicos da secao "Classificacao de regras" estao
# consistentes entre as 5 versoes da metodologia. Rode antes de commit/push ou
# em CI. Para adicionar uma nova versao, duplique uma entrada em FILES abaixo.
#
# A normalizacao usa apenas escapes hex ASCII (sed \xHH) para que este script
# fique em ASCII puro mesmo tendo que mapear caracteres acentuados do Claude.

set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT" || exit 2

FILES=(
  ".claude/skills/modernizacao-legado/SKILL.md"
  ".codex/skills/modernizacao-legado/SKILL.md"
  ".opencode/skills/modernizacao-legado/SKILL.md"
  ".hermes/skills/development/modernizacao-legado/SKILL.md"
  ".antigravity/skills/modernizacao-legado/SKILL.md"
)

CANONICAL=(
  "REGRA CANONICA"
  "REGRA PROVAVEL"
  "HIPOTESE"
  "REGRA DUPLICADA"
  "REGRA CONFLITANTE"
  "REGRA OBSOLETA"
  "REGRA PERIGOSA"
)

normalize() {
  sed '
    s/\xc3[\xa0-\xa5]/a/g; s/\xc3[\x80-\x85]/A/g
    s/\xc3[\xa8-\xab]/e/g; s/\xc3[\x88-\x8b]/E/g
    s/\xc3[\xac-\xaf]/i/g; s/\xc3[\x8c-\x8f]/I/g
    s/\xc3[\xb2-\xb6]/o/g; s/\xc3[\x92-\x96]/O/g
    s/\xc3[\xb9-\xbc]/u/g; s/\xc3[\x99-\x9c]/U/g
    s/\xc3\xa7/c/g;       s/\xc3\x87/C/g
    s/\xc3\xb1/n/g;       s/\xc3\x91/N/g
  '
}

errors=0
for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || { echo "DRIFT: arquivo nao encontrado: $f"; errors=$((errors+1)); continue; }

  match_line=$(grep -in -m 1 'classifica.*de regras' "$f" | cut -d: -f1)
  if [[ -z "$match_line" ]]; then
    echo "DRIFT: rotulo 'Classificacao de regras' ausente em $f"
    errors=$((errors+1))
    continue
  fi

  # Captura o rotulo + proxima linha (cobre layout inline e o paragrafo do Claude),
  # extrai apenas o conteudo entre crases e mantem somente tokens com formato de
  # marcador canonico: comecam com "REGRA " (com espaco) ou sao exatamente "HIPOTESE".
  extracted=$(
    sed -n "${match_line},$((match_line+1))p" "$f" \
      | tr '`' '\n' \
      | normalize \
      | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/^[^A-Z]*//' \
      | grep -i -E '^(REGRA |HIPOTESE)' \
      | sort -u
  )

  expected=$(printf '%s\n' "${CANONICAL[@]}" | sort -u)
  if [[ "$extracted" != "$expected" ]]; then
    echo "DRIFT: $f"
    echo "  Esperado (7 marcadores canonicos):"
    printf '    %s\n' "${CANONICAL[@]}" | sort -u
    echo "  Encontrado (apos normalizar):"
    echo "$extracted" | sed 's/^/    /'
    errors=$((errors+1))
  fi
done

if [[ $errors -eq 0 ]]; then
  echo "OK: marcadores consistentes entre 5 versoes (Claude, Codex, OpenCode, Hermes, Antigravity)."
  exit 0
fi
echo ""
echo "DRIFT detectado em $errors arquivo(s)."
exit 1
