# My neovim from scratch config

My config, not polished for sharing or anything try it at your own risk, not really prioritizing intended to share 🤷.

# My astronvim setup

I'm working on migrating to astronvim to leverage its usage of the lazy package manager and its reference community cofigurations.
That repo is here https://github.com/oflisback/astro-nvim-user.

# Some nice features

| Feature                                       | Keybind                     | Astronvim setup             | Plugin                                  | Comment |
| --------------------------------------------- | --------------------------- | --------------------------- | --------------------------------------- | ------- |
| Markdown WYSIWYG                              | <l>mp                       | <l>mp                       | iamcco/markdown-preview                 |         |
| ChatGPT                                       | <l>p                        | <l>?                        | jackMort/ChatGPT                        |         |
| Open on github                                | <l>gh                       | <l>mh                       | ruanyl/vim-gh-line                      |         |
| Leap navigation                               | <tab>                       | <tab>                       | ggandor/leap                            |         |
| Leap like f/F                                 | f/F                         | f/F                         | ggandor/flit                            |         |
| Comment toggle block                          | gc / gcc (line)             | gc/gcc                      | numToStr/Comment                        |         |
| Jump to repo                                  | <l>P                        | <l>P                        | cljoly/telescope-repo                   |         |
| Better escape                                 | jj                          | jj                          | max397574/better-escape.nvim            |         |
| Keep only current buffer                      | <l>mo                       | <l>bc                       |                                         |         |
| Go to definition                              | gd                          | gd                          |                                         |         |
| File via content, refine among hits, quickfix | <l>st -> <ctrl>f -> <ctrl>t | <l>fw -> <ctrl>f -> <ctrl>q | nvim-telescope/telescope, folke/trouble |         |
| Diagnostics to telescope to quickfix          | <l>ld -> <ctrl>q            | <l>lD -> <ctrl>q            |                                         |         |
