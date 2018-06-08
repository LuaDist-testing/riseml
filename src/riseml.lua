local turbo = require 'turbo'
require 'torch'

turbo.log.categories.success = true
turbo.log.categories.notice = true

riseml = {}

function riseml.serve(predict_function)
  local PredictHandler = class("Predict", turbo.web.RequestHandler)
  function PredictHandler:post()
    local image = self:get_argument("image", "ERROR")
    timer = torch.Timer()
    styled_image = predict_function(image)
    self:set_status(200)
    self:add_header('Access-Control-Allow-Origin','*')
    self:add_header("Content-Type", "image/jpeg")
    self:write(styled_image)
    local time = timer:time().real
    turbo.log.success(string.format('Request answered in %.4fs', time))
  end

  function PredictHandler:options()
    self:add_header('Access-Control-Allow-Methods', 'POST')
    self:add_header('Access-Control-Allow-Headers', 'content-type')
    self:add_header('Access-Control-Allow-Origin', '*')
  end

  print('webserver running...')
  -- Create an Application object and bind our PredictHandler to the route '/predict'.
  local app = turbo.web.Application:new({
      {"/predict", PredictHandler}
  })

  -- Set the server to listen on port 80 and start the ioloop.
  app:listen(80)
  turbo.ioloop.instance():start()
end