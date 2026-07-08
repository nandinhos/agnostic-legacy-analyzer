# Etapa 6: Regras De Negocio

Detalhamento da etapa 6 do SKILL.md. Use ao escrever `06-regras-de-negocio.md`.

## Objetivo

Extrair do legado o conjunto de regras que governam o comportamento real do sistema, distinguindo regra canonica de acidente de implementacao. Esta etapa alimenta diretamente a modelagem do banco novo (etapa 7), a camada de aplicacao (etapa 8) e a estrategia de testes (etapa 12).

## Entregavel

Arquivo `06-regras-de-negocio.md` com: lista completa de regras, cada uma com o modelo *Regra* preenchido, classificacao por marcador, evidencia dupla obrigatoria e recomendacao de destino (preservar, refatorar, descartar, isolar). O documento deve permitir reconstrucao sem reabrir o codigo legado.

## Fontes De Evidencia

- SQL: clausulas `WHERE`, `JOIN`, `CHECK`, `UNIQUE`, `TRIGGER`, `STORED PROCEDURE`, defaults de coluna e regras de `ON DELETE` / `ON UPDATE`.
- Codigo legado: condicionais em paginas, includes, classes e funcoes utilitarias. Preferir arquivos citados pela etapa 1.
- Camada intermediaria: services, models, validadores, observers e middlewares, quando existir; comparar com o que o legado faz.
- Tela legada: campos obrigatorios, regras de habilitacao, ordem de campos, mascaras, mensagens de erro e fluxos de botao. Tela e evidencia, nao especificacao.
- Relatorios: filtros aplicados, colunas calculadas, restricoes de exibicao e ordenacoes obrigatorias. Filtros escondem invariantes.
- Rotina operacional: tarefas agendadas, scripts de conciliacao, fechamento, importacao, exportacao e reprocessamento. Cron e shell script sao codigo.
- Documentacao do owner: contratos, manuais, e-mails e tickets. So conta como fonte corroborante; nao como fonte primaria.

## Classificacao

Cada regra recebe um marcador da secao "Marcadores" do SKILL.md:

- `REGRA CANONICA`: codigo + banco (ou codigo + camada intermediaria) apontam a mesma coisa. Caso forte, base do dominio.
- `REGRA PROVAVEL`: aparece em uma fonte com boa coerencia interna, mas falta a segunda evidencia. Tratar como `HIPOTESE` ate validar com owner.
- `HIPOTESE`: inferida do dominio, sem ancora tecnica direta. Nao pode virar requisito sem confirmacao.
- `REGRA DUPLICADA`: mesma regra implementada duas vezes (legado + camada intermediaria, ou dois formularios, ou dois caminhos de importacao). Manter uma fonte canonica; eliminar a outra com plano.
- `REGRA CONFLITANTE`: implementacoes diferentes em partes diferentes do sistema. Registrar todas as variantes, marcar a vencedora, planejar saneamento na etapa 11.
- `REGRA OBSOLETA`: ja nao faz sentido para o negocio atual, mas o legado ainda aplica. Confirmar com owner antes de descartar; remover exige migration consciente.
- `REGRA PERIGOSA`: protege integridade operacional (fechamento, conciliacao, validacao financeira, calculo de juros). Preservar com red flag ate reconstruir; testar antes de tocar.

## Formato Do Registro

Use o modelo *Regra* definido em `references/modelos-registro.md`. Sem modelo nao ha regra; sem classificacao nao ha decisao. Quando uma regra envolver mais de um marcador (ex.: conflitante + obsoleta), registrar a regra com cada marcador aplicavel, indicando qual domina.

## Exigencia De Evidencia Dupla

Regra sem evidencia dupla nao passa de `REGRA PROVAVEL`. "Dupla" significa duas fontes independentes e corroborantes: tipicamente codigo + banco, ou codigo + camada intermediaria. Uma query so nao basta; um trecho de codigo so nao basta; comentario no codigo nao conta como fonte. Quando a segunda evidencia for inacessivel, marcar `VALIDAR COM OWNER` e listar a regra em `15-riscos-pontos-abertos.md` como pendencia bloqueante.

## Criterios De Qualidade

- Toda regra do modelo *Regra* tem pelo menos um trecho de evidencia por fonte citada (arquivo:linha, query, constraint, observacao de tela).
- Toda regra com impacto financeiro, juridico ou operacional tem `RISCO CRITICO` quando nao ha dupla evidencia.
- O conjunto total de regras cobre 100% das condicionais de tela, filtros de relatorio e constraints de banco listados nas etapas 1, 2 e 3.
- Nenhuma regra canonica e descartada sem marcadores `LEGADO A DESCARTAR` ou `REESCREVER` e concordancia do owner.
- Toda regra `REGRA DUPLICADA` e `REGRA CONFLITANTE` tem plano de saneamento registrado, com prazo.
- Toda regra `REGRA PERIGOSA` tem teste de regressao planejado na etapa 12.
- O documento passa o teste do novato: dado um cenario do dia a dia, o leitor consegue apontar qual regra se aplica, com evidencia e marcador.

## Relacao Com Outras Etapas

- Consome: entidades canonicas da etapa 5, comparativo da etapa 4, modelo *Regra* de `references/modelos-registro.md`.
- Alimenta: etapa 7 (constraints do banco novo derivam das `REGRA CANONICA` com dupla evidencia), etapa 8 (Actions, Services, Policies e Value Objects encapsulam `REGRA PERIGOSA` e `REGRA CANONICA`), etapa 9 (visibilidade de botao e Policy vem de regra, nao de UI), etapa 11 (saneamento resolve `REGRA DUPLICADA` e `REGRA CONFLITANTE`) e etapa 12 (testes de regressao cobrem `REGRA CANONICA` e `REGRA PERIGOSA`).
- Em caso de divergencia entre regra daqui e comparativo da etapa 4, este documento vence para a regra canonica; o comparativo vence para a divergencia a ser saneada.

## Armadilhas Comuns

- Tratar comentario no codigo como fonte: comentario e opiniao; nao substitui evidencia.
- Aceitar `REGRA PROVAVEL` em area financeira ou juridica: regra que move dinheiro exige dupla evidencia, sem excecao.
- Esquecer regras de horario e rotina: tarefas cron e scripts de fechamento escondem regras criticas que nao aparecem em tela.
- Esquecer permissoes de botao: quem pode cancelar, reabrir ou excluir e regra de negocio, mesmo que o legado nao a registre em lugar estruturado.
- Misturar `REGRA OBSOLETA` com `LEGADO A DESCARTAR`: regra obsoleta ainda esta em vigor ate o saneamento; descartar e decisao posterior, so apos o owner confirmar.
