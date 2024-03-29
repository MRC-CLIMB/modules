#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {tbfastqs} from '../test-datasets/tbfastqs.nf'
include {trimgalore} from '../modules/trimgalore.nf'
include {shovill} from '../modules/shovill.nf'

// define workflow
workflow {

  // main workflow
  main:

    tbfastqs()
    trimgalore(tbfastqs.out.tbfastqs_out)
    shovill(trimgalore.out.trimgalore_out)

}