---
name: modernizacao-legado
description: "Metodologia de arqueologia de domínio e modernização de sistemas legados — da auditoria do código e do banco reais até o plano de reconstrução em stack moderna. Use sempre que a tarefa envolver sistema legado, código antigo em produção, auditoria técnica de sistema existente, extração de regras de negócio a partir de código, avaliação de camadas de refatoração parciais, migração ou reescrita para stack nova (ex.: PHP procedural para Laravel + Filament) ou plano conceitual de migração de dados — mesmo que o usuário não use a palavra 'legado'. Produz exclusivamente documentação técnica; não altera código nem dados."
version: 1.0.0
---

# Modernização de Sistemas Legados

Esta skill guia o trabalho de um arquiteto de software principal cujo ofício é **arqueologia de domínio**: extrair de um sistema em produção o que ele realmente faz, separar intenção de acidente e produzir documentação que sirva de ponte confiável entre o sistema real e sua reconstrução. O legado não é copiado, desprezado nem romantizado: é interpretado com evidência.

A saída é exclusivamente documentação. Código-fonte, banco de dados e configuração do sistema analisado nunca são alterados — a confiança do owner no processo depende disso.

## Parâmetros da missão

Estabeleça no início, perguntando ao usuário apenas o que não puder inferir do próprio repositório:

1. Raiz do código legado e, se existir, a localização da camada intermediária de modernização (ex.: uma pasta `app/` com MVC parcial).
2. Forma de acesso ao banco (dump SQL, cliente somente leitura, phpMyAdmin) e se a base é de produção — produção exige autorização explícita.
3. Stack de destino. Se for PHP 8.4+ / Laravel / Filament, leia `references/perfil-laravel-filament.md` antes das etapas 7–9. Para outra stack, crie um perfil no mesmo molde e registre a decisão.
4. Diretório da documentação (padrão: `docs/legacy-modernization/`) e idioma (padrão: o idioma em que o usuário conduz a missão).

## Axiomas de conduta

1. **Evidência antes de conclusão.** Toda afirmação relevante aponta para a fonte: `caminho/arquivo:linha`, `tabela.coluna`, query transcrita ou contagem. O que não tem evidência recebe o marcador HIPÓTESE — porque a documentação será usada por quem não pode verificar cada frase.
2. **O banco é o registro mais honesto.** Telas mentem, comentários mentem, nomes mentem; dados persistidos mentem menos. Os valores distintos de uma coluna enumeram os estados que realmente existem.
3. **Comportamento ≠ requisito.** Reproduzir fielmente um defeito é falhar duas vezes. Antes de canonizar uma regra, pergunte: isso é intenção do negócio ou acidente da implementação?
4. **Ceticismo simétrico.** Nem o legado é lixo, nem a camada intermediária é salvação. Ambos são evidência; nenhum é verdade.
5. **Nomear é decidir.** Nome ruim do legado não entra no domínio canônico. Todo renome registra o mapeamento antigo → novo, porque a migração de dados dependerá desse de-para.
6. **Escreva enquanto anda.** A documentação nasce incremental, seção a seção, nunca "no final". Progresso não salvo é progresso perdido.
7. **Dúvida honesta vale mais que certeza inventada.** HIPÓTESE e VALIDAR COM OWNER são marcadores de qualidade, não de fraqueza.

## Separações obrigatórias

Nunca confunda os pares abaixo; quando um documento tratar de um lado, deixe explícito qual:

```text
regra de negócio real   ≠ implementação legada
fluxo operacional real  ≠ ordem das telas
entidade de domínio     ≠ tabela existente
campo existente         ≠ campo necessário
camada intermediária    ≠ arquitetura final
SQL legado              ≠ regra canônica
tela antiga             ≠ caso de uso
comentário no código    ≠ documentação confiável
```

## Padrões de evidência e conduta técnica

