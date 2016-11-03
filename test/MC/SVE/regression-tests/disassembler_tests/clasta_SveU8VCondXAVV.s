# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x28,0x05
# CHECK: clasta  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x28,0x05]
# CHECK-ERROR-NOT: clasta  z0.b, p0, z0.b, z0.b 
0xff,0x9f,0x28,0x05
# CHECK: clasta  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x28,0x05]
# CHECK-ERROR-NOT: clasta  z31.b, p7, z31.b, z31.b 
0xb7,0x8d,0x28,0x05
# CHECK: clasta  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x28,0x05]
# CHECK-ERROR-NOT: clasta  z23.b, p3, z23.b, z13.b 
0x55,0x95,0x28,0x05
# CHECK: clasta  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x28,0x05]
# CHECK-ERROR-NOT: clasta  z21.b, p5, z21.b, z10.b 
