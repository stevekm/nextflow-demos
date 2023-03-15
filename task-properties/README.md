# task properties

Simple demo of method for accessing and collecting all properties (attributes) of the `task` object at the runtime of a specific Nextflow `process` instance.

Accessing these properties can be useful to help you set up dynamic directives and script sections inside your Nextflow processes, but you need to know which properties are available for access first!

- See also: "Workflow introspection" https://www.nextflow.io/docs/latest/metadata.html

## Usage

```
# install Nextflow if its not already installed
make install

# run the workflow
nextflow run main.nf
```

Output should look like this:

```
N E X T F L O W  ~  version 21.04.1
Launching `main.nf` [exotic_fourier] - revision: bf2811bb74
executor >  local (2)
[2f/66568a] process > run_task (2) [100%] 2 of 2 ✔
x: 2
task: [maxRetries:0, process:run_task, maxErrors:-1, shell:[/bin/bash, -ue], executor:local, index:1, echo:true, cacheable:true, validExitStatus:[0], errorStrategy:TERMINATE]
workflow: repository: null, projectDir: /Users/steve/projects/nextflow-demos/task-properties, commitId: null, revision: null, startTime: 2021-05-27T10:02:24.735-04:00, endTime: null, duration: null, container: {}, commandLine: nextflow run main.nf, nextflow: nextflow.NextflowMeta(version:21.04.1, build:5556, timestamp:14-05-2021 15:20 UTC, preview:nextflow.NextflowMeta$Preview@5ca1f591, enable:nextflow.NextflowMeta$Features@551de37d, dsl2:true, strictModeEnabled:false, dsl2Final:true), success: false, workDir: /Users/steve/projects/nextflow-demos/task-properties/work, launchDir: /Users/steve/projects/nextflow-demos/task-properties, profile: standard
all task properties: accelerator=null
attempt=1
binding=DelegateMap[process: run_task; script: Script_ac671604; holder: [x:2, $:true, task:[maxRetries:0, process:run_task, maxErrors:-1, shell:[/bin/bash, -ue], executor:local, index:1, echo:true, cacheable:true, validExitStatus:[0], errorStrategy:TERMINATE]]]
clusterOptionsAsList=[]
containerOptions=null
containerOptionsMap={}
cpus=1
disk=null
dynamic=false
echo=true
empty=false
errorCount=0
errorStrategy=TERMINATE
machineType=null
maxErrors=-1
maxRetries=0
memory=null
module=[]
podOptions=nextflow.k8s.model.PodOptions(nodeSelector:null, imagePullSecret:null, envVars:[], mountSecrets:[], imagePullPolicy:null, volumeClaims:[], mountConfigMaps:[], labels:[:], securityContext:null, annotations:[:])
publishDir=[]
retryCount=0
shell=[/bin/bash, -ue]
storeDir=null
stubBlock=null
target={maxRetries=0, process=run_task, maxErrors=-1, shell=[/bin/bash, -ue], executor=local, index=1, echo=true, cacheable=true, validExitStatus=[0], errorStrategy=TERMINATE}
time=null
validExitStatus=[0]
```


# Credits

- method taken from https://gist.github.com/HopefulLlama/edecc82e9e6145544f34
