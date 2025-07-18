##############################################
#              CONFIGURAÇÕES                 #
##############################################

# Load libraries
library(readr)
library(dplyr)
library(readxl)

# Set options
options(stringsAsFactors = FALSE)

# Set file paths
base_compras_MG  <- "data/4_baseFinalItens2025mar 1.xlsx"
output_path <- "data/base_compras_materialservico.csv"

######################################################
#                IMPORTAÇÃO DE DADOS                 #
######################################################

# Read the CSV file
data <- readxl::read_xlsx(path = base_compras_MG)

#################################################
#               LIMPEZA DE DADOS                #
#################################################

# Example cleaning:
cleaned_data <- data %>%
  filter(valorTotal > 0) %>% # Manter apenas as compras que foram realizadas
  group_by(
    codigoGrupoMaterialServico,  # Agrupamento por grupo de material/serviço
    grupoMaterialServico,        # Agrupamento por grupo de material/serviço
    codigoClasseMaterialServico, # Agrupamento por classe de material/serviço
    classeMaterialServico,       # Agrupamento por classe de material/serviço
    codigoMaterialServico,       # Agrupamento por material/serviço
    materialServico              # Agrupamento por material/serviço
  ) %>% 
  reframe(valorTotal = sum(valorTotal, na.rm=T)) # Soma do valor total comprado

###########################################################
#                  EXPORTAÇÃO DE DADOS                    #
###########################################################

# Export cleaned data
write_csv(cleaned_data, output_path)

# Print message
cat("✅ Data processing complete.\n")
