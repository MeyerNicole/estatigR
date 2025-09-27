.onAttach <- function(libname, pkgname) {

  version <- utils::packageDescription(pkgname)$Version

  cli::cli_alert_success("{pkgname} {version} anexado com sucesso! \n Problemas ou dúvidas? Visite nosso repo: https://github.com/MeyerNicole/estatigR")

}
