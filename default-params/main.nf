// default input file to use
def default_input = "foo.txt"
def default_input_obj = new File("${default_input}")

// initialize CLI params to default value
params.input = null

// variable to use throughout the workflow
def input

// check if CLI arg was passed; if so, use that instead
if(params.input == null ){
    // make sure the default input object exists too
    if(default_input_obj.exists()){
        input = default_input
    } else {
        log.error("No input specified and default input ${default_input} does not exist")
        exit 1
    }
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

// check the full path to the input
def input_obj_path = input_obj.getCanonicalPath()
log.info("path to input: ${input_obj_path}")

// make sure the input exists
if( !input_obj.exists() ){
    log.error "Input is not a file or dir: ${input}"
    exit 1
}