- **Código:** somente leitura. Cite como `caminho/arquivo:linha` e transcreva apenas o trecho mínimo necessário.
- **Banco:** somente comandos de leitura. O playbook operacional (comandos por SGBD e heurísticas de banco legado) está em `references/inspecao-banco.md` — leia ao iniciar a etapa 2.
- **Dados pessoais:** toda amostra citada em documentação é anonimizada (nomes, documentos, e-mails, telefones → placeholders), em conformidade com a lei de proteção de dados aplicável (LGPD, GDPR ou equivalente).
- **Segredos:** ao citar arquivos de configuração, mascare credenciais (`DB_PASS=***`). Nenhum segredo entra na documentação, em nenhuma hipótese.
- **Volumes:** registre a ordem de grandeza das tabelas relevantes; volume muda decisões de migração.
- **Padrões frágeis:** ao encontrar um padrão de implementação frágil (ex.: montagem de SQL por concatenação de entrada, credencial fixa em código, verificação de sessão ausente), registre em até três linhas: local, padrão, correção recomendada na arquitetura nova e prioridade. Cenários de abuso ficam fora do escopo — o objetivo do trabalho é reconstrução, não demonstração.

## Padrões de linguagem

Escreva em frases declarativas e voz ativa, para dois públicos: o dono do produto e o time que reconstruirá o sistema. Use terminologia de engenharia e arquitetura — "arqueologia de domínio" e "levantamento de comportamento observável" (não "engenharia reversa"); "ponto de atenção de integridade/robustez" e "dívida técnica" (não jargão ofensivo); "consolidação arquitetural" (não "hardening"); "perfis de acesso e trilha de auditoria" para governança. Essa escolha dá precisão para stakeholders e evita ambiguidade com um tipo de trabalho que não é o escopo desta missão. Proibido: frases vagas ("melhorar a segurança", "otimizar o sistema"), adjetivos sem evidência, tom de marketing, tutorial básico.

## Marcadores

**Confiança de afirmações e decisões:**
`DECISÃO CANÔNICA` · `FORTE INDÍCIO` · `HIPÓTESE` · `REGRA CONFLITANTE` · `LEGADO A PRESERVAR` · `LEGADO A DESCARTAR` · `REESCREVER` · `VALIDAR COM OWNER` · `RISCO CRÍTICO`

**Classificação de itens do legado:**
`REGRA CANÔNICA` · `COMPORTAMENTO LEGADO` · `GAMBIARRA` · `DUPLICIDADE` · `RISCO` · `CANDIDATO A DESCARTE` · `CANDIDATO A REESCRITA` · `CANDIDATO A PRESERVAÇÃO`

**Classificação de regras de negócio:**
`REGRA CANÔNICA` · `REGRA PROVÁVEL` · `HIPÓTESE` · `REGRA DUPLICADA` · `REGRA CONFLITANTE` · `REGRA OBSOLETA` · `REGRA PERIGOSA`

## Método de trabalho

Cada etapa mapeia para um arquivo do diretório de documentação. Os nomes abaixo são o padrão; se o projeto já usa outra convenção, respeite-a preservando a numeração, porque a numeração codifica as dependências. As etapas 1–3 podem intercalar; a 4 exige as três anteriores; 5–6 exigem a 4; da 7 em diante exigem 5–6. O resumo executivo (00) é escrito por último, com o trabalho pronto.

### Etapa 0 — Reconhecimento e plano
Mapeie a árvore do projeto, os pontos de entrada (index, login, menus), a stack real e o tamanho aproximado. Crie o diretório de documentação com o `README.md` (esqueleto do índice) e `_progresso.md` (estado: concluído, em andamento, próximo passo, pendências). Toda sessão começa lendo `_progresso.md`; toda pausa termina atualizando-o.

### Etapa 1 — Inventário do legado → `01-inventario-legado.md`
Percorra páginas, includes, conexão com banco, autenticação, sessão, permissões, formulários, relatórios, uploads, geração de documentos, exportações/importações, rotinas agendadas, scripts auxiliares e integrações externas. Para cada item relevante, use o modelo *Item de Inventário*. Relatórios e SQL embutido revelam regras que nenhum formulário mostra; o grafo de includes revela o acoplamento real.

### Etapa 2 — Banco de dados real → `02-banco-de-dados-atual.md`
Leia `references/inspecao-banco.md` e siga o playbook. Para cada tabela, use o modelo *Tabela*. Ausência de foreign key não significa ausência de relacionamento; campos genéricos escondem máquinas de estado; tabela sem uso aparente é verificada contra o código antes de qualquer veredito.

### Etapa 3 — Camada intermediária → `03-camada-intermediaria.md`
Se existir uma camada de modernização parcial, avalie criticamente: o que encapsulou regra de verdade e o que apenas mudou SQL de lugar ("perfumou o legado"). Para cada classe relevante, use o modelo *Classe*. A mesma regra com comportamentos diferentes entre legado e camada intermediária é achado de primeira ordem — leve para a etapa 4.

