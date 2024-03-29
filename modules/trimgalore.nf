process trimgalore {
    /**
    * Trims paired fastq using trim_galore (https://github.com/FelixKrueger/TrimGalore)
    * @input tuple dataset_id, project, path(forward), path(reverse)
    * @output trimgalore_out tuple dataset_id, project, path("*_val_1.fq.gz"), path("*_val_2.fq.gz")
    */

    tag { dataset_id }

    cpus 1

    memory '4GB'

    container = "quay.io/climb-big-data/trimgalore:0.6.7"

    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}/trimmed_reads", pattern: "*_val_{1,2}.fq.gz", mode: 'copy'
    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}/fastqc", pattern: '*_fastqc.{zip,html}', mode: 'copy'
    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}/report", pattern: '*_trimming_report.txt', mode: 'copy'

    input:

      tuple val(dataset_id), path(forward), path(reverse)

    output:

      tuple val(dataset_id), path("*_val_1.fq.gz"), path("*_val_2.fq.gz"), emit: trimgalore_out optional true
      tuple path("*trimming_report.txt"), path("*_fastqc.{zip,html}"), emit: trimgalore_results optional true

    script:

      """
      if [[ \$(zcat ${forward} | head -n4 | wc -l) -eq 0 ]]; then
        exit 0
      else
        trim_galore --fastqc --paired $forward $reverse
      fi
      """
}
