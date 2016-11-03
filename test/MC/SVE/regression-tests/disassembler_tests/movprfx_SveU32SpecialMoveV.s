# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xbd,0x20,0x04
# CHECK: movprfx z23, z13 // encoding: [0xb7,0xbd,0x20,0x04]
# CHECK-ERROR-NOT: movprfx z23, z13 
0xff,0xbf,0x20,0x04
# CHECK: movprfx z31, z31 // encoding: [0xff,0xbf,0x20,0x04]
# CHECK-ERROR-NOT: movprfx z31, z31 
0x00,0xbc,0x20,0x04
# CHECK: movprfx z0, z0 // encoding: [0x00,0xbc,0x20,0x04]
# CHECK-ERROR-NOT: movprfx z0, z0 
0x55,0xbd,0x20,0x04
# CHECK: movprfx z21, z10 // encoding: [0x55,0xbd,0x20,0x04]
# CHECK-ERROR-NOT: movprfx z21, z10 