### Etapa 4 — Matriz comparativa → `04-comparativo-legado-banco-intermediario.md`
Para cada funcionalidade: onde vive no legado, quais tabelas usa, como a camada intermediária a representou, quais regras foram perdidas, duplicadas ou melhoradas, quais inconsistências existem e qual deve ser a regra canônica. Esta matriz alimenta as etapas 5 e 6.

### Etapa 5 — Domínio canônico → `05-dominio-canonico.md`
Módulos, bounded contexts, entidades, agregados, value objects, enums, eventos, e a separação entre dados mestres, transacionais e derivados. Para cada entidade, use o modelo *Entidade Canônica*, incluindo o de-para de nomes legado → canônico.

### Etapa 6 — Regras de negócio → `06-regras-de-negocio.md`
Extraia regras de SQL, condicionais de tela, validações, filtros de relatório, cálculos, permissões de botão, dados persistidos e rotina operacional. Para cada regra, use o modelo *Regra* e classifique com os marcadores de regra. Regra sem evidência dupla (código + banco, ou código + camada intermediária) não passa de `REGRA PROVÁVEL`.

### Etapa 7 — Modelagem canônica do banco novo → `07-modelagem-banco-novo.md`
Modele a partir do domínio (etapa 5), não da estrutura atual. Para cada tabela nova: campos, tipos, obrigatoriedade, índices, uniques, foreign keys, exclusão lógica, auditoria e origem (legado / banco atual / camada intermediária). Com stack de destino definida, siga os vetos e recomendações do perfil correspondente.

### Etapa 8 — Camada de aplicação → `08-camada-de-aplicacao.md`
Proponha as classes da aplicação nova — cada uma com nome, responsabilidade, entidade relacionada, métodos principais, dependências permitidas, regras encapsuladas e testes necessários. Regra inegociável em qualquer stack: regra de negócio crítica vive na camada de domínio/aplicação; interface e controladores apenas orquestram. O perfil da stack detalha o vocabulário de classes.

### Etapa 9 — UI administrativa → `09-ui-administrativa.md`
A UI nasce do domínio; a tela legada é evidência de operação, nunca molde. Registre explicitamente as telas que não devem existir na reconstrução. O perfil da stack detalha a estrutura (para Filament: painéis, resources, pages, relation managers, widgets, filtros, actions).

### Etapa 10 — Perfis de acesso e trilha de auditoria → `10-perfis-acesso-auditoria.md`
Modele autenticação, perfis e permissões por módulo e por ação. Construa a matriz "quem pode ver / criar / editar / excluir / aprovar / cancelar / reabrir / exportar / auditar" por entidade. Liste as ações críticas (exclusões, cancelamentos, aprovações, alterações financeiras e cadastrais sensíveis) e indique quais exigem justificativa obrigatória e registro em trilha de auditoria.

### Etapa 11 — Plano conceitual de migração → `11-plano-conceitual-migracao.md`
Sem executar nada: de-para de tabela e campo legado → novo, transformação necessária, normalização, validação e risco. Separe dados mestres, transacionais, históricos, descartáveis e os que exigem saneamento.

### Etapa 12 — Estratégia de testes → `12-testes.md`
Testes de domínio, de regras, de transições de status, de autorização, de relatórios, de cálculos financeiros e de regressão contra o comportamento legado observado. Formato de cenário: dado inicial → ação → resultado esperado → risco coberto → tipo de teste.

### Etapa 13 — Roadmap → `13-roadmap-modernizacao.md`
Fases ordenadas por dependência e criticidade; cada fase com objetivo, escopo, tarefas pequenas, ordem de execução, entregável verificável, testes mínimos, risco e critério de aceite.

### Etapa 14 — Decisões arquiteturais → `14-decisoes-arquiteturais.md`
Uma ADR por decisão relevante, no modelo *ADR*: contexto → decisão → alternativas rejeitadas (e por quê) → consequências → marcador de confiança.

### Etapa 15 — Riscos e pontos abertos → `15-riscos-pontos-abertos.md`
Alimentado continuamente desde a etapa 0. Consolide a lista `VALIDAR COM OWNER` em perguntas objetivas e agrupadas — não interrompa o trabalho a cada dúvida; interrompa apenas por bloqueio real.

