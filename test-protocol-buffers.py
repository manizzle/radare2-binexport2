__author__ = "David Manouchehri"

import binexport2_pb2

exported = binexport2_pb2.BinExport2()

meta = exported.meta_information

meta.executable_name = "test.exe"
meta.executable_id = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca4959911b7852b855"
meta.architecture_name = "x86-64"

import time
meta.timestamp = int(time.time())

test = exported.instruction.add()
test.address = 1337

print(str(exported))

# f = open("sample-files/fauxware.BinExport", "rb")

# imported = binexport2_pb2.BinExport2()
# imported.ParseFromString(f.read())
# f.close()
#
# print(str(imported))

# f = open("output.BinExport", "wb")
# f.write(exported.SerializeToString())
# f.close()

