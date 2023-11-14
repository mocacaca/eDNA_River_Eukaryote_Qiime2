qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path manifest.txt --output-path trimmed.qza --input-format PairedEndFastqManifestPhred33V2

wait
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed.qza --p-trim-left-f 0 --p-trim-left-r 0 --p-trunc-len-f 0 --p-trunc-len-r 0 --p-max-ee-f 1.0 --p-max-ee-r 1.0 --p-trunc-q 20 --p-min-overlap 12 --p-n-threads 40 --verbose --o-representative-sequences trimmed_denoise_seq.qza --o-table trimmed_denoise_table.qza --o-denoising-stats trimmed_denoise_stats.qza

wait
qiime metadata tabulate --m-input-file trimmed_denoise_stats.qza --o-visualization trimmed_denoise_stats.qzv
qiime feature-table tabulate-seqs --i-data trimmed_denoise_seq.qza --o-visualization trimmed_denoise_seq.qzv

qiime tools export --input-path trimmed_denoise_seq.qza --output-path denoise_seq
qiime tools export --input-path trimmed_denoise_table.qza --output-path denoise_table

wait
biom convert --to-tsv -i denoise_table/feature-table.biom -o denoise_table/trimmed_denoise_table.tsv

#cluster
qiime vsearch cluster-features-de-novo --i-table trimmed_denoise_table.qza --i-sequences trimmed_denoise_seq.qza --p-perc-identity 0.97 --o-clustered-table trimmed_denoise_cluster_table.qza --o-clustered-sequences trimmed_denoise_cluster_seq.qza

wait
qiime tools export --input-path trimmed_denoise_cluster_table.qza --output-path cluster_table

wait
biom convert --to-tsv -i cluster_table/feature-table.biom -o cluster_table/trimmed_denoise_cluster_table.tsv
qiime tools export --input-path trimmed_denoise_cluster_seq.qza --output-path cluster_seq
