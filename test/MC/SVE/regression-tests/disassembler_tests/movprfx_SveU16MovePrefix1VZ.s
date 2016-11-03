# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x35,0x50,0x04
# CHECK: movprfx z21.h, p5/z, z10.h // encoding: [0x55,0x35,0x50,0x04]
# CHECK-ERROR-NOT: movprfx z21.h, p5/z, z10.h 
0xb7,0x2d,0x50,0x04
# CHECK: movprfx z23.h, p3/z, z13.h // encoding: [0xb7,0x2d,0x50,0x04]
# CHECK-ERROR-NOT: movprfx z23.h, p3/z, z13.h 
0x00,0x20,0x50,0x04
# CHECK: movprfx z0.h, p0/z, z0.h // encoding: [0x00,0x20,0x50,0x04]
# CHECK-ERROR-NOT: movprfx z0.h, p0/z, z0.h 
0xff,0x3f,0x50,0x04
# CHECK: movprfx z31.h, p7/z, z31.h // encoding: [0xff,0x3f,0x50,0x04]
# CHECK-ERROR-NOT: movprfx z31.h, p7/z, z31.h 
