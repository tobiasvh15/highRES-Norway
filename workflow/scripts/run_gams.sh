#!/usr/bin/env bash

# TODO: export environment variable to then have gams read the path from there.
# TODO: also call gams from here and then set the log file path here too


cd ${snakemake_params[modelpath]}
pwd -P

${snakemake_params[gamspath]}gams \
${snakemake_input[gamsfile]} \
logOption=2 gdxCompress=1 \
--weather_yr "${snakemake_wildcards[year]}" \
--dem_yr "${snakemake_wildcards[year]}" \
--codefolderpath "${snakemake_params[sharedcodepath]}" \
--co2intensity "${snakemake_params[co2intensity]}" \
--EV "${snakemake_params[EV]}" \
--EV_flex "${snakemake_params[EV_flex]}" \
--V2G "${snakemake_params[V2G]}" \
--hydro_res_min "${snakemake_params[hydroresmin]}" \
--transmission_fom_percent "${snakemake_params[transmission_fom_percent]}" \
--total_imports "${snakemake_params[total_imports]}"