# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xf5,0x65
# CHECK: fnmad   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xd5,0xf5,0x65]
# CHECK-ERROR-NOT: fnmad   z21.d, p5/m, z10.d, z21.d 
0xb7,0xcd,0xe8,0x65
# CHECK: fnmad   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xcd,0xe8,0x65]
# CHECK-ERROR-NOT: fnmad   z23.d, p3/m, z13.d, z8.d 
0xff,0xdf,0xff,0x65
# CHECK: fnmad   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xdf,0xff,0x65]
# CHECK-ERROR-NOT: fnmad   z31.d, p7/m, z31.d, z31.d 
0x00,0xc0,0xe0,0x65
# CHECK: fnmad   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xc0,0xe0,0x65]
# CHECK-ERROR-NOT: fnmad   z0.d, p0/m, z0.d, z0.d 
