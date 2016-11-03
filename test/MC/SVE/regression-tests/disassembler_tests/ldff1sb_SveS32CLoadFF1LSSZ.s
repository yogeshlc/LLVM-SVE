# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x75,0xb5,0xa5
# CHECK: ldff1sb {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x75,0xb5,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z21.s}, p5/z, [x10, x21] 
0xff,0x7f,0xbf,0xa5
# CHECK: ldff1sb {z31.s}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0xbf,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z31.s}, p7/z, [sp, xzr] 
0xb7,0x6d,0xa8,0xa5
# CHECK: ldff1sb {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0xa8,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z23.s}, p3/z, [x13, x8] 
0x00,0x60,0xa0,0xa5
# CHECK: ldff1sb {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x60,0xa0,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z0.s}, p0/z, [x0, x0] 
