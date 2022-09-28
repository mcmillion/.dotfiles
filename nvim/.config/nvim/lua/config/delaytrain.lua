require('delaytrain').setup {
    delay_ms = 1000,
    grace_period = 3,
    keys = {
        ['nv'] = {'h', 'j', 'k', 'l'},
        ['nvi'] = {'<Left>', '<Down>', '<Up>', '<Right>'},
    },
}
