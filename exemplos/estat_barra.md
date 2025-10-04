# Do iniciante ao avançado: criando gráficos de barra com `estat_barra`

## 🤔 Explicação dos parâmetros

Os parâmetros disponíveis para uso no estat_barra são:

* `dados` (obrigatório): passe aqui o seu dataframe contendo os dados de interesse para o gráfico.

* `grupos` (obrigatório): as visões produzidas pelo estat_barra são baseadas nas frequências das categorias das 
variáveis. Para calcular essas frequências, é necessário agrupar por uma ou mais variáveis de interesse. 
(Exemplo: podemos querer analisar só a frequências das diferentes faixas etárias dos indivíduos (1 grupo), 
ou também ter interesse em como é a divisão das faixas etárias por estado (2 grupos)). O máximo permitido é de
2 grupos.

* `fill_by`: quando usamos dois grupos de variáveis, precisamos escolher um método para representar o segundo grupo
no gráfico. Use este parâmetro quando você quiser adicionar a segunda variável como a cor da barra.

* `wrap_by`: quando usamos dois grupos de variáveis, precisamos escolher um método para representar o segundo grupo
no gráfico. Use este parâmetro quando você quiser que seja feito um gráfico separado para cada categoria da segunda
variável.

* `paleta`: use este parâmetro para escolher a cor das barras. Aqui você pode escolher uma cor para pintar todas
as barras, ou mais cores para pintar todas as barras. No caso do método fill_by, você também escolhe a paleta
dessa variável por aqui. Lembre-se que ao usar mais de uma cor, o número de cores especificadas tem que ser
igual ao número de categorias da variável que você está colorindo. As cores padrão são o azul1 da Estat 
(1 grupo) ou a paleta "Spectral" (2 grupos) do RColorBrewer.

* `rotulo`: use este parâmetro para escolher como você quer incluir a frequência em número acima da barra. Deixe
em branco para não utilizar, especifique "n" para frequência absoluta (inteiro), "p" para frequência relativa
(porcentagem) e "np" (ou "pn") para frequência absoluta e relativa (modelo XX(YY%)).

## 📊 Criando um gráfico simples (agrupamento com 1 variável)

Vamos fazer alguns exemplos com o conjunto de dados embutido no pacote. Para utilizá-los, basta rodar `data(salarios)`.
Este conjunto contém dados (fictícios) sobre profissionais da área de dados, com as variáveis `Nome`, `Idade`,
`Cidade`, `Estado`, `Cargo`, `Senioridade` e `Salario`.

Em um projeto de análise descritiva, podemos querer colocar em um gráfico a frequência dos diferentes perfis
dos profissionais. Vamos pegar o cargo dos profissionais como exemplo.

Podemos construir um gráfico simples para mostrar a frequência dos diferentes cargos da seguinte forma:

``` R
library(estatigR)

# Carrega o conjunto de dados
data(salarios)

# Ver um pedaço dos dados
head(salarios)

# Criar um gráfico de frequência dos cargos
estat_barra(salarios, grupos = "Cargo")
```

<img width="665" height="506" alt="estat_barra_1_simples" src="https://github.com/user-attachments/assets/4e439ddd-5ab2-47e5-9e98-8252e2200e8d" />

Fornecendo somente os dados e a variável de interesse, já temos um gráfico apresentável, porém podemos
usar ainda mais opções para personalizar o nosso gráfico, como trocar as cores:

``` R
# Mudar a paleta do gráfico - 1 cor
estat_barra(salarios, grupos = "Cargo", paleta = "seagreen")

# Mudar a paleta do gráfico - Paleta de cores
estat_barra(salarios, grupos = "Cargo", paleta = c("coral1", "palegreen3", "skyblue1"))
```
<img width="665" height="506" alt="estat_barra_1_simples_verde" src="https://github.com/user-attachments/assets/86c809f7-ba1c-45db-862e-06733843c8ed" />

<img width="665" height="506" alt="estat_barra_1_colorido" src="https://github.com/user-attachments/assets/c0b669fc-851b-4b98-a3ce-68ef538409f9" />

Lembrando que o número de cores fornecidas na paleta deve ser 1 ou o número de categorias da variável.

Beleza! Agora temos um gráfico com a cara do nosso projeto! Vamos completá-lo com um rótulo descrevendo
o número exato ou relativo das frequências?

``` R
# Adicionar rótulo - Frequência absoluta
estat_barra(salarios, grupos = "Cargo", paleta = c("coral1", "palegreen3", "skyblue1"), rotulo = "n")

# Adicionar rótulo - Frequência relativa
estat_barra(salarios, grupos = "Cargo", paleta = c("coral1", "palegreen3", "skyblue1"), rotulo = "p")

# Adicionar rótulo - Frequência absoluta
estat_barra(salarios, grupos = "Cargo", paleta = c("coral1", "palegreen3", "skyblue1"), rotulo = "np")
```

