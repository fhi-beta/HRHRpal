#' ProtectIdentifier
#' @param data The data.frame or data.table that will be protected
#' @param identifier A character variable containing the variable name of the identifier
#' @import data.table
#' @export ProtectIdentifier
ProtectIdentifier <- function(
  data,
  identifier,
  seed=as.numeric(format(Sys.time(), "%OS6"))*100000
){
  nam <- names(data)
  print(nam)

  if(!data.table::is.data.table(data)){
    setDT(data)
  }

  set.seed(seed)

  uniqueids <- unique(data[[identifier]])
  uniqueids <- data.table(id_old=uniqueids)
  uniqueids[,random := runif(n=.N)]
  setorder(uniqueids, random)
  uniqueids[,xxxxx93212_newid:=1:.N]
  uniqueids[,random:=NULL]

  data[,xxxxx93212_order := 1:.N]
  data <- merge(data,uniqueids,by.x=identifier, by.y="id_old")

  setorder(data,xxxxx93212_order)
  data[,(identifier):=xxxxx93212_newid]

  data[,xxxxx93212_order:=NULL]
  data[,xxxxx93212_newid:=NULL]

  setcolorder(data,nam)

  return(data)
}
