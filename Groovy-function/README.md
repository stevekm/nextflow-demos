# Groovy Function

Demo of different methods for defining and using Groovy (and Java) functions in your Nextflow workflow.

Groovy functions can be defined primarily in two ways

- inline inside your Nextflow `.nf` workflow file
- in a separate `.groovy` file stored in a `libs` directory inside your Nextflow project directory

Both methods are demonstrated here.

When using an inline Groovy function, you only need to define the function itself in your code, and you can then call it throughout the workflow (including inside Channel operators, and inside Process definitions).

When using a Groovy function stored in an external file, you should first create a file in the `libs` directory such as `libs/MyUtils.groovy`. Inside this file, you should create a `class` definition, and attach your custom functions to class as class methods. Note that Nextflow will import the class under the name of the file used, so class `Foo` with method `hello()` inside file `libs/MyUtils.groovy` would instead be called via `MyUtils.hello()` in your Nextflow code. For this reason, its a good idea to keep the filename and the class name the same to avoid confusion.

In this demo, we ingest the contents of a JSON file, then use a series of custom Groovy functions and methods in order to update the resulting `map` objects at various points in the workflow.

```
$ nextflow run main.nf
N E X T F L O W  ~  version 22.10.6
Launching `main.nf` [fervent_coulomb] DSL2 - revision: 252fc94158
hello world from Utils.hello()
inputMap: [samples:[[id:Sample1, type:melanoma, species:human], [id:Sample4, type:adenoma, species:mouse]]]
executor >  local (2)
[6c/81588d] process > ECHO (1) [100%] 2 of 2 ✔
[id:Sample1, type:melanoma, species:human, foo:bar, baz:buzz]
[id:Sample4, type:adenoma, species:mouse, foo:bar, baz:buzz]
ECHO process: [id:Sample4, type:adenoma, species:mouse, foo:bar, baz:buzz, HELLO:WORLD]

ECHO process: [id:Sample1, type:melanoma, species:human, foo:bar, baz:buzz, HELLO:WORLD]
```

## Resources

- https://www.nextflow.io/docs/latest/dsl2.html#function
- "Workflow safety and immutable objects" https://www.youtube.com/watch?v=A357C-ux6Dw
