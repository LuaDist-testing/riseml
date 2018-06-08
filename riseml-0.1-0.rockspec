-- This file was automatically generated for the LuaDist project.

package = "riseml"
version = "0.1-0"
-- LuaDist source
source = {
  tag = "0.1-0",
  url = "git://github.com/LuaDist-testing/riseml.git"
}
-- Original source
-- source = {
--    url = "git://github.com/riseml/client-lua",
--    tag = "v0.1-0"
-- }
description = {
   summary = "",
   detailed = "",
   homepage = "*** please enter a project homepage ***",
   license = ""
}
dependencies = {
  "torch", "lua", "turbo"
}
build = {
   type = "builtin",
   modules = {
      riseml = "src/riseml.lua"
   }
}