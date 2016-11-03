# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x41,0x25,0x05
# CHECK: zip1    p5.b, p10.b, p5.b // encoding: [0x45,0x41,0x25,0x05]
# CHECK-ERROR-NOT: zip1    p5.b, p10.b, p5.b 
0xa7,0x41,0x28,0x05
# CHECK: zip1    p7.b, p13.b, p8.b // encoding: [0xa7,0x41,0x28,0x05]
# CHECK-ERROR-NOT: zip1    p7.b, p13.b, p8.b 
0xef,0x41,0x2f,0x05
# CHECK: zip1    p15.b, p15.b, p15.b // encoding: [0xef,0x41,0x2f,0x05]
# CHECK-ERROR-NOT: zip1    p15.b, p15.b, p15.b 
0x00,0x40,0x20,0x05
# CHECK: zip1    p0.b, p0.b, p0.b // encoding: [0x00,0x40,0x20,0x05]
# CHECK-ERROR-NOT: zip1    p0.b, p0.b, p0.b 
