local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
  return
end

neoclip.setup({
  content_spec_column = false,
  default_register = { '"', "+", "*" },
  preview = true,
})
