# Etapa 5: Dominio Canonico

Detalhamento da etapa 5 do SKILL.md. Use ao escrever `05-dominio-canonico.md`.

## Objetivo

Reconstruir o modelo mental do sistema a partir do legado, separando o que o sistema faz (regra canonica) de como o legado foi montado (acidente de implementacao). Esta etapa alinha a equipe antes de modelar o banco novo e serve de contrato para as etapas 7, 8 e 9.

## Entregavel

Arquivo `05-dominio-canonico.md` com: lista de modulos e bounded contexts, entidades canonicas (cada uma com o modelo *Entidade Canonica* de `references/modelos-registro.md`), agregados, value objects, enums, eventos de dominio, separacao de tipos de dados e o de-para de nomes legado -> canonico.

## Elementos Do Dominio

- Modulo: agrupamento funcional de alta coerencia. Liste os modulos e o que cada um cobre. Modulo nao confunde com pasta do codigo nem com rota de tela; pergunta de teste: se eu deletar X, o que quebra junto.
- Bounded context: fronteira explicita onde termos e regras tem significado estavel. Sistemas legados raramente os declaram; infira a partir de quem usa cada tabela e cada classe. Quando dois contextos discordam do mesmo termo, registrar a ambiguidade e qual contexto vence.
- Entidade canonica: objeto de identidade continua, com ciclo de vida proprio. Preencha o modelo *Entidade Canonica* completo para cada uma; nunca registre entidade por tabela. A existencia de uma tabela nao prova a existencia de uma entidade.
- Agregado: conjunto de entidades tratadas como unidade de consistencia. Defina a raiz do agregado, o que se altera junto com ela e o que e acessado apenas via raiz. Legados com tabela de itens soltos geralmente escondem um agregado mal delimitado.
- Value object: objeto sem identidade, definido por seus atributos (dinheiro, documento fiscal, periodo, percentual, endereco). Liste os que aparecem como invariantes e decida se viram VOs no destino ou se viram colunas simples. VO candidato a no minimo: dinheiro, documento, periodo, percentual.
- Enum: conjunto fechado de valores para campos genericos do legado (`status`, `tipo`, `situacao`, `categoria`, `modalidade`). Cada valor ganha rotulo canonico, marcadores de transicao valida e cor/rotulo para UI.
- Evento de dominio: acontecimento relevante para o negocio (ItemPedidoAprovado, ContratoCancelado, PagamentoRejeitado). Liste o que o legado sinaliza, mesmo que de forma implicita via log, e-mail ou mudanca de status.
- Separacao de dados: distinguir dados mestres (clientes, planos, produtos), transacionais (pedidos, lancamentos), derivados (saldo, totalizadores) e de auditoria (logs, trails). Derivados nao persistem no banco novo; calculam-se na leitura ou via query classes.

## De-Para De Nomes

Regra: cada termo legado recebe exatamente um nome canonico; cada nome canonico mapeia para um ou mais termos legados. Manter o de-para em tabela propria dentro do mesmo arquivo, com colunas: `termo legado`, `termo canonico`, `contexto`, `evidencia`. Nenhum nome novo entra no banco, na aplicacao ou na UI sem passar por esse de-para. Termos ambiguos (mesmo nome legado, significados diferentes) sao o caso de uso principal do de-para.

## Criterios De Qualidade

- Toda entidade canonica tem o modelo *Entidade Canonica* preenchido, com pelo menos um trecho de evidencia por campo nao trivial.
- Nenhum nome canonico colide com outro termo ja usado em contexto diferente.
- Todo campo generico do legado (`status`, `tipo`, `situacao`, `categoria`) aparece em algum enum com valores enumerados a partir do banco (query de `GROUP BY`), nao inventados.
- O de-para de nomes cobre 100% das entidades listadas, sem buracos.
- Hipoteses sao marcadas com `HIPOTESE`; decisoes consolidadas com `DECISAO CANONICA`; conflitos entre fontes usam `REGRA CONFLITANTE`.
- Nada nesta etapa decide schema; isso pertence a etapa 7. Nomes sao apenas termos, nao tipos SQL.
- O documento passa o teste do novato: alguem que nunca viu o sistema consegue explicar o que cada entidade faz, em uma frase, lendo apenas esta secao.

## Relacao Com Outras Etapas

- Consome: comparativo da etapa 4 (`04-comparativo-legado-banco-intermediario.md`), inventario, banco e camada intermediaria das etapas 1, 2 e 3.
- Alimenta: etapa 6 (regras usam entidades canonicas), etapa 7 (modelagem do banco novo parte deste documento), etapa 8 (camada de aplicacao usa agregados e VOs), etapa 9 (UI agrupa por agregado, nao por tabela), etapa 11 (de-para de migracao usa o de-para de nomes) e etapa 12 (testes de dominio miram entidades e invariantes aqui definidos).
- Em caso de conflito de nome com outras etapas, este documento vence; as demais citam o termo canonico e referenciam este arquivo.

## Armadilhas Comuns

- Tratar tabela como entidade: tabelas de log, de sessao e de auditoria geralmente nao sao entidades; sao mecanismo de persistencia.
- Esquecer agregados: achar que toda entidade e independente e quase sempre errado; o legado guarda transacoes implicitas em updates multiplos.
- Misturar contextos no mesmo `status`: o mesmo rotulo de status pode ter significado diferente em dois fluxos; a fronteira do contexto resolve.
- Mapear `obs` ou `descricao` como campo de valor: esses campos sao quase sempre usados para guardar regra em texto livre; extrair como enum, VO ou regra.
