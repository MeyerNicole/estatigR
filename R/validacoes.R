validar_estat_barra <- function(params) {

  msg <- ""

  if(length(params$groups) == 1 & (!is.null(params$fill_by) | !is.null(params$wrap_by))) {

    msg <- "Os parâmetros fill_by e wrap_by devem ser utilizados apenas em cenários com mais de uma variável nos grupos."

  }

  if(length(params$groups) == 2 & is.null(params$fill_by) & is.null(params$wrap_by)) {

    msg <- "Para usar 2 grupos, por favor, escolha o método e qual variável deve ser utilizada como agrupadora com os parâmetros fill_by ou wrap_by."

  }

  if(!is.null(params$fill_by) & !is.null(params$group_by)) {

    msg <- "Apenas um método de agrupamento do gráfico deve ser escolhido (fill ou wrap)."

  }

  if(length(params$groups) > 2) {

    msg <- "Usar mais de 2 agrupamentos não é suportado."

  }

  if(!is.null(params$text_mode)) {

    if(!(params$text_mode %in% c("n", "p", "pn", "np"))) {

      msg <- "Método não reconhecido. Métodos implementados: 'n', 'p', 'pn'/'np'"

    }
  }

  return(msg)

}

