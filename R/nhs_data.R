#' available data in NHANES database
#'
#' @param years one or more years
#' @param cat logical, wheter to show the process
#' @name nhs_data
#' @return available data
#' @export
#'
#' @examples
#' nhs_data_web(years=1999)
#' nhs_data_web(years=c(1999,2001))
#' nhs_data_web(nhs_year(range = F))
nhs_data_web <- function(years,cat=TRUE){
    if (do::cnOS()){
        retrieve <-tmcn::toUTF8("\u63D0\u53D6\u6570\u636E(\u5E74):")
    }else{
        retrieve <-'retrieve data (year):'
    }
    years <- prepare_years_pc(years)
    urls <- paste0('https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=',do::Replace0(years,'-.*'))
    for (i in 1:length(urls)) {
        if (cat) cat('\n',retrieve,years[i])
        if (i==1) res <- list()
        wait=TRUE
        while (wait) {
            year_html <- tryCatch(xml2::read_html(urls[i]),
                                  error=function(e) 'e')
            wait <- ifelse(is.character(year_html),TRUE,FALSE)
        }
        data_href = year_html |>
            rvest::html_elements(xpath = '//a[@class="list-title td-none td-ul-hover"]') |>
            set::grep_and('Component=') |>
            do::attr_href() |>
            do::Replace0('.*datapage\\.aspx\\?Component=') |>
            do::Replace0('&CycleBeginYear.*')
        data_href = set::grep_not_and(data_href,'LimitedAccess')
        if (length(data_href)==0) data_href <- rep(NA,5)
        res <- c(res,list(data_href))
        names(res)[i] <- years[i]
    }
    if (cat) cat('\n\n')
    do.call(rbind,res) |> data.frame()
}




# @rdname nhs_data
# @export
# nhs_data_pg <- function(years,cat=TRUE){
#
# }