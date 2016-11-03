# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x39,0x24,0x05
# CHECK: insr    z23.b, w13 // encoding: [0xb7,0x39,0x24,0x05]
# CHECK-ERROR-NOT: insr    z23.b, w13 
0x00,0x38,0x24,0x05
# CHECK: insr    z0.b, w0 // encoding: [0x00,0x38,0x24,0x05]
# CHECK-ERROR-NOT: insr    z0.b, w0 
0xff,0x3b,0x24,0x05
# CHECK: insr    z31.b, wzr // encoding: [0xff,0x3b,0x24,0x05]
# CHECK-ERROR-NOT: insr    z31.b, wzr 
0x55,0x39,0x24,0x05
# CHECK: insr    z21.b, w10 // encoding: [0x55,0x39,0x24,0x05]
# CHECK-ERROR-NOT: insr    z21.b, w10 
