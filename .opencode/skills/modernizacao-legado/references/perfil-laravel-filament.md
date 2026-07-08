# Perfil De Destino: PHP 8.4+ / Laravel / Filament

Leia este perfil quando a reconstrucao recomendada usar PHP moderno com Laravel e Filament. Ele detalha as etapas 7, 8 e 9 e complementa a estrategia de testes. A documentacao deve continuar abstrata o bastante para permitir troca futura de framework; este perfil orienta a proposta, nao aprisiona o dominio.

## Base Assumida

- PHP 8.4+
- Laravel
- Filament
- Eloquent
- Pest
- PostgreSQL ou MySQL bem modelado
- Clean Architecture pragmatica
- DDD tatico quando fizer sentido
- PSR-12

## Etapa 7: Banco Novo

Vetar explicitamente:

- dinheiro em `float`; usar inteiro em centavos ou `DECIMAL` com escala definida;
- datas em `varchar`; usar `DATE`, `DATETIME` ou `TIMESTAMP`;
- status generico sem enum;
- relacionamento apenas por nome;
- tabela multiuso;
- coluna de observacao carregando regra;
- JSON usado como lixeira de modelagem.

Recomendacoes:

- foreign keys com `ON DELETE` deliberado; `restrict` por padrao, `cascade` so com justificativa;
- uniques que codifiquem invariantes do dominio;
- indices derivados das consultas reais dos relatorios legados;
- `softDeletes()` quando a exclusao operacional for cancelamento;
- `created_at` e `updated_at` sempre;
- `created_by` e `updated_by` em entidades com trilha de auditoria;
- `legacy_id` indexado e nullable nas tabelas migradas, para conferencia e reversibilidade inicial.

## Etapa 8: Aplicacao

Vocabulario recomendado:

- Models finos: relacionamentos, casts e escopos simples.
- Enums backed: estados e tipos, transicoes, rotulos e cores para UI.
- Value Objects: dinheiro, documento fiscal, periodo, percentual, identificadores externos.
- Casts: ponte entre colunas, Enums e Value Objects.
- Policies: autorizacao por entidade e acao.
- Actions: um caso de uso de escrita por classe, com transacao e validacao de invariantes.
- Services ou Domain Services: orquestracao entre agregados ou sistemas externos.
- Query classes: relatorios e consultas complexas nomeadas e testaveis.
- DTOs/Data Objects: fronteira explicita de entrada e saida.
- Events, Listeners e Jobs: efeitos colaterais e processamento assincrono.
- Observers: somente para preocupacoes transversais, como auditoria.
- Form Requests: validacao de entrada da interface; invariantes ficam nas Actions e Value Objects.

Regra inegociavel: regra critica vive em Actions, Services, Policies, Value Objects ou entidades. Controllers, views e resources apenas orquestram.

Para cada classe proposta, registrar: nome; responsabilidade; entidade/tabela relacionada; metodos principais; dependencias permitidas; regras encapsuladas; testes necessarios.

## Etapa 9: UI Administrativa Filament

- Paineis separados quando os perfis de acesso indicarem mundos distintos.
- Resources por agregado de dominio, nao por tabela.
- Relation managers para composicoes, como itens de pedido ou lancamentos de contrato.
- Pages custom para operacoes que nao sao CRUD: fechamento, conciliacao, importacao, aprovacao em lote.
- Filtros e tabelas derivados dos relatorios e consultas reais do legado.
- Actions e bulk actions com confirmacao; acoes criticas podem exigir justificativa persistida.
- Badges e estados derivados dos Enums.
- Visibilidade e habilitacao derivadas de Policies; esconder botao nao e autorizacao.
- Widgets e dashboards baseados em Query classes testadas.
- Lista explicita de telas legadas que nao devem renascer.

## Complementos De Teste

Com Pest, planejar:

- unidade para Value Objects e Enums, incluindo transicoes validas e invalidas;
- feature para cada Action: caminho feliz, invariantes violadas e autorizacao;
- testes de Query classes com fixtures derivadas de amostras anonimizadas;
- testes de Filament para acoes criticas, confirmacao, justificativa e efeitos;
- regressao de comportamento observado: mesma entrada, resultado esperado documentado, preservando regras canonicas e descartando acidentes.

## Nomenclatura

- tabelas em `snake_case` plural;
- Models em singular;
- chaves estrangeiras `entidade_id`;
- Enums com sufixo claro, por exemplo `StatusPedido`;
- Actions no imperativo, por exemplo `AprovarPedido`;
- todo nome novo entra no de-para legado -> canonico.