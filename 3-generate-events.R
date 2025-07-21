library(dplyr)
library(reshape)
library(arrow)
library(readxl)
library(readr)
library(stringr)

df <- read_parquet("data/AtracacaoDiaria.parquet")

SituacaoPortosPublicacao <- read_excel("raw/SituacaoPortosPublicacao.xlsx")
colnames(SituacaoPortosPublicacao) <- c(
  "id",
  "data_registro",
  "nome_porto",
  "status_operacao",
  "status_via_acesso",
  "criticidade",
  "descricao_situacao",
  "inicio_situacao",
  "duracao_situacao",
  "termino_situacao",
  "fonte_informacao",
  "situacao_atual"
)

SituacaoPortosPublicacao <- SituacaoPortosPublicacao %>%
  mutate(
    data_registro = as.Date(data_registro, format = "%d/%m/%Y %H:%M")
  )

SituacaoPortosPublicacao <- SituacaoPortosPublicacao %>%
  filter(!str_detect(status_operacao, regex("REGULAR", ignore_case = TRUE)))

# Criar coluna compatível com 'porto' no df
SituacaoPortosPublicacao <- SituacaoPortosPublicacao %>%
  mutate(
    data = data_registro  # cria coluna 'data' para o join
  )
SituacaoPortosPublicacao$event <- TRUE
SituacaoPortosPublicacao <- SituacaoPortosPublicacao %>% select(nome_porto, data, event, status_operacao, status_via_acesso, criticidade, descricao_situacao, duracao_situacao)


# 1. Lista única de portos com ocorrência de problemas
portos_com_problemas <- unique(SituacaoPortosPublicacao$nome_porto)

# 2. Filtra toda a base de atracações apenas para esses portos
df_filter <- df %>%
  filter(porto %in% portos_com_problemas)

# Realiza o join
df_joined <- df_filter %>%
  left_join(SituacaoPortosPublicacao, by = c("porto" = "nome_porto", "data" = "data"))
df_joined$event[is.na(df_joined$event)] <- FALSE

portos <- df_joined %>%
  arrange(porto, data) %>%
  group_split(porto) %>%
  setNames(sort(unique(df_joined$porto)))
portos_na_lista <- names(portos)

ranking_geral <- df %>%
  group_by(porto) %>%
  summarize(total_atracacoes = sum(qtd, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_atracacoes)) %>%
  mutate(posicao = row_number())


ranking_filtrado <- ranking_geral %>%
  filter(porto %in% portos_na_lista) %>%
  arrange(posicao)

print(ranking_filtrado)

portos <- portos[ranking_filtrado$porto]

save(portos, file="data/portos.RData")




