fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'


author 'd3rp-jsx converted to redm by Outsider'
description 'No Clip Pro - Enhanced NoClip for RedM'
version '1.1.0'

client_scripts {
  'locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/cl_noclip.lua',
}

server_scripts {
  'config.lua',
  'server/sv_noclip.lua',
}

file 'locale.js'