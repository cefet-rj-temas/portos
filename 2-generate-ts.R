library(dplyr)
library(reshape)
library(arrow)
library(readr)

df <- read_parquet("data/Atracacao.parquet")

df <- df %>%
  mutate(
    TEsperaAtracacao       = parse_number(na_if(na_if(TEsperaAtracacao, "Valor Discrepante"), "Zero")),
    TEsperaInicioOp        = parse_number(na_if(na_if(TEsperaInicioOp, "Valor Discrepante"), "Zero")),
    TOperacao              = parse_number(na_if(na_if(TOperacao, "Valor Discrepante"), "Zero")),
    TEsperaDesatracacao    = parse_number(na_if(na_if(TEsperaDesatracacao, "Valor Discrepante"), "Zero")),
    TAtracado              = parse_number(na_if(na_if(TAtracado, "Valor Discrepante"), "Zero")),
    TEstadia               = parse_number(na_if(na_if(TEstadia, "Valor Discrepante"), "Zero"))
  )

# Agregação diária
AtracacaoDiaria <- df %>%
  filter(atr_data_atracacao >= as.POSIXct("2010-01-01")) %>%
  group_by(
    porto = atr_porto_atracacao,
    data = as.Date(atr_data_atracacao)
  ) %>%
  summarize(
    qtd = n(),
    espera_atracacao = sum(TEsperaAtracacao, na.rm = TRUE),
    espera_inicio_operacao = sum(TEsperaInicioOp, na.rm = TRUE),
    espera_desatracacao = sum(TEsperaDesatracacao, na.rm = TRUE),
    tempo_operacao = sum(TOperacao, na.rm = TRUE),
    tempo_atracado = sum(TAtracado, na.rm = TRUE),
    tempo_estadia = sum(TEstadia, na.rm = TRUE),
    .groups = "drop"
  )

write_parquet(AtracacaoDiaria, "data/AtracacaoDiaria.parquet")
