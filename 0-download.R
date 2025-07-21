library(dplyr)
library(tidyr)

#https://dados.gov.br/dados/conjuntos-dados/situacao-dos-portos-em-tempo-real

#https://web3.antaq.gov.br/ea/sense/index.html#pt

for (i in 2010:2025) {
  filename <- sprintf("%dAtracacao.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}
for (i in 2010:2025) {
  filename <- sprintf("%dCarga.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}
for (i in 2010:2025) {
  filename <- sprintf("%dCargaConteinerizada.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}
for (i in 2010:2025) {
  filename <- sprintf("%dTemposAtracacao.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}

for (i in 2010:2025) {
  filename <- sprintf("%dTaxaOcupacao.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}
for (i in 2010:2025) {
  filename <- sprintf("%dCargaRegiao_Hidrovia_Rio.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}

for (i in 2010:2025) {
  filename <- sprintf("%dCargaRegiao_Hidrovia_Rio.zip", i)
  url <- sprintf("https://web3.antaq.gov.br/ea/txt/%s", filename)
  destfile <- sprintf("raw/%s", filename)
  download.file(url, destfile, method = "auto")  
}

