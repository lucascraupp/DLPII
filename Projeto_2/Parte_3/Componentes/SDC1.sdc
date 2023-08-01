create_clock -name CLOCK_50 -period 50MHz [get_ports {*}]
derive_clock_uncertainty
derive_pll_clocks