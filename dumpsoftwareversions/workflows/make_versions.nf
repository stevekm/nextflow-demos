include { MAKE_VERSIONS1 } from '../modules/local/make_versions1.nf'
include { MAKE_VERSIONS2 } from '../modules/local/make_versions2.nf'

workflow MAKE_VERSIONS {
    main:
        input_ch = Channel.from([1,2,3,4,5])
        MAKE_VERSIONS1(input_ch)
        MAKE_VERSIONS2(input_ch)

    emit:
        version1 = MAKE_VERSIONS1.out.versions
        version2 = MAKE_VERSIONS2.out.versions
}