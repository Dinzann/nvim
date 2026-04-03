local components = require 'custom.config.heirline.components'
vim.o.cmdheight = 0

return {
  components.RightPadding(components.ModeSimple, 0),
  components.RightPadding(components.FileNameBlock, 1),
  components.RightPadding(components.Git, 1),
  components.RightPadding(components.Diagnostics, 1),
  components.RightPadding(components.Overseer, 1),
  components.RightPadding(components.SearchOccurrence, 0),
  components.Fill,
  components.MacroRecording,
  components.Fill,
  components.RightPadding(components.ShowCmd),
  components.RightPadding(components.Formatters, 1),
  components.RightPadding(components.FileType, 0),
  components.Ruler,
}
