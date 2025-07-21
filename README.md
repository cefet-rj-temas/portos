# Portos - ETL

Os dados de atracações e tempos de atracações entre os anos de 2010 até 2024 podem ser encontrados no seguinte link: [download dos dados](https://drive.google.com/file/d/1Z2K_6_wZogmMlFZkkB2zp9O7eCJZ4GUl/view)

Coloque os dados na pasta `codigos-trabalho/data`. Caso altere esse caminho, lembre-se de modificar o caminho indicado no arquivo `1-etl.R`, tanto para os dados de tempos quanto para os de atracações.

## Ordem de execução dos arquivos

Os arquivos devem ser executados na seguinte ordem:

1. **`1-etl.R`** – Definição dos datasets `tempos` e `atracações`.  
2. **`analise.R`** – Análise preliminar dos dados.  
3. **`portos-pesquisa.R`** – Definição dos dados a serem analisados pelos métodos do framework Harbinger.  
4. **`framework-harbinger.R`** – Execução dos métodos do framework Harbinger.  

Todos os arquivos mencionados estão localizados na pasta `codigos-trabalho`.
