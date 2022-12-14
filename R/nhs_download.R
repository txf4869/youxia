#' Download data from 'NHANES' database
#'
#' @param years one or more years
#' @param items one or more items
#' @param files which files to be download
#' @param mode character. The mode with which to write the file. Useful values are "wb" (binary), "w" and "ab".
#' @param redown logical. whether to download the existed file.
#' @return download 'NHANES' database data into local computer and keep the same order.
#' @export
#'
#' @examples
#' \donttest{
#' nhs_download(years = c(2017,2019),items = c('d','l'))
#' }
nhs_download <- function(years,items,files,mode,filetable,cat=TRUE,redown=TRUE){
    if (do::cnOS()){
        items0 <- tmcn::toUTF8("items\u8D4B\u503C\u4E0D\u5BF9,\u5E94\u8BE5\u662F\u4E0B\u5217\u503C: ")
        start <- tmcn::toUTF8("=====\u5F00\u59CB\u4E0B\u8F7D=====")
    }else{
        items0 <- 'items is not right, which should be: '
        start <- '=====starting====='
    }
    years <- prepare_years(years)
    cat('\nyears: \n')
    do::cat_n(years,ind = 4)

    items <- prepare_items(items)
    cat('\n\nitems: \n')
    do::cat_n(items,n = 1,ind = 4)
    if (missing(mode)) mode <- test_mode()
    cat(paste0('\n\nmode = "',mode,'"'))
    cat('\n\n',crayon::red(start),'\n')
    # urls for items
    urls <- do::Replace0(years,'-.*') |>
        sapply(function(i) sprintf('https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=%s&CycleBeginYear=%s',
                                      items,i)) |>
        as.vector()
    urls
    testfile(urls = urls,mode=mode,files=files,redown=redown)
}

urlyear <- function(url){
    do::Replace0(url,c('.*=','.*Nhanes/','/.*'))
}
urlComponet <- function(url){
    do::Replace0(url,c('.*\\?Component=','\\&CycleBeginYear.*'))
}



