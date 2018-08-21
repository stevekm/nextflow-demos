// default input file to use
def default_input = "foo.txt"

// initialize CLI params to default value
params.input = default_input

// variable to use throughout the workflow
def input

// check if CLI arg was passed; if so, use that instead
if(params.input == default_input){
    input = default_input
} else {
    input = params.input
}

def arg1_default = "fizz"
def arg1
params.arg1 = null
if(params.arg1 == null){
    arg1 = arg1_default
    log.warn("No value provided for arg1, using default: ${arg1_default}")
} else {
    arg1 = params.arg1
}

log.info("~~~~~~~~~~~~~~~~~~~~~~~~")
log.info("default_input :    ${default_input}")
log.info("params.input  :    ${params.input}")
log.info("input         :    ${input}")
log.info("arg1_default  :    ${arg1_default}")
log.info("params.arg1   :    ${params.arg1}")
log.info("arg1          :    ${arg1}")
log.info("~~~~~~~~~~~~~~~~~~~~~~~~")

// make sure the input is a real file or dir
def input_obj = new File("${input}")
if( !input_obj.exists() ){
    log.error "Input is not a file or dir: ${input}"
    exit 1
}
