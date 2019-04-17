# This mixin grants permission to a pre-existing ASM resource, but does not establish new secrets nor deletes old ones.

import {isObject} from "panda-parchment"
import Sundog from "sundog"

process = (SDK, config) ->
  {AWS: {ASM}} = Sundog SDK
  {exists} = ASM()

  # Start by extracting out the ASM configuration:
  {env} = config
  c = config.aws.environments[env].mixins.asm
  c = if isObject c then c else {}

  {vpc, region} = config.aws

  # Output configuration to be used by the template. VPC configuration sets up an endpoint allowing the lambdas to reach the ASM service endpoint on the public Internet.
  {vpc, region}


export default process
