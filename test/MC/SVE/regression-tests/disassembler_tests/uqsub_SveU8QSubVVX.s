# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x1d,0x28,0x04
# CHECK: uqsub   z23.b, z13.b, z8.b // encoding: [0xb7,0x1d,0x28,0x04]
# CHECK-ERROR-NOT: uqsub   z23.b, z13.b, z8.b 
0xff,0x1f,0x3f,0x04
# CHECK: uqsub   z31.b, z31.b, z31.b // encoding: [0xff,0x1f,0x3f,0x04]
# CHECK-ERROR-NOT: uqsub   z31.b, z31.b, z31.b 
0x00,0x1c,0x20,0x04
# CHECK: uqsub   z0.b, z0.b, z0.b // encoding: [0x00,0x1c,0x20,0x04]
# CHECK-ERROR-NOT: uqsub   z0.b, z0.b, z0.b 
0x55,0x1d,0x35,0x04
# CHECK: uqsub   z21.b, z10.b, z21.b // encoding: [0x55,0x1d,0x35,0x04]
# CHECK-ERROR-NOT: uqsub   z21.b, z10.b, z21.b 
