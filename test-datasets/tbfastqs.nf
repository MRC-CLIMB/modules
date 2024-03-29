process tbfastqs {

    executor 'local'

    output:
    tuple stdout, path("*_1.fastq.gz"), path("*_2.fastq.gz"), emit: tbfastqs_out

    script:
    """
    wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR958/009/SRR9588019/SRR9588019_1.fastq.gz

    wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR958/009/SRR9588019/SRR9588019_2.fastq.gz

    printf 'SRR9588019'
    """
}
