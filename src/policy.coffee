import Sundog from "sundog"

Policy = (SDK, global, meta, local) ->
  {get} = Sundog(SDK).AWS.ASM()

  resources = []
  for secret in local.secrets
    try
      resources.push (await get secret).ARN
    catch e
      console.error "Cannot access secret \"#{secret}\" from ASM"
      console.error e

  [
    Effect: "Allow"
    Action: [ "secretsmanager:GetSecretValue" ]
    Resource: resources
  ]

export default Policy
