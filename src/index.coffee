import {resolve} from "path"
import MIXIN from "panda-sky-mixin"
import {read as _read} from "panda-quill"
import {yaml} from "panda-serialize"

import getPolicyStatements from "./policy"
import preprocess from "./preprocessor"
#import cli from "./cli"

read = (name) ->
  _read resolve __dirname, "..", "..", "..", "files", name

mixin = do ->
  schema = yaml await read "schema.yaml"
  template = await read "template.yaml"

  Media = new MIXIN {
    name: "asm"
    schema
    template
    preprocess
    #cli
    getPolicyStatements
  }
  Media

export default mixin