<img width="665" height="506" alt="estat_barra_1_rotulo_n" src="https://github.com/user-attachments/assets/d3057e11-881b-4539-8c42-f6a2929b0375" />

<img width="665" height="506" alt="estat_barra_1_rotulo_p" src="https://github.com/user-attachments/assets/47264b8a-6c7c-46eb-888d-88497f2835cb" />

<img width="665" height="506" alt="estat_barra_1_rotulo_np" src="https://github.com/user-attachments/assets/b484f04a-6d36-40c9-a9ef-b500ac395413" />

Passamos por todas as opções do `estat_barra`, mas ainda precisa adicionar ou mudar alguma coisa? 
Sem problemas! Como o pacote foi construído em cima do `ggplot2`, o gráfico resultante é um objeto do ggplot,
permitindo que você adicione camadas em cima dele, com a sintaxe normal do ggplot.

No nosso gráfico, podemos ver que o posicionamento dos nomes das categorias está um pouco estranho, estando
presente no eixo x e na legenda, pois utilizamos uma cor por categoria. Podemos remover isso utilizando a
sintaxe do ggplot:

``` R
library(ggplot2)

# Arrumar legenda
estat_barra(salarios, grupos = "Cargo", paleta = c("coral1", "palegreen3", "skyblue1"), rotulo = "np") +
  theme(legend.position = "none")
```

<img width="665" height="506" alt="estat_barra_1_final" src="https://github.com/user-attachments/assets/858461e9-adb9-477e-8863-70bff1333bf1" />


## 📊 Criando um gráfico composto (agrupamento com 2 variáveis)

Agora, vamos dar um passo além e construir um gráfico representando 2 variáveis. Vamos analisar como os cargos
são distribuídos entre os diferentes estados. Nessa situação, podemos construir gráficos básicos de 2 tipos:

``` R
# Criar um gráfico de frequência dos cargos por estado - cor
estat_barra(salarios, grupos = c("Cargo", "Estado"), fill_by = "Cargo")

# Criar um gráfico de frequência dos cargos por estado - separação
estat_barra(salarios, grupos = c("Cargo", "Estado"), wrap_by = "Estado")
```

<img width="665" height="506" alt="estat_barra_2_simples" src="https://github.com/user-attachments/assets/6e164e5a-fc83-4418-8121-6d0c9c2bbc5f" />

<img width="665" height="506" alt="estat_barra_2_sep_simples" src="https://github.com/user-attachments/assets/7b0a2d33-e76c-4925-a88e-a33ae0932c12" />

Nos dois casos, podemos adicionar tudo o que vimos anteriormente sobre paletas e rótulos:

``` R
# Mudar a cor das categorias e adicionar rótulo
estat_barra(salarios, grupos = c("Cargo", "Estado"), fill_by = "Cargo", 
            paleta = c("coral1", "palegreen3", "skyblue1"),
            rotulo = "n")

# Mudar a cor das categorias e adicionar rótulo
estat_barra(salarios, grupos = c("Cargo", "Estado"), wrap_by = "Estado", 
            paleta = c("coral1", "palegreen3", "skyblue1"),
            rotulo = "p")
```

<img width="665" height="506" alt="estat_barra_2_completo" src="https://github.com/user-attachments/assets/59f94ba8-3e4b-405e-9041-0796e93e66c8" />

<img width="665" height="506" alt="estat_barra_2_sep_completo" src="https://github.com/user-attachments/assets/cc31631f-739d-4817-b258-4a211d46c951" />


E podemos adicionar os últimos detalhes no gráfico utilizando o ggplot:

``` R
# Últimos ajustes
estat_barra(salarios, grupos = c("Cargo", "Estado"), fill_by = "Cargo", 
            paleta = c("coral1", "palegreen3", "skyblue1"),
            rotulo = "n") +
  labs(title = "Distribuição dos cargos pelos estados")

# Últimos ajustes
estat_barra(salarios, grupos = c("Cargo", "Estado"), wrap_by = "Estado", 
            paleta = c("coral1", "palegreen3", "skyblue1"),
            rotulo = "p") +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(), 
        legend.position = "right") +
  ylim(0, 5.5)
```

<img width="665" height="506" alt="estat_barra_2_final" src="https://github.com/user-attachments/assets/0867fff7-4d10-4dbb-a45a-01591b8d75b8" />

<img width="665" height="506" alt="estat_barra_2_sep_final" src="https://github.com/user-attachments/assets/d674f8dd-2e71-417c-861e-41bc60a897f5" />
