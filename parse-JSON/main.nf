import groovy.json.JsonSlurper
def jsonSlurper = new JsonSlurper()

params.configFile = "config.json"
String configJSON = new File("${params.configFile}").text
def config = jsonSlurper.parseText(configJSON)

def key1 = config.key1
def key2 = config.key2
def key3

println "key1: ${key1}"
println "key2: ${key2}"

if (config.containsKey('key3')) {
    key3 = config.key3
    println "key3: ${key3}"
} else {
  println "config does not contain key3"
}
