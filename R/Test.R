#' ProtectIdentifier
#' @param data The data.frame or data.table that will be protected
#' @param identifier A character variable containing the variable name of the identifier
#' @param seed Provide a seed for repeatable results
#' @import data.table
#' @export ProtectIdentifier
ProtectIdentifier <- function(
  data,
  identifier,
  seed=as.numeric(format(Sys.time(), "%OS6"))*100000
){
  nam <- names(data)

  if(!is.numeric(data[[identifier]])){
    error(sprintf("%s is not numeric",identifier))
  }

  if(!data.table::is.data.table(data)){
    setDT(data)
  }

  set.seed(seed)

  data[,(identifier):=as.factor(get(identifier))]

  uniqueids <- unique(data[[identifier]])
  uniqueids <- data.table(old=uniqueids)
  uniqueids[,random := runif(n=.N)]
  setorder(uniqueids, random)
  uniqueids[,new:=1:.N]
  uniqueids[,random:=NULL]
  setorder(uniqueids,old)

  setattr(data[[identifier]],"levels",as.character(uniqueids$new))
  data[,(identifier):=as.numeric(as.character(get(identifier)))]
  uniqueids[,old:=as.numeric(as.character(old))]

  setcolorder(data,nam)
  setorder(uniqueids,old)

  return(
    list(
      "key"=uniqueids,
      "data"=data
    )
  )
}
