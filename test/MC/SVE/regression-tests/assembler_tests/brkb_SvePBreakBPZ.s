// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkb    p5.b, p5/z, p10.b  // 00100101-10010000-01010101-01000101
// CHECK: brkb    p5.b, p5/z, p10.b // encoding: [0x45,0x55,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01010101-01000101
BRKB    P5.B, P5/Z, P10.B  // 00100101-10010000-01010101-01000101
// CHECK: brkb    p5.b, p5/z, p10.b // encoding: [0x45,0x55,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01010101-01000101
brkb    p15.b, p15/z, p15.b  // 00100101-10010000-01111101-11101111
// CHECK: brkb    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01111101-11101111
BRKB    P15.B, P15/Z, P15.B  // 00100101-10010000-01111101-11101111
// CHECK: brkb    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01111101-11101111
brkb    p0.b, p0/z, p0.b  // 00100101-10010000-01000000-00000000
// CHECK: brkb    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01000000-00000000
BRKB    P0.B, P0/Z, P0.B  // 00100101-10010000-01000000-00000000
// CHECK: brkb    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01000000-00000000
brkb    p7.b, p11/z, p13.b  // 00100101-10010000-01101101-10100111
// CHECK: brkb    p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01101101-10100111
BRKB    P7.B, P11/Z, P13.B  // 00100101-10010000-01101101-10100111
// CHECK: brkb    p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0x90,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010000-01101101-10100111
