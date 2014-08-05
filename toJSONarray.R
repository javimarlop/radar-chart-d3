toJSONarray <- function(dtf){
clnms <- colnames(dtf)

name.value <- function(i){
quote <- '';
# if(class(dtf[, i])!='numeric'){
if(class(dtf[, i])!='numeric' && class(dtf[, i])!= 'integer'){ # I modified this line so integers are also not enclosed in quotes
quote <- '"';
}

paste('"', i, '" : ', quote, dtf[,i], quote, sep='')
}

objs <- apply(sapply(clnms, name.value), 1, function(x){paste(x, collapse=', ')})
objs <- paste('{', objs, '}')

# res <- paste('[', paste(objs, collapse=', '), ']')
res <- paste('[', paste(objs, collapse=',\n'), ']') # added newline for formatting output

return(res)
}

