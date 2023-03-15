#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: zip
inputs:
  archive_output_file:
    type: string
    inputBinding:
      position: 1
  archive_input_file:
    type: File
    inputBinding:
      position: 2
outputs:
  archive:
    type: File
    outputBinding:
      glob: $(inputs.archive_output_file)
