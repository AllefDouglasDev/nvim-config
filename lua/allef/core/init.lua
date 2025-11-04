vim.loader.enable()

require("allef.core.keymaps")
require("allef.core.options")
require("allef.core.fix_issue")
require("allef.core.run_script")
require("allef.core.write_mode")
require("allef.core.save_folder_file")
require("allef.core.accept_reject_incoming_changes")
require("allef.core.file_autocomplete").setup()
require("allef.core.markdown").setup()
require("allef.core.note").setup()
require("allef.core.todo").setup()

