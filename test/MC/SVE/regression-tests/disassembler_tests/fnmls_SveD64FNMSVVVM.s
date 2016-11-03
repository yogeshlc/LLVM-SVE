# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0xe8,0x65
# CHECK: fnmls   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x6d,0xe8,0x65]
# CHECK-ERROR-NOT: fnmls   z23.d, p3/m, z13.d, z8.d 
0xff,0x7f,0xff,0x65
# CHECK: fnmls   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x7f,0xff,0x65]
# CHECK-ERROR-NOT: fnmls   z31.d, p7/m, z31.d, z31.d 
0x00,0x60,0xe0,0x65
# CHECK: fnmls   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x60,0xe0,0x65]
# CHECK-ERROR-NOT: fnmls   z0.d, p0/m, z0.d, z0.d 
0x55,0x75,0xf5,0x65
# CHECK: fnmls   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x75,0xf5,0x65]
# CHECK-ERROR-NOT: fnmls   z21.d, p5/m, z10.d, z21.d 
