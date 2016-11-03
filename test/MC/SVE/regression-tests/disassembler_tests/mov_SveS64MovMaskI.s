# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x80,0x19,0xc2,0x05
# CHECK: mov     z0.d, #0xe0000000000003ff // encoding: [0x80,0x19,0xc2,0x05]
# CHECK-ERROR-NOT: mov     z0.d, #0xe0000000000003ff 
0x21,0x84,0xc2,0x05
# CHECK: mov     z1.d, #0xffff00000003ffff // encoding: [0x21,0x84,0xc2,0x05]
# CHECK-ERROR-NOT: mov     z1.d, #0xffff00000003ffff 
