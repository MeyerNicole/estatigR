#' @title Gráfico de barras no estilo Estat Júnior
#'
#' @description
#' Cria gráficos de barras com os grupos, frequências, métodos, temas and outras características
#' de acordo com o padrão utilizado pela Estat para gráficos de barra.
#'
#' @param dados (obrigatório) dataframe ou tibble. O banco de dados com as variáveis de interesse para gerar o gráfico.
#' @param grupos (obrigatório) vetor de caracteres. Define as variáveis a serem utilizadas para agrupar e calcular as frequências.
#' Essa função não suporta vetores com mais de 2 variáveis pois plotar mais que isso em um gráficos de barras
#' signigfica perder a interpretabilidade.
#' @param fill_by character. Quando trabalhamos com 2 grupos, precisamos escolher alguma forma de inserir
#' a segunda variável no gráfico. Esse parâmetro define qual das variáveis vai aparecer colorindo as barras de acordo
#' com suas categorias.
#' @param wrap_by character. Quando trabalhamos com 2 grupos, precisamos escolher alguma forma de inserir
#' a segunda variável no gráfico. Esse parâmetro define qual das variáveis vai aparecer separando os gráficos
#' em painéis conforme suas categorias.
#' @param paleta caractere/vetor. Escolha cores para utilizar no gráfico. Tenha em mente que o número de cores
#' especificadas deve ser o mesmo do número de categorias da variável.
#' @param rotulo caractere. Escolha um método para adicionar um rótulo com a frequência das categorias.
#' O parâmetro reconhece os valores: \code{"n"}, para frequência absoluta, \code{"p"},
#' para frequência em porcentagem e \code{"np"} ou \code{"pn"} para frequência absoluta e em porcentagem.
#'
#' @import dplyr
#' @import ggplot2
#' @import cli
#'
#' @return o gráfico conforme configurado.
#'
#' @export

estat_barra <- function(dados, grupos, fill_by = NULL, wrap_by = NULL,
                     paleta = NULL, rotulo = NULL) {

  # Validação do input

  input <- list(groups = grupos, fill_by = fill_by, wrap_by = wrap_by, text_mode = rotulo)

  msg <- validar_estat_barra(input)

  if(msg != "") {cli::cli_abort(msg)}

  # Agrupando e calculando frequências

  df <- dados %>%
    group_by(!!!syms(grupos)) %>%
    summarise(n = n(), .groups = "drop")

  # Aplicando lógicas dos parâmetros

  if(length(grupos) > 1) {

    grouping_factor <- ifelse(is.null(fill_by), wrap_by, fill_by)
    x <- grupos[grupos != grouping_factor]
    fill <- ifelse(!is.null(fill_by), fill_by, x)

  } else {

    grouping_factor <- NULL
    x <- grupos
    fill <- x

  }

  # Definindo o plot base

  plot <- ggplot(data = df, aes(x = !!sym(x), y = n, fill = !!sym(fill))) +
    theme_bw() + labs(y = "Frequência")

  # Adicionando a camada de barra

  plot <- plot + geom_bar(stat = "identity", position = position_dodge())

  # Adicionando a paleta

  if(is.null(paleta)) {

    if(length(grupos) > 1) {
      plot <- plot + scale_fill_brewer(palette = "Spectral")
    } else {
      plot <- plot + scale_fill_manual(values = rep("#329bd5", times = length(unique(df[[x]])))) +
        theme(legend.position = "none")
    }

  } else {

    if(length(paleta) > 1) {

      plot <- plot + scale_fill_manual(values = paleta)

    } else {

      if(!is.null(fill_by)) {
        plot <- plot + scale_fill_manual(values = rep(paleta, times = length(unique(df[[grouping_factor]]))))
      } else {
        plot <- plot + scale_fill_manual(values = rep(paleta, times = length(unique(df[[x]])))) +
          theme(legend.position = "none")
      }
    }
  }

  # Adicionando os rótulos

  if (!is.null(rotulo)) {

    if (rotulo == "n") {
      plot <- plot + geom_text(data = df, aes(label = n), position = position_dodge(width = 0.9), vjust = -0.25)
    }

    if (rotulo == "p") {

      df <- df %>% mutate(per = round(100*(n/sum(n)),1))

      plot <- plot + geom_text(data = df, aes(label = paste0(per, "%")),
                               position = position_dodge(width = 0.9), vjust = -0.25)

    }

    if (rotulo == "np" | rotulo == "pn") {

      df <- df %>% mutate(per = round(100*(n/sum(n)),0))

      plot <- plot + geom_text(data = df, aes(label = paste0(n, paste0("(", per, "%", ")"))),
                               position = position_dodge(width = 0.9), vjust = -0.25)

    }
  }

  # Fazendo o wrap - se solicitado

  if(!is.null(wrap_by)) {

    plot <- plot + facet_wrap(eval(parse(text = paste0("~", wrap_by)))) + theme(legend.position = "none")

  }

  return(plot)

}
