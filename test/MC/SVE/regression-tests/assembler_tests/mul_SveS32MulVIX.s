// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mul     z0.s, z0.s, #0  // 00100101-10110000-11000000-00000000
// CHECK: mul     z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11000000-00000000
MUL     Z0.S, Z0.S, #0  // 00100101-10110000-11000000-00000000
// CHECK: mul     z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11000000-00000000
mul     z31.s, z31.s, #-1  // 00100101-10110000-11011111-11111111
// CHECK: mul     z31.s, z31.s, #-1 // encoding: [0xff,0xdf,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11011111-11111111
MUL     Z31.S, Z31.S, #-1  // 00100101-10110000-11011111-11111111
// CHECK: mul     z31.s, z31.s, #-1 // encoding: [0xff,0xdf,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11011111-11111111
mul     z21.s, z21.s, #-86  // 00100101-10110000-11010101-01010101
// CHECK: mul     z21.s, z21.s, #-86 // encoding: [0x55,0xd5,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11010101-01010101
MUL     Z21.S, Z21.S, #-86  // 00100101-10110000-11010101-01010101
// CHECK: mul     z21.s, z21.s, #-86 // encoding: [0x55,0xd5,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11010101-01010101
mul     z23.s, z23.s, #109  // 00100101-10110000-11001101-10110111
// CHECK: mul     z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11001101-10110111
MUL     Z23.S, Z23.S, #109  // 00100101-10110000-11001101-10110111
// CHECK: mul     z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xb0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110000-11001101-10110111
