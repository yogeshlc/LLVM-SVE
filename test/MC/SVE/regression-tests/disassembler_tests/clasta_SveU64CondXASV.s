# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xf0,0x05
# CHECK: clasta  x23, p3, x23, z13.d // encoding: [0xb7,0xad,0xf0,0x05]
# CHECK-ERROR-NOT: clasta  x23, p3, x23, z13.d 
0x00,0xa0,0xf0,0x05
# CHECK: clasta  x0, p0, x0, z0.d // encoding: [0x00,0xa0,0xf0,0x05]
# CHECK-ERROR-NOT: clasta  x0, p0, x0, z0.d 
0xff,0xbf,0xf0,0x05
# CHECK: clasta  xzr, p7, xzr, z31.d // encoding: [0xff,0xbf,0xf0,0x05]
# CHECK-ERROR-NOT: clasta  xzr, p7, xzr, z31.d 
0x55,0xb5,0xf0,0x05
# CHECK: clasta  x21, p5, x21, z10.d // encoding: [0x55,0xb5,0xf0,0x05]
# CHECK-ERROR-NOT: clasta  x21, p5, x21, z10.d 
