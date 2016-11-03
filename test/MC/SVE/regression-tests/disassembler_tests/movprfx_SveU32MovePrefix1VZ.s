# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0x90,0x04
# CHECK: movprfx z0.s, p0/z, z0.s // encoding: [0x00,0x20,0x90,0x04]
# CHECK-ERROR-NOT: movprfx z0.s, p0/z, z0.s 
0xff,0x3f,0x90,0x04
# CHECK: movprfx z31.s, p7/z, z31.s // encoding: [0xff,0x3f,0x90,0x04]
# CHECK-ERROR-NOT: movprfx z31.s, p7/z, z31.s 
0xb7,0x2d,0x90,0x04
# CHECK: movprfx z23.s, p3/z, z13.s // encoding: [0xb7,0x2d,0x90,0x04]
# CHECK-ERROR-NOT: movprfx z23.s, p3/z, z13.s 
0x55,0x35,0x90,0x04
# CHECK: movprfx z21.s, p5/z, z10.s // encoding: [0x55,0x35,0x90,0x04]
# CHECK-ERROR-NOT: movprfx z21.s, p5/z, z10.s 
