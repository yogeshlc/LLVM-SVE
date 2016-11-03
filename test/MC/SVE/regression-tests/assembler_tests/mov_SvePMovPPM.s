// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     p15.b, p15/m, p15.b  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
MOV     P15.B, P15/M, P15.B  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
mov     p0.b, p0/m, p0.b  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
MOV     P0.B, P0/M, P0.B  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
mov     p5.b, p5/m, p10.b  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
MOV     P5.B, P5/M, P10.B  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
