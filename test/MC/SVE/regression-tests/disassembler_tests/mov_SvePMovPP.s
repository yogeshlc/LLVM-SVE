# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x7d,0x8f,0x25
# CHECK: mov     p15.b, p15.b // encoding: [0xef,0x7d,0x8f,0x25]
# CHECK-ERROR-NOT: mov     p15.b, p15.b 
0x00,0x40,0x80,0x25
# CHECK: mov     p0.b, p0.b // encoding: [0x00,0x40,0x80,0x25]
# CHECK-ERROR-NOT: mov     p0.b, p0.b 
