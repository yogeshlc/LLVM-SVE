// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mul     z31.b, z31.b, #-1  // 00100101-00110000-11011111-11111111
// CHECK: mul     z31.b, z31.b, #-1 // encoding: [0xff,0xdf,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11011111-11111111
MUL     Z31.B, Z31.B, #-1  // 00100101-00110000-11011111-11111111
// CHECK: mul     z31.b, z31.b, #-1 // encoding: [0xff,0xdf,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11011111-11111111
mul     z0.b, z0.b, #0  // 00100101-00110000-11000000-00000000
// CHECK: mul     z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11000000-00000000
MUL     Z0.B, Z0.B, #0  // 00100101-00110000-11000000-00000000
// CHECK: mul     z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11000000-00000000
mul     z23.b, z23.b, #109  // 00100101-00110000-11001101-10110111
// CHECK: mul     z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11001101-10110111
MUL     Z23.B, Z23.B, #109  // 00100101-00110000-11001101-10110111
// CHECK: mul     z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11001101-10110111
mul     z21.b, z21.b, #-86  // 00100101-00110000-11010101-01010101
// CHECK: mul     z21.b, z21.b, #-86 // encoding: [0x55,0xd5,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11010101-01010101
MUL     Z21.B, Z21.B, #-86  // 00100101-00110000-11010101-01010101
// CHECK: mul     z21.b, z21.b, #-86 // encoding: [0x55,0xd5,0x30,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110000-11010101-01010101
