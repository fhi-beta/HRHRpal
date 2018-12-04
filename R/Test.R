#' ProtectIdentifier_int
#' @param data The data.frame or data.table that will be protected
#' @param identifier A character variable containing the variable name of the identifier
#' @param seed Provide a seed for repeatable results
#' @import data.table
#' @export ProtectIdentifier_int
ProtectIdentifier_int <- function(
  data,
  identifier,
  seed=as.numeric(format(Sys.time(), "%OS6"))*100000
){
  nam <- names(data)

  fixingFN <- function(v) as.numeric(as.character(v))
  if(!is.numeric(data[[identifier]])){
    fixingFN <- as.character
  }

  if(!data.table::is.data.table(data)){
    error("data is not data.table")
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
  data[,(identifier):=fixingFN(get(identifier))]
  uniqueids[,old:=fixingFN(old)]

  setcolorder(data,nam)
  setorder(uniqueids,old)

  uniqueids[,variableName:=identifier]

  return(uniqueids)
}

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
  key <- vector("list",length=length(identifier))
  for(i in seq_along(identifier)){
    key[[i]] <- ProtectIdentifier_int(
      data=data,
      identifier=identifier[i],
      seed=seed
    )
  }

  key <- rbindlist(key)

  return(key)
}

ExtractOnlyEnglishLetters <- function(var){
  unlist(lapply(stringr::str_extract_all(stringr::str_to_lower(var),"[a-z]"),paste0,collapse=""))
}

#' LoadData
#' @param filename The .csv file that will be loaded in
#' @import data.table
#' @export LoadData
LoadData <- function(filename){
  d <- fread(filename)
  setnames(d,ExtractOnlyEnglishLetters(d))
  return(d)
}

