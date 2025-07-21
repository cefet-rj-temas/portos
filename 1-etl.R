library(dplyr)
library(tidyr)
library(readr)
library(arrow)

TempoAtracacao <- NULL
for (i in 2010:2025) {
  tempo <- read_delim(sprintf('raw/%dTemposAtracacao.zip', i, i), delim = ";", escape_double = FALSE, trim_ws = TRUE)
  TempoAtracacao <- rbind(TempoAtracacao, tempo)
}
rm(tempo)

TempoAtracacao <- TempoAtracacao %>%
  select(
    IDAtracacao         = tmp_atr_id_atracacao,
    TEsperaAtracacao    = tmp_atr_tempo_espera_atracacao,
    TEsperaInicioOp     = tmp_atr_tempo_espera_inicio_operacao,
    TOperacao           = tmp_atr_tempo_operacao,
    TEsperaDesatracacao = tmp_atr_tempo_espera_desatracacao,
    TAtracado           = tmp_atr_tempo_atracado,
    TEstadia            = tmp_atr_tempo_estadia
  )

TempoAtracacao <- as_tibble(TempoAtracacao)
write_parquet(TempoAtracacao, "data/TempoAtracacao.parquet")

Atracacao <- NULL
for (i in 2010:2025) {
  atracacao <- read_delim(sprintf('raw/%dAtracacao.zip', i, i), delim = ";", escape_double = FALSE, trim_ws = TRUE)
  Atracacao <- rbind(Atracacao, atracacao)
}
rm(atracacao)

Atracacao <- Atracacao %>%
  select(
    atr_id_atracacao                 = `IDAtracacao`,
    atr_cdtup                        = `CDTUP`,
    atr_id_berco                     = `IDBerco`,
    atr_berco                        = `Berço`,
    atr_porto_atracacao              = `Porto Atracação`,
    atr_apelido_instalacao_portuaria = `Apelido Instalação Portuária`,
    atr_complexo_portuario           = `Complexo Portuário`,
    atr_tipo_autoridade_portuaria    = `Tipo da Autoridade Portuária`,
    atr_data_atracacao               = `Data Atracação`,
    atr_data_chegada                 = `Data Chegada`,
    atr_data_desatracacao            = `Data Desatracação`,
    atr_data_inicio_operacao         = `Data Início Operação`,
    atr_data_termino_operacao        = `Data Término Operação`,
    atr_ano                          = `Ano`,
    atr_mes                          = `Mes`,
    atr_tipo_operacao                = `Tipo de Operação`,
    atr_tipo_navegacao_atracacao     = `Tipo de Navegação da Atracação`,
    atr_nacionalidade_armador        = `Nacionalidade do Armador`,
    atr_flag_operacao_atracacao      = `FlagMCOperacaoAtracacao`,
    atr_terminal                     = `Terminal`,
    atr_municipio                    = `Município`,
    atr_uf                           = `UF`,
    atr_sguf                         = `SGUF`,
    atr_regiao_geografica            = `Região Geográfica`,
    atr_nr_capitania                 = `Nº da Capitania`,
    atr_nr_imo                       = `Nº do IMO`
  )

Atracacao$atr_data_atracacao        <- as.POSIXct(Atracacao$atr_data_atracacao, format = "%d/%m/%Y %H:%M:%S")
Atracacao$atr_data_chegada          <- as.POSIXct(Atracacao$atr_data_chegada, format = "%d/%m/%Y %H:%M:%S")
Atracacao$atr_data_desatracacao     <- as.POSIXct(Atracacao$atr_data_desatracacao, format = "%d/%m/%Y %H:%M:%S")
Atracacao$atr_data_inicio_operacao  <- as.POSIXct(Atracacao$atr_data_inicio_operacao, format = "%d/%m/%Y %H:%M:%S")
Atracacao$atr_data_termino_operacao <- as.POSIXct(Atracacao$atr_data_termino_operacao, format = "%d/%m/%Y %H:%M:%S")

Atracacao <- as_tibble(Atracacao)
write_parquet(Atracacao, "data/Atracacao.parquet")

Atracacao <- merge(x = Atracacao, y = TempoAtracacao, 
                   by.x = 'atr_id_atracacao', by.y = 'IDAtracacao')
write_parquet(Atracacao, "data/Atracacao.parquet")

for (i in 2010:2025) {
  carga <- read_delim(sprintf('raw/%dCarga.zip', i, i), delim = ";", escape_double = FALSE, trim_ws = TRUE)
  
  carga <- carga %>%
    select(
      crg_id_carga                             = `IDCarga`,
      crg_id_atracacao                         = `IDAtracacao`,
      crg_origem                               = `Origem`,
      crg_destino                              = `Destino`,
      crg_cd_mercadoria                        = `CDMercadoria`,
      crg_tipo_operacao_carga                  = `Tipo Operação da Carga`,
      crg_carga_geral_acondicionamento         = `Carga Geral Acondicionamento`,
      crg_conteiner_estado                     = `ConteinerEstado`,
      crg_tipo_navegacao                       = `Tipo Navegação`,
      crg_flag_autorizacao                     = `FlagAutorizacao`,
      crg_flag_cabotagem                       = `FlagCabotagem`,
      crg_flag_cabotagem_movimentacao          = `FlagCabotagemMovimentacao`,
      crg_flag_conteiner_tamanho               = `FlagConteinerTamanho`,
      crg_flag_longo_curso                     = `FlagLongoCurso`,
      crg_flag_mc_operacao_carga               = `FlagMCOperacaoCarga`,
      crg_flag_off_shore                       = `FlagOffshore`,
      crg_flag_transporte_via_interior         = `FlagTransporteViaInterioir`,
      crg_percurso_transporte_vias_interiores  = `Percurso Transporte em vias Interiores`,
      crg_percurso_transporte_interiores       = `Percurso Transporte Interiores`,
      crg_st_natureza_carga                    = `STNaturezaCarga`,
      crg_stsh2                                = `STSH2`,
      crg_stsh4                                = `STSH4`,
      crg_natureza_carga                       = `Natureza da Carga`,
      crg_sentido                              = `Sentido`,
      crg_teu                                  = `TEU`,
      crg_quantidade_carga                     = `QTCarga`,
      crg_vl_peso_carga_bruta                  = `VLPesoCargaBruta`
    )
  
  carga <- as_tibble(carga)
  write_parquet(carga, sprintf("data/Carga%d.parquet", i))
}


