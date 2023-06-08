// need to write a class to hold custom methods
// the name of this file seems to be the name of the class that will be made available inside your Nextflow workflow
// e.g. MapUpdater.groovy -> MapUpdater class inside main.nf
// regardless of what the actual class name listed here is (?)
// so to avoid confusion, best to keep the filename and class name the same in here

// Sateesh_Peri; "all files in lib/ are added by Nextflow to the class path and you reference them by <class>.<function> ... in your workflow"

class Utils {
    public static hello(){
        println "hello world from Utils.hello()"
    }

    public static Map updateMap(inputMap){
        // its a good practice in Nextflow workflows to never modify a map object
        // but instead return a new updated map
        // to avoid potential issues with shared memory access across Channels and processes
        def outputMap = [:]
        outputMap << inputMap
        outputMap["baz"] = "buzz"
        return outputMap
    }

    public static Map updateMap2(inputMap){
        def outputMap = [:]
        outputMap << inputMap
        outputMap["HELLO"] = "WORLD"
        return outputMap
    }
}



// more references;
// https://github.com/nf-core/scrnaseq/blob/6cccb9d37afa873b6799cd09f8589b5b129c8ac1/lib/WorkflowScrnaseq.groovy#L8
// https://github.com/nf-core/fetchngs/pull/166/files#diff-91e390154a1e3bad925b517326dc33669ffb2317451d9c025b2b715c35784c3c
// https://stackoverflow.com/questions/57188005/how-to-import-and-use-functions-in-groovy
