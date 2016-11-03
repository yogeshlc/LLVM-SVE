# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0xd1,0x04
# CHECK: movprfx z23.d, p3/m, z13.d // encoding: [0xb7,0x2d,0xd1,0x04]
# CHECK-ERROR-NOT: movprfx z23.d, p3/m, z13.d 
0x55,0x35,0xd1,0x04
# CHECK: movprfx z21.d, p5/m, z10.d // encoding: [0x55,0x35,0xd1,0x04]
# CHECK-ERROR-NOT: movprfx z21.d, p5/m, z10.d 
0xff,0x3f,0xd1,0x04
# CHECK: movprfx z31.d, p7/m, z31.d // encoding: [0xff,0x3f,0xd1,0x04]
# CHECK-ERROR-NOT: movprfx z31.d, p7/m, z31.d 
0x00,0x20,0xd1,0x04
# CHECK: movprfx z0.d, p0/m, z0.d // encoding: [0x00,0x20,0xd1,0x04]
# CHECK-ERROR-NOT: movprfx z0.d, p0/m, z0.d 
