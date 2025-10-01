# Do iniciante ao avançado: criando gráficos de barra com estat_barra

## 🤔 Explicação dos parâmetros

Os parâmetros disponíveis para uso no estat_barra são:

* dados (obrigatório): passe aqui o seu dataframe contendo os dados de interesse para o gráfico.

* grupos (obrigatório): as visões produzidas pelo estat_barra são baseadas nas frequências das categorias das 
variáveis. Para calcular essas frequências, é necessário agrupar por uma ou mais variáveis de interesse. 
(Exemplo: podemos querer analisar só a frequências das diferentes faixas etárias dos indivíduos (1 grupo), 
ou também ter interesse em como é a divisão das faixas etárias por estado (2 grupos)). O máximo permitido é de
2 grupos.

* fill_by: quando usamos dois grupos de variáveis, precisamos escolher um método para representar o segundo grupo
no gráfico. Use este parâmetro quando você quiser adicionar a segunda variável como a cor da barra.

* wrap_by: quando usamos dois grupos de variáveis, precisamos escolher um método para representar o segundo grupo
no gráfico. Use este parâmetro quando você quiser que seja feito um gráfico separado para cada categoria da segunda
variável.

* paleta: use este parâmetro para escolher a cor das barras. Aqui você pode escolher uma cor para pintar todas
as barras, ou mais cores para pintar todas as barras. No caso do método fill_by, você também escolhe a paleta
dessa variável por aqui. Lembre-se que ao usar mais de uma cor, o número de cores especificadas tem que ser
igual ao número de categorias da variável que você está colorindo. As cores padrão são o azul1 da Estat 
(1 grupo) ou a paleta "Spectral" (2 grupos) do RColorBrewer.

* rotulo: use este parâmetro para escolher como você quer incluir a frequência em número acima da barra. Deixe
em branco para não utilizar, especifique "n" para frequência absoluta (inteiro), "p" para frequência relativa
(porcentagem) e "np" (ou "pn") para frequência absoluta e relativa (modelo XX(YY%)).

## 📊 Criando um gráfico simples (agrupamento com 1 variável)

## 📊 Criando um gráfico composto (agrupamento com 2 variáveis)
