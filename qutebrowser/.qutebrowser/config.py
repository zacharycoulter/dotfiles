import catppuccin

config.load_autoconfig(False)

c.url.start_pages = ['https://www.google.com/']

c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!a':       'https://www.amazon.com/s?k={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!e':       'https://www.ebay.com/sch/i.html?_nkw={}',
    '!f':      'https://www.facebook.com/s.php?q={}',
    '!g':      'https://github.com/search?o=desc&q={}&s=stars',
    '!i':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!m':       'https://www.google.com/maps/search/{}',
    '!r':       'https://www.reddit.com/search?q={}',
    '!t':      'https://twitter.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!y':      'https://www.youtube.com/results?search_query={}'
}

c.window.hide_decoration = True

c.auto_save.session = True

c.fonts.default_family = 'San Francisco'
c.fonts.web.family.standard = 'San Francisco'
c.fonts.web.family.serif = 'San Francisco'
c.fonts.web.family.sans_serif = 'San Francisco'
c.fonts.web.size.default = 20
c.fonts.web.size.default_fixed = 16

# c.colors.webpage.darkmode.enabled = True

c.qt.highdpi = True

c.content.javascript.clipboard = 'access'

c.input.insert_mode.auto_load = True

c.tabs.favicons.scale = 1.25
c.tabs.indicator.padding = {"bottom": 0, "left": 0, "right": 3, "top": 0}
c.tabs.padding = {"bottom": 3, "left": 3, "right": 3, "top": 3}
c.tabs.show = 'multiple'
c.tabs.title.format = '{index}: {audio}{current_title}{title_sep}{current_url}'

c.statusbar.show = 'in-mode'

catppuccin.setup(c, 'mocha', True)
