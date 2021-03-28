#' use methods described at `https://apidocs.covidactnow.org/` to acquire time series at state level
#' @param key character(1) 32-character key.  Default value is
#' retrieved from environment variable `COVACT_KEY`.  See Note.
#' @param quiet logical(1) defaults to TRUE, in which case the messaging of tibble ingestion is
#' suppressed.
#' @note Acquire an API key at `https://apidocs.covidactnow.org/`.  There
#' is a nontrivial delay between the delivery of key (immediate) and
#' recognition of the key by the service.  You can place the
#' line `COVACT_KEY=...` in your .Renviron file to make this
#' value available for every normal R session.
#' @return a tibble with one line per day per state
#' @export
covact_states_data = function(key=Sys.getenv("COVACT_KEY"), quiet=TRUE) {
  bas = "https://api.covidactnow.org/v2/states.timeseries.csv?apiKey="
  url = paste0(bas, key, sep="")
  f = force
  if (quiet) f = suppressMessages
  f(httr::content(httr::GET(url)))
}
