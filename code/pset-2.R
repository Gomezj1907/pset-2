# Taller de R: Estadística y Programación


# Version.string R version 4.2.1 (2022-06-23 ucrt)
# nickname       Funny-Looking Kid                

# Jorge Gomez - 201923526


# 2.1 Importar
# Importe las bases de datos Módulo de sitio o ubicación en un objeto llamdo 
# location y Módulo de # identificación en un objeto llamado identification

require(pacman)
p_load(tidyverse, rio, xml2, data.table,
       knitr, kableExtra, skimr) 


 #### === Punto 1: importacion === ####

location <- import("input/Módulo de sitio o ubicación.dta") 
identification <- import("input/Módulo de identificación.dta")

#### === Punto 2: Creacion de Variable === ####

# Agricultura cuando sea
# igual a 1, Industria manufacturera cuando sea igual a 2, comercio cuando sea igual a 3 y
# servicios cuando sea igual a 4. a esta variable le llamará bussiness_type.


identification <- identification |> 
  mutate(business_type = case_when(GRUPOS4 == "01" ~ "Agricultura",
                                   GRUPOS4 == "02" ~ "Industria manufacturera",
                                   GRUPOS4 == "03" ~ "Comercio",
                                   GRUPOS4 == "04" ~ "Servicios"))



# 3.2. Sobre el objeto location, genere una variable llamada local, que sea igual a 1 
# si la variable P3053 es igual a 6 o 7

location <- location |>
  mutate(local = ifelse(P3053 %in% c(6,7), 1,0))