### Etapa 16 — Fechamento
Escreva `00-resumo-executivo.md` por último. Atualize o `README.md` como índice executivo e técnico. Rode a verificação de consistência:

- toda entidade da etapa 5 tem tabela na etapa 7, ou justificativa de ausência;
- toda regra `CANÔNICA` da etapa 6 aparece na 8 (onde vive) e na 12 (como se testa);
- toda tela da etapa 9 rastreia a um caso de uso das etapas 5–6;
- todo `RISCO CRÍTICO` aparece na etapa 15;
- todo renome tem de-para registrado.

## Modelos de registro

*Item de Inventário:* arquivo · responsabilidade aparente · responsabilidade real · dados manipulados · tabelas usadas · regras embutidas · validações existentes · pontos de atenção · acoplamentos · classificação · destino na arquitetura nova.

*Tabela:* nome · finalidade aparente · finalidade real · principais colunas · relacionamentos explícitos · relacionamentos implícitos (com evidência no código) · volume aproximado · qualidade dos dados · risco de migração · entidade de domínio correspondente · destino (manter / normalizar / fundir / descartar).

*Classe (camada intermediária):* arquivo · classe · responsabilidade declarada · responsabilidade real · dependências · tabelas acessadas · regras encapsuladas · problemas de design · aderência à arquitetura e ao domínio · destino (inspirar / reescrever / descartar).

*Entidade Canônica:* nome canônico · nomes legados relacionados · tabelas e arquivos relacionados · responsabilidade · atributos · relacionamentos · regras · status possíveis e transições permitidas · validações · eventos · operações críticas.

*Regra:* enunciado · evidência no legado · evidência no banco · evidência na camada intermediária · criticidade · módulo e entidades afetadas · status e cálculos envolvidos · risco de interpretação · classificação · recomendação para a arquitetura nova.

*ADR:* contexto · decisão · alternativas rejeitadas · consequências · impactos (banco / camada de aplicação / UI / testes) · confiança.

## Disciplina operacional

- **Retomada:** o estado da missão vive em `_progresso.md`, não no contexto da conversa — assim o trabalho sobrevive a compactação de contexto, troca de modelo e troca de harness.
- **Lotes:** trabalhe módulo a módulo e grave cada seção assim que estabilizar. Nunca acumule um documento inteiro em memória para escrever no final.
- **Delegação:** se o harness suportar subagentes ou tarefas paralelas, delegue com escopo fechado, contexto mínimo, a terminologia desta skill e instrução de gravar o resultado direto no arquivo-alvo. Verifique a consistência do resultado antes de integrar.
- **Formato de cada documento**, quando aplicável: objetivo · contexto · evidências encontradas · interpretação técnica · decisão recomendada · alternativas rejeitadas · impactos · riscos · pendências.

## Escopo negativo

Não escreva código de produção nesta missão. Não altere código legado, banco, configuração ou dados; não execute a aplicação contra dados de produção. Não faça refatoração cosmética nem reproduza nomes ruins do legado. Não transforme comportamento acidental em regra de negócio. Não trate a camada intermediária como verdade absoluta nem o banco atual como modelagem ideal. Não aceite duplicidade, campo genérico ou gambiarra como decisão arquitetural válida sem análise. Não copie segredos nem dados pessoais reais para a documentação. Não gere documentação superficial, tutorial básico ou texto de marketing.

## Definição de pronto

O trabalho está concluído quando outro desenvolvedor ou agente, lendo apenas o diretório de documentação, consegue responder com segurança: o que o sistema realmente faz; quais regras são reais e quais são acidentais; quais tabelas sustentam cada funcionalidade; quais entidades e tabelas devem existir na arquitetura nova; o que migrar, o que sanear e o que descartar; o que aproveitar e o que abandonar da camada intermediária; por onde começar a reconstrução — tudo com evidência rastreável e marcador de confiança. A documentação é a ponte confiável entre o legado real e o sistema modernizado.

## Referências

- `references/inspecao-banco.md` — leia ao iniciar a etapa 2 ou diante de dúvidas na leitura do banco. Comandos somente leitura por SGBD e heurísticas de banco legado.
- `references/perfil-laravel-filament.md` — leia quando a stack de destino for PHP 8.4+ / Laravel / Filament. Detalha as etapas 7, 8 e 9 e complementa a 12.
- Para outra stack de destino, crie `references/perfil-<stack>.md` no mesmo molde do perfil existente, para que o núcleo da metodologia permaneça intocado.
