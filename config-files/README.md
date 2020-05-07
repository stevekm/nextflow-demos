# Dynamic Resource Allocation on Task Retry

This demonstration shows how to use multiple config files with Nextflow in order to override task configurations.

This demo workflow will run a single task which prints to console its `time` and `memory` resource allocations. It also has a `tag` which is set up to show from where those configurations were set.

Multiple config files are included:

- `nextflow.config`: the default configuration file for Nextflow that gets used automatically for the base configs
- `small.config`: contains smaller configurations set with generic `process` directives
- `small.withName.config`: contains smaller configurations set with the `process.withName` process selector
- `large.config`: contains larger configurations set with generic `process` directives
- `large.withName.config`: contains larger configurations set with the `process.withName` process selector

Additionally, the file `nextflow.config` contains two sets of `process` configurations, one set by the generic `process` settings (`nextflow.config (generic)`) and another set by the `withName` process selector (`nextflow.config (withName)`). The workflow file itself, `main.nf`, contains the same settings as well.

By changing the inclusion and order of the configs, we can see which ones take precedence during execution.

Reference: https://www.nextflow.io/docs/latest/config.html?highlight=withname#selectors-priority

## Usage

Install Nextflow:

```
curl -fsSL get.nextflow.io | bash
```

Run the workflow without any extra args.

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [distracted_montalcini] - revision: fcf722d6ee
executor >  local (1)
[7e/5be20f] process > run_task (nextflow.config (withName)) [100%] 1 of 1 ✔
task.memory: 10 MB
task.time: 10m
```

As shown, the `nextflow.config (withName)` settings were applied. These override both the `nextflow.config (generic)` settings and the `main.nf` settings.

Run the workflow with the `small.config` added

```
$ ./nextflow -c small.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [lethal_davinci] - revision: fcf722d6ee
executor >  local (1)
[cf/34f22f] process > run_task (nextflow.config (withName)) [100%] 1 of 1 ✔
task.memory: 10 MB
task.time: 10m
```

The `nextflow.config (withName)` is still overriding the values from `small.config`

Try with `small.withName.config` instead

```
$ ./nextflow -c small.withName.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [sharp_kare] - revision: fcf722d6ee
executor >  local (1)
[69/c76ee3] process > run_task (small.withName.config) [100%] 1 of 1 ✔
task.memory: 5 MB
task.time: 5m
```

The addition of the new config file `small.withName.config` was able to override the settings from `nextflow.config`. This shows that the `withName` configs from `nextflow.config` require other `withName` configs in order to override them.

Now we can try with two sets of `withName` configs and see what happens

```
$ ./nextflow -c small.withName.config -c large.withName.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [shrivelled_stone] - revision: fcf722d6ee
executor >  local (1)
[25/c53dad] process > run_task (large.withName.config) [100%] 1 of 1 ✔
task.memory: 16 MB
task.time: 16m
```

The values from `large.withName.config` overrode `small.withName.config` because it came second in order on the command line. We can reverse the order to see the values of `small.withName.config` take precedence again:

```
$ ./nextflow -c large.withName.config -c small.withName.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [desperate_hoover] - revision: fcf722d6ee
executor >  local (1)
[1b/f703d7] process > run_task (small.withName.config) [100%] 1 of 1 ✔
task.memory: 5 MB
task.time: 5m
```

In these cases, we had to use subsequent `withName` configs to override both `nextflow.config`'s own `withName` configs, and any previously loaded `withName` configs from other config files.

Lets see what happens when we remove `nextflow.config`.

```
$ mv nextflow.config foo

$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [elegant_ramanujan] - revision: fcf722d6ee
executor >  local (1)
[24/417eeb] process > run_task (main.nf) [100%] 1 of 1 ✔
task.memory: 3 MB
task.time: 3m
```

Now, without any config file present, we can see the values that were hard-coded into the `main.nf` script take effect.

We can also demonstrate the precedence of subsequent inclusions of other config files, with and without their own `withName` directives.

When we include another config file that contains generic process configs, it does not override the settings in `main.nf`

```
$ ./nextflow -c small.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [peaceful_marconi] - revision: fcf722d6ee
executor >  local (1)
[60/ce8166] process > run_task (main.nf) [100%] 1 of 1 ✔
task.memory: 3 MB
task.time: 3m
```

But if we use a config file that has `withName`, it does override `main.nf`

```
$ ./nextflow -c small.withName.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [modest_hoover] - revision: fcf722d6ee
executor >  local (1)
[c0/5504c7] process > run_task (small.withName.config) [100%] 1 of 1 ✔
task.memory: 5 MB
task.time: 5m
```

The `withName` also continues to override subsequent configs included with generic directives

```
$ ./nextflow -c small.withName.config -c large.config run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [spontaneous_bhabha] - revision: fcf722d6ee
executor >  local (1)
[ca/90c2a4] process > run_task (small.withName.config) [100%] 1 of 1 ✔
task.memory: 5 MB
task.time: 5m
```

If we restore `nextflow.config`, but removes its `withName` directives, it's generic process directives will not be able to override the settings in `main.nf`.

```
$ mv foo nextflow.config

# comment out the withName directives in nextflow.config

$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [jovial_wright] - revision: fcf722d6ee
executor >  local (1)
[92/e9ee88] process > run_task (main.nf) [100%] 1 of 1 ✔
task.memory: 3 MB
task.time: 3m
```


If we comment out the directives inside `main.nf`, the generic directives from `nextflow.config` can take affect.

```
# comment out directives from main.nf

$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [cheeky_tuckerman] - revision: c6aac3cf5e
executor >  local (1)
[a2/eb6794] process > run_task (nextflow.config (generic)) [100%] 1 of 1 ✔
task.memory: 9 MB
task.time: 9m
```
