# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xe0,0x05
# CHECK: lasta   x23, p3, z13.d // encoding: [0xb7,0xad,0xe0,0x05]
# CHECK-ERROR-NOT: lasta   x23, p3, z13.d 
0x55,0xb5,0xe0,0x05
# CHECK: lasta   x21, p5, z10.d // encoding: [0x55,0xb5,0xe0,0x05]
# CHECK-ERROR-NOT: lasta   x21, p5, z10.d 
0x00,0xa0,0xe0,0x05
# CHECK: lasta   x0, p0, z0.d // encoding: [0x00,0xa0,0xe0,0x05]
# CHECK-ERROR-NOT: lasta   x0, p0, z0.d 
0xff,0xbf,0xe0,0x05
# CHECK: lasta   xzr, p7, z31.d // encoding: [0xff,0xbf,0xe0,0x05]
# CHECK-ERROR-NOT: lasta   xzr, p7, z31.d 
