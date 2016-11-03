// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
pnext   p5.s, p10, p5.s  // 00100101-10011001-11000101-01000101
// CHECK: pnext   p5.s, p10, p5.s // encoding: [0x45,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-01000101
PNEXT   P5.S, P10, P5.S  // 00100101-10011001-11000101-01000101
// CHECK: pnext   p5.s, p10, p5.s // encoding: [0x45,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-01000101
pnext   p0.s, p0, p0.s  // 00100101-10011001-11000100-00000000
// CHECK: pnext   p0.s, p0, p0.s // encoding: [0x00,0xc4,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000100-00000000
PNEXT   P0.S, P0, P0.S  // 00100101-10011001-11000100-00000000
// CHECK: pnext   p0.s, p0, p0.s // encoding: [0x00,0xc4,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000100-00000000
pnext   p7.s, p13, p7.s  // 00100101-10011001-11000101-10100111
// CHECK: pnext   p7.s, p13, p7.s // encoding: [0xa7,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-10100111
PNEXT   P7.S, P13, P7.S  // 00100101-10011001-11000101-10100111
// CHECK: pnext   p7.s, p13, p7.s // encoding: [0xa7,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-10100111
pnext   p15.s, p15, p15.s  // 00100101-10011001-11000101-11101111
// CHECK: pnext   p15.s, p15, p15.s // encoding: [0xef,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-11101111
PNEXT   P15.S, P15, P15.S  // 00100101-10011001-11000101-11101111
// CHECK: pnext   p15.s, p15, p15.s // encoding: [0xef,0xc5,0x99,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-11101111
