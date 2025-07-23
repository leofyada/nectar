##############################################
#              CONFIGURAÇÕES                 #
##############################################

# Load libraries
library(readr)                 # Biblioteca para leitura de arquivos
library(dplyr)                 # Biblioteca para manipulação de dados
library(readxl)                # Biblioteca para leitura de Excel
library(googleCloudStorageR)   # Biblioteca para acessar google cloud storage
library(rstudioapi)            # Biblioteca para utilização de APIs
library(here)                  # Biblioteca para reprodução de scripts

# Set options
options(stringsAsFactors = FALSE)

# Get data from GCP
gcs_setup()
objects <- gcs_list_objects()
gcs_get_object(objects$name[[2]], saveToDisk = here::here("docker_r", "data", "base_itens.xlsx"), overwrite = TRUE)

# Set file paths
base_compras_MG  <- here::here("docker_r", "data", "base_itens.xlsx")
output_path <- here::here("docker_r", "data", "base_compras_materialservico.csv")

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
