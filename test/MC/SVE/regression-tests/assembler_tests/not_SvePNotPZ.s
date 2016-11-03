// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
not     p5.b, p5/z, p10.b  // 00100101-00000101-01010111-01000101
// CHECK: not     p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x05,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01000101
NOT     P5.B, P5/Z, P10.B  // 00100101-00000101-01010111-01000101
// CHECK: not     p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x05,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01000101
not     p0.b, p0/z, p0.b  // 00100101-00000000-01000010-00000000
// CHECK: not     p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00000000
NOT     P0.B, P0/Z, P0.B  // 00100101-00000000-01000010-00000000
// CHECK: not     p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00000000
not     p15.b, p15/z, p15.b  // 00100101-00001111-01111111-11101111
// CHECK: not     p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x0f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11101111
NOT     P15.B, P15/Z, P15.B  // 00100101-00001111-01111111-11101111
// CHECK: not     p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x0f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11101111
