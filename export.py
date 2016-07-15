__author__ = "David Manouchehri"

import binexport2_pb2
import r2pipe

r2p = r2pipe.open("sample-files/fauxware")
r2p.cmd('aaaa')

file = r2p.cmdj('ij')
r2strings = r2p.cmdj('izj')
r2functions = r2p.cmdj('aflj')
r2imports = r2p.cmdj('iij')
r2symbols = r2p.cmdj('isj')
r2entry = r2p.cmdj('iej')

r2p.quit()
exported = binexport2_pb2.BinExport2()

meta = exported.meta_information
meta.executable_name = file.get('core').get('file')  # sample-files/fauxware
# meta.architecture_name = file.get('bin').get('machine') # AMD x86-64 architecture
meta.architecture_name = str(file.get('bin').get('arch')) + "-" + str(file.get('bin').get('bits'))  # x86-64


library = exported.library

string_ref = exported.string_reference

string_table = exported.string_table

# def add_ref(ref):
#     string_table.append("string!")
#     ref.string_table_index = len(string_table)
#
# add_ref(exported.string_reference.add())
#
# reffy = exported.string_reference.add()
# string_table.append("string!")
# reffy.string_table_index = len(string_table)

import base64

# Need to fix the instruction_index
for r2string in r2strings:
    string_reference = exported.string_reference.add()
    # reffy.instruction_index = r2string.get('paddr')
    string_table.append(base64.b64decode(r2string.get('string')))
    string_reference.string_table_index = len(string_table) - 1

# Looks good
for r2symbol in r2symbols:
    exp = exported.expression.add()
    exp.type = exp.Type.Value('SYMBOL')
    exp.symbol = r2symbol.get('name')
    exp.immediate = r2symbol.get('vaddr')

# for r2function in r2functions:
#     exp = exported.expression.add()
#     exp.type = exp.Type.Value('SYMBOL')
#     exp.symbol = r2function.get('name')
#     exp.immediate = r2function.get('offset')
#     # Missing parent_index?

# for r2function in r2functions:
#     funny = exported.call_graph.vertex.add()
#     funny.address = r2function.get('offset')
#     funny.mangled_name = r2function.get('name')

call_graph = exported.call_graph

# Looks good
for r2function in r2functions:
    vertex = exported.call_graph.vertex.add()
    vertex.address = r2function.get('offset')

    vertex.mangled_name = r2function.get('name')
    # vertex.demangled_name = 'I should figure this out'

    # Need to set the vertex type.
    if str(r2function.get('name')).startswith("sym.imp"): # probably not a very good way of doing it. Maybe if realsz = 48?
        vertex.type = vertex.Type.Value('THUNK')

# this resolves xrefs in the most painful way possible. Definitely don't do this, ever.
for r2function in r2functions:
    i = 0
    for vertex in call_graph.vertex:
        if vertex.address == r2function.get('offset'):
            j = 0
            for vertexref in call_graph.vertex:
                for callref in r2function.get('callrefs'):
                    if callref.get('addr') == vertexref.address:
                        edge = call_graph.edge.add()
                        edge.source_vertex_index = i
                        edge.target_vertex_index = j
                j += 1
            break
        i += 1


for r2import in r2imports:
    vertex = call_graph.vertex.add()
    vertex.type = vertex.Type.Value('IMPORTED')
    vertex.mangled_name = r2import.get('name')
    # vertex.demangled_name = vertex.mangled_name
    # vertex.address = r2import.get('plt')  # Wrong?

# flow time!

import json

for r2function in r2functions:
    offset = r2function.get('offset')
    print offset
    #print json.dumps(r2p.cmdj('agj @ ' + str(offset)), indent=2, separators=(',', ': '))

# print(str(exported))

r2p.quit()
