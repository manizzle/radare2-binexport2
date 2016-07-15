__author__ = "David Manouchehri"

import r2pipe

print("Written by " + __author__)

print(r2pipe.version())

r2p = r2pipe.open('sample-files/fauxware')
r2p.cmd('aaaa')

file = r2p.cmdj("ij")

r2p.quit()
# r2pipe.open()
