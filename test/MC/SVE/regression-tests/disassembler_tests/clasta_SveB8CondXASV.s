# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x2a,0x05
# CHECK: clasta  b21, p5, b21, z10.b // encoding: [0x55,0x95,0x2a,0x05]
# CHECK-ERROR-NOT: clasta  b21, p5, b21, z10.b 
0x00,0x80,0x2a,0x05
# CHECK: clasta  b0, p0, b0, z0.b // encoding: [0x00,0x80,0x2a,0x05]
# CHECK-ERROR-NOT: clasta  b0, p0, b0, z0.b 
0xb7,0x8d,0x2a,0x05
# CHECK: clasta  b23, p3, b23, z13.b // encoding: [0xb7,0x8d,0x2a,0x05]
# CHECK-ERROR-NOT: clasta  b23, p3, b23, z13.b 
0xff,0x9f,0x2a,0x05
# CHECK: clasta  b31, p7, b31, z31.b // encoding: [0xff,0x9f,0x2a,0x05]
# CHECK-ERROR-NOT: clasta  b31, p7, b31, z31.b 
