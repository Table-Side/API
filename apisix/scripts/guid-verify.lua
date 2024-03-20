local guid_pattern = “^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$” 

function is_guid(value)
  local success, result = string.match(value, guid_pattern)
  return success ~= nil
end

function validate_request(ctx)
  local captured_value = ctx.capture.cuid
  if not is_guid(captured_value) then
    ctx.status = 400
    ctx.body = "GUID malformed. Please check the GUID and try again."
    return DECLINED
  end
  
  return OK
end

return { validate_request = validate_request }