import pandas as pd

(
    pd.read_csv(
        snakemake.input[0],
        index_col=["time", "technology", "spatial"],
        dtype={"time": int, "technology": object, "spatial": object, 0: float},
    )
    .reset_index()
    .sort_values(by=["0", "time", "technology", "spatial"])
    .drop_duplicates(["time", "technology", "spatial"], keep="last")
    .set_index(["time", "technology", "spatial"])
    .to_parquet(snakemake.output[0], compression="zstd")
)
