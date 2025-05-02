return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- shell = 'cmd /k ""%ConEmuDir%\\..\\init.bat" & "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\Common7\\Tools\\VsDevCmd.bat""',
      shell = vim.o.shell,
      -- shell = 'cmd.exe /k C:\\dev\\terminal.cmd',
    },
  },
}
