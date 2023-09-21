# Taller de R: Estadística y Programación


# Version.string R version 4.2.1 (2022-06-23 ucrt)
# nickname       Funny-Looking Kid                

# Jorge Gomez - 201923526

# Clean environment

rm(list = ls())

# Cargo las librerias
require(pacman)
p_load(tidyverse, rio, xml2, data.table,
       knitr, kableExtra, skimr) 


 #### === Punto 1: importacion === ####

location <- as.data.frame(import("input/Módulo de sitio o ubicación.dta")) 
identification <- as.data.frame(import("input/Módulo de identificación.dta"))  

 #### === Punto 2: Exportacion === ####

 export(location, "output/location.rds") 
 export(identification, "output/identification.rds")


 #### === Punto 3: Creacion de Variable === ####

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


 #### === Punto 4: Eliminar filas/columnas === ####

# 4.1 Almacene en un obeto llamado identification_sub el subconjunto de observaciones del objeto
# identification que pertenezcan a la industria manufacturera.


identification_sub <- identification |>
  filter(business_type == "Industria manufacturera")


# 4.2 Del objeto location seleccione solo las variables DIRECTORIO, SECUENCIA_P, 
# SECUENCIA_ENCUESTA, # P3054, P469, COD_DEPTO, F_EXP
# y guardelo en nuevo objeto llamado location_sub.

location_sub <- location |> select(DIRECTORIO, SECUENCIA_P, 
                                   SECUENCIA_ENCUESTA,  P3054, 
                                   P469, COD_DEPTO, F_EXP)

# 4.3 Del objeto identification_sub, seleccione las variables DIRECTORIO, SECUENCIA_P, 
# SECUENCIA_ENCUESTA, P35, P241, P3032_1, P3032_2 , P3032_3 , P3033 y P3034
# y sobre escriba el objeto identification_sub

identification_sub <- identification_sub |>
  select(DIRECTORIO, SECUENCIA_P, SECUENCIA_ENCUESTA, P35, 
         P241, P3032_1, P3032_2 , P3032_3 , P3033, P3034)

# Combinar bases de datos
# 5.1 Use las variables DIRECTORIO, SECUENCIA_P y SECUENCIA_ENCUESTA 
# para unir en una única base de datos, los objetos location_sub y identification_sub.


final_data <-  full_join(location_sub, identification_sub, 
                         by = c("DIRECTORIO", "SECUENCIA_P", "SECUENCIA_ENCUESTA"))



