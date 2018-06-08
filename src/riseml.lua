local turbo = require 'turbo'
require 'torch'
local cjson = require 'cjson'

turbo.log.categories.success = true
turbo.log.categories.notice = true

riseml = {}

function riseml.serve(predict_function)
  local PredictHandler = class("Predict", turbo.web.RequestHandler)
  function PredictHandler:post()
    local image = self:get_argument("image", "ERROR")
    timer = torch.Timer()
    predicted_image = predict_function(image)
    self:set_status(200)
    self:add_header('Access-Control-Allow-Origin','*')
    self:add_header("Content-Type", "image/jpeg")
    self:write(predicted_image)
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

function riseml.serve_rectangles(predict_function)
  local PredictHandler = class("Predict", turbo.web.RequestHandler)
  function PredictHandler:post()
    local image = self:get_argument("image", "ERROR")
    timer = torch.Timer()
    result = predict_function(image)
    json = cjson.encode(result)
    self:set_status(200)
    self:add_header('Access-Control-Allow-Origin','*')
    self:add_header("Content-Type", "application/json")
    self:write(json)
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

function riseml.serve_it_t(predict_function)
  local PredictHandler = class("Predict", turbo.web.RequestHandler)
  function PredictHandler:post()
    local image = self:get_argument("image", "ERROR")
    local question = self:get_argument("question", "ERROR")
    timer = torch.Timer()
    answer = predict_function(image, question)
    self:set_status(200)
    self:add_header('Access-Control-Allow-Origin','*')
    self:add_header("Content-Type", "image/jpeg")
    self:write(answer)
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

  -- Set the server to listen on port 80 and start the ioloop.
  app:listen(80)
  turbo.ioloop.instance():start()
end
