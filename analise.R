library(ggplot2)
library(dplyr)
library(forcats)



# 1- distinct nos dados de atracacoes
atracacoes <- distinct(atracacoes)
tempos <- distinct(tempos)

# 2- juntar atracacoes com tempos
merged_atracacoes_tempos  <- merge(atracacoes, tempos, by.x = "atr_id_atracacao", by.y = "tmp_atr_id_atracacao", all = FALSE)

# 3- transformar a coluna tmp_atr_tempo_espera_atracacao em numerico
merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao  <- gsub(",", ".", merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao )
merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao <- ifelse(merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao == "Zero", 0, merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao)
merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao <- as.numeric(as.character(merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao))
merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao[is.na(merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao)] <- 0
any(is.na(merged_atracacoes_tempos$tmp_atr_tempo_espera_atracacao))  # verifica se existe valores NA

