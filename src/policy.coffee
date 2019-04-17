# Panda Sky Mixin: ASM Policy
# This mixin grants the API Lambdas access to the specified AWS Secrets Manager resources.  That IAM Role permission is rolled into your CloudFormation stack after being generated here.

import Sundog from "sundog"

Policy = (config, global, SDK) ->
  # Grants read access to all lambdas in this deployment.
  # TODO: Too much surface area.  Consider how to limit this access to only the lambdas that need it.

  {AWS: {ASM}} = Sundog SDK
  {get} = ASM()

  {secrets} = config
  resources = []
  for secret in secrets
    try
      resources.push (await get secret).ARN
    catch e
      console.error "Cannot access secret \"#{secret}\" from ASM"

  [
    Effect: "Allow"
    Action: [ "secretsmanager:GetSecretValue" ]
    Resource: resources
  ]

export default Policy
