Channel.from([ 'foo', 'bar', 'baz' ]).set { input_ch }

process make_foo {
    tag "${x}"
    echo true
    publishDir "output", overwrite: true, mode: 'copy'

    input:
    val(x) from input_ch

    output:
    file("${output_file}")

    script:
    output_file = "${x}.txt"
    """
    echo "this is the script for ${x}"
    echo "${x}" > "${output_file}"
    echo "check the .command.log file for more SLURM execution details (\$(pwd)/.command.log)"
    """

}
