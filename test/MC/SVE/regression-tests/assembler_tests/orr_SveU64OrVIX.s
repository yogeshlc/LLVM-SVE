// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orr     z0.s, z0.s, #0x1  // 00000101-00000000-00000000-00000000
// CHECK: orr     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-00000000-00000000
ORR     Z0.S, Z0.S, #0x1  // 00000101-00000000-00000000-00000000
// CHECK: orr     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-00000000-00000000
orr     z21.h, z21.h, #0xffc1  // 00000101-00000001-01010101-01010101
// CHECK: orr     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000001-01010101-01010101
ORR     Z21.H, Z21.H, #0xFFC1  // 00000101-00000001-01010101-01010101
// CHECK: orr     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000001-01010101-01010101
orr     z5.b, z5.b, #0x81  // 00000101-00000000-00001110-00100101
// CHECK: orr     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-00001110-00100101
ORR     Z5.B, Z5.B, #0x81  // 00000101-00000000-00001110-00100101
// CHECK: orr     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-00001110-00100101
orr     z23.h, z23.h, #0xfff9  // 00000101-00000000-11101101-10110111
// CHECK: orr     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-11101101-10110111
ORR     Z23.H, Z23.H, #0xFFF9  // 00000101-00000000-11101101-10110111
// CHECK: orr     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x00,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00000000-11101101-10110111
