Veja SKILL.md secao 'Modelos De Registro' para o contexto de uso. Este arquivo detalha cada modelo.

# Modelos De Registro

Os 6 modelos abaixo padronizam como o Codex registra cada achado. Preencha todos os campos aplicaveis; deixe em branco o que nao se aplicar, com nota `nao se aplica` no campo.

### Item De Inventario

- arquivo
- responsabilidade aparente
- responsabilidade real
- dados manipulados
- tabelas usadas
- regras embutidas
- validacoes
- pontos de atencao
- acoplamentos
- classificacao (ver SKILL.md secao "Marcadores")
- destino na arquitetura nova

### Tabela

- nome
- finalidade aparente
- finalidade real
- principais colunas
- relacionamentos explicitos (FK declaradas)
- relacionamentos implicitos com evidencia (`arquivo:linha` ou query)
- volume (contagem e ordem de grandeza)
- qualidade dos dados
- risco de migracao
- entidade canonica relacionada
- destino (manter, refatorar, dividir, descartar)

### Classe Intermediaria

- arquivo
- classe
- responsabilidade declarada
- responsabilidade real
- dependencias
- tabelas acessadas
- regras encapsuladas
- problemas de design
- aderencia ao dominio
- destino (preservar, refatorar, descartar, realocar)

### Entidade Canonica

- nome canonico
- nomes legados (variantes encontradas)
- tabelas e arquivos relacionados
- responsabilidade
- atributos (com tipo e obrigatoriedade)
- relacionamentos
- regras
- estados
- transicoes
- validacoes
- eventos
- operacoes criticas

### Regra

- enunciado
- evidencia no legado (arquivo:linha)
- evidencia no banco (query, coluna, constraint)
- evidencia na camada intermediaria (arquivo:linha)
- criticidade
- modulo
- entidades envolvidas
- status e calculos
- risco de interpretacao
- classificacao (marcador da secao "Marcadores")
- recomendacao

### ADR

- contexto
- decisao
- alternativas rejeitadas (com motivo)
- consequencias
- impactos em banco, aplicacao, UI e testes
- confianca (marcador da secao "Marcadores")
