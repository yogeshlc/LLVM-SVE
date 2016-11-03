# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0x11,0x04
# CHECK: movprfx z23.b, p3/m, z13.b // encoding: [0xb7,0x2d,0x11,0x04]
# CHECK-ERROR-NOT: movprfx z23.b, p3/m, z13.b 
0x00,0x20,0x11,0x04
# CHECK: movprfx z0.b, p0/m, z0.b // encoding: [0x00,0x20,0x11,0x04]
# CHECK-ERROR-NOT: movprfx z0.b, p0/m, z0.b 
0x55,0x35,0x11,0x04
# CHECK: movprfx z21.b, p5/m, z10.b // encoding: [0x55,0x35,0x11,0x04]
# CHECK-ERROR-NOT: movprfx z21.b, p5/m, z10.b 
0xff,0x3f,0x11,0x04
# CHECK: movprfx z31.b, p7/m, z31.b // encoding: [0xff,0x3f,0x11,0x04]
# CHECK-ERROR-NOT: movprfx z31.b, p7/m, z31.b 
