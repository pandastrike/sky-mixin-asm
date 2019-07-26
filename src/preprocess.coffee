preprocess = (SDK, global, meta, local) ->
  {region} = global
  {vpc} = meta

  if vpc
    {region, vpc}
  else
    false

export default preprocess
