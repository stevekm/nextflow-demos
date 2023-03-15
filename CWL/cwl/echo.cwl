#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
stdout: message.txt
inputs:
  message:
    type: string
    inputBinding:
      position: 1
outputs:
  message_output:
    type: stdout
