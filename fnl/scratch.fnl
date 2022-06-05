(local f vim.fn)
(local api vim.api)
(local cmd vim.cmd)

(var last-ext nil)

(lambda open-split [direction]
  "Opens bottom split terminal at 20% height."
  (let [bufheight (f.floor (/ (f.winheight 0) 5))]
    (vim.cmd (.. direction " " bufheight "split"))
    (local bufnr (api.nvim_create_buf true false))
    (api.nvim_set_current_buf bufnr)
    bufnr))

(lambda open-scratchpad-with-ext [ext]
  (let [cwd (vim.fn.getcwd)
        bufnr (open-split "aboveleft")]
       (cmd (.. "edit .scratch." ext))))

(lambda open-scratchpad []
 (set last-ext (f.input "Scratchpad extension> "))
 (open-scratchpad-with-ext last-ext))

(lambda open-last-scratchpad []
 (if (= last-ext nil)
  (set last-ext (vim.fn.expand "%:e")))
 (open-scratchpad-with-ext last-ext))

(lambda open-current-scratchpad []
 (set last-ext (vim.fn.expand "%:e"))
 (open-scratchpad-with-ext last-ext))

{:open-scratchpad open-scratchpad
 :open-last-scratchpad open-last-scratchpad
 :open-current-scratchpad open-current-scratchpad}
