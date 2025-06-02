# Driving towards net-zero: The impact of electric vehicle flexibility participation on a future Norwegian electricity system

This repository contains the version of the highRES-model (https://github.com/highRES-model) used for the study *Driving towards net-zero: The impact of electric vehicle flexibility participation on a future Norwegian electricity system*.

## Running the model
1. Clone the repository
2. Install snakemake
    - Download miniforge windows exe <https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe>
    - Install Minforge
    - Run the minimal install of the snakemake environment `mamba create -c bioconda -c conda-forge -n snakemake snakemake-minimal pandas zstd`
3. Activate the snakemake environment
4. Navigate to the model repository
5. Get the required input files from https://doi.org/10.5281/zenodo.15299443
6. Extract the required input files into the resources folder.
7. Change the paths in config.yaml.
8. Run snakemake --c "cores" --use-conda

   Replace "cores" with the number of cores to use.
