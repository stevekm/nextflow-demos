Channel.from([
[['param1', '-arg 1']],
[['param2', '-arg 2']],
[['param3', '-arg 3']],
[['param4', '-arg 4']],
]).into { myparams_ch1; myparams_ch2; myparams_ch3; myparams_ch4 }
Channel.from('foo').set { input_ch3 }

// create cartesian product from 4 copies of the input channel
myparams_ch1.combine(myparams_ch2)
    .combine(myparams_ch3)
    .combine(myparams_ch4)
    .map { set1, set2, set3, set4 ->
        // remove duplicate params from each set
        def unique = [ set1, set2, set3, set4 ] as Set
        return(unique)
    }
    .unique() // remove duplicates outputs
    .set { combined_params }
    // .subscribe { println "${it}" }


process run {
    echo true
    input:
    set val(x), val(params) from input_ch3.combine(combined_params)

    script:
    val1 = params.collect { it[0] }.join('.')
    val2 = params.collect { it[1] }.join(' ')
    """
    echo "${val1}: ${val2}"
    """
}
