library(dplyr)
library(lubridate)

dados_teste <- read.csv("codigos-trabalho/data/atraso-portos/SituacaoPortosPublicacao - Publico.csv")

head(dados_teste)

# Supondo que o dataframe seja chamado de df
# Vamos exibir as colunas 'Coluna1' e 'Coluna2' com base na coluna 'Status da Operação'

# Filtrando os dados onde 'Status da Operação' é 'Paralisada' ou 'Com Atrasos'
dados_filtrados <- dados_teste %>%
  filter(`Status.da.Operação` %in% c("❗️ PARALISADA", "⚠️ COM ATRASOS")) %>%
  select(Nome.do.Porto, Descrição.da.Situação, `Status.da.Operação`, `Data.do.Registro`, `Descrição.da.Situação`, `Início.da.Situação`)  # Selecione as colunas desejadas

# Exibindo os dados filtrados
print(dados_filtrados)

print(dados_filtrados$Nome.do.Porto)

ocorrencias_portos <- dados_filtrados %>%
  group_by(Nome.do.Porto) %>%
  count() %>%
  arrange(desc(n))  # Ordenar em ordem decrescente

# Exibindo as ocorrências dos portos
print(ocorrencias_portos)

ocorrencias_portos_sem_quantidade <- ocorrencias_portos %>%
  select(-n)

# Escolhendo os 10 portos com mais atraso
portos_estudados_nomes <- list()
portos_estudados <- list()
for(x in 1:10) {
  portos_estudados_nomes <- append(portos_estudados_nomes, as.character(ocorrencias_portos[x, 1]))
  if(x==10) {
    break
  }
}


# Salvar os registros específicos de cada porto
# Para cada porto em 'portos_estudados', armazenando os dados correspondentes
for(x in portos_estudados_nomes) {
  portos_estudados[[x]] <- merged_atracacoes_tempos %>%
    filter(atr_porto_atracacao == x)
}

# Remover as 10 primeiras linhas da lista portos_estudados
typeof(portos_estudados)
#portos_estudados <- portos_estudados[-c(1:10)]



# Converter os as datas em Posix
dados_filtrados$Início.da.Situação        <- as.POSIXct(dados_filtrados$Início.da.Situação, format = "%d/%m/%Y %H:%M:%S")

# Colocar TRUE no dia do evento
nome_porto <- ocorrencias_portos$Nome.do.Porto
primeiros_dados <- head(nome_porto, 10)
rm(nome_porto)

# Pegar data mais antiga de um dataframe
# data_mais_antiga <- min(portos_estudados[["Vitória"]]$atr_data_atracacao, na.rm = TRUE)

# Pegar valores a partir de uma data específica
for(x in primeiros_dados) {
  portos_estudados[[x]] <- portos_estudados[[x]] %>%
    filter(atr_data_atracacao >= as.POSIXct("2022-10-31"))
}



# Função para processar cada dataset
processar_dataset <- function(dataset) {
  dataset %>%
    mutate(semana = floor_date(atr_data_atracacao, "week")) %>%  # Cria a coluna da semana
    group_by(semana) %>%  # Agrupa por semana
    summarize(soma_tempo_espera = sum(tmp_atr_tempo_espera_atracacao, na.rm = TRUE))  # Soma por semana
}


nova_lista <- lapply(portos_estudados, processar_dataset)
portos_tempo_atracacoes_por_semana <- nova_lista

nova_lista
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=------------=-=-=-=-=-==-=-=-=-=-=-=-==-=-=-=-=
for(x in names(portos_estudados)) {
  portos_estudados[[x]] <- portos_estudados[[x]] %>%
    mutate(event = FALSE)  # Substitua FALSE por outro valor ou expressão conforme necessário
}
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=------------=-=-=-=-=-==-=-=-=-=-=-=-==-=-=-=-=


# Colocar TRUE de acordo com porto e data de atracação
for (porto_nome in names(portos_estudados)) {

  # Filtrar os registros de `dados_filtrados` para o porto atual
  registros_porto <- dados_filtrados %>%
    filter(Nome.do.Porto == porto_nome)

  # Converter as datas para o formato Date (sem hora)
  registros_porto$Data.do.Registro <- as.Date(registros_porto$Data.do.Registro, format = "%d/%m/%Y")
  portos_estudados[[porto_nome]]$atr_data_atracacao <- as.Date(portos_estudados[[porto_nome]]$atr_data_atracacao)

  # Atualizar a coluna `event`
  portos_estudados[[porto_nome]] <- portos_estudados[[porto_nome]] %>%
    mutate(event = atr_data_atracacao %in% registros_porto$Data.do.Registro)

  # Verificar a coluna `event`
  cat("Coluna event após atualização:\n")
  print(head(portos_estudados[[porto_nome]]$event))
}


# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=--=-=-=
# Somatório por semana dos tempos de atracações e colocar event da semana como true

# Função para processar cada dataset
processar_dados <- function(dataset) {
  # Converter a coluna de datas para o formato Date
  dataset$atr_data_atracacao <- as.Date(dataset$atr_data_atracacao)
  
  # Criar uma coluna 'semana' para o agrupamento por semana e calcular métricas
  dataset <- dataset %>%
    mutate(semana = floor_date(atr_data_atracacao, "week")) %>%
    group_by(semana) %>%
    summarise(
      event = any(event == TRUE),  # Se algum evento for TRUE na semana
      total_tempo_espera = sum(tmp_atr_tempo_espera_atracacao, na.rm = TRUE)  # Somatório da coluna de espera
    ) %>%
    ungroup()
  
  return(dataset)
}

# Aplicar a função em cada dataset da lista 'portos_estudados'
atracacao_semanal <- lapply(portos_estudados, processar_dados)