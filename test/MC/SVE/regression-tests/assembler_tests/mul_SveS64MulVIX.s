// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mul     z31.d, z31.d, #-1  // 00100101-11110000-11011111-11111111
// CHECK: mul     z31.d, z31.d, #-1 // encoding: [0xff,0xdf,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11011111-11111111
MUL     Z31.D, Z31.D, #-1  // 00100101-11110000-11011111-11111111
// CHECK: mul     z31.d, z31.d, #-1 // encoding: [0xff,0xdf,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11011111-11111111
mul     z21.d, z21.d, #-86  // 00100101-11110000-11010101-01010101
// CHECK: mul     z21.d, z21.d, #-86 // encoding: [0x55,0xd5,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11010101-01010101
MUL     Z21.D, Z21.D, #-86  // 00100101-11110000-11010101-01010101
// CHECK: mul     z21.d, z21.d, #-86 // encoding: [0x55,0xd5,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11010101-01010101
mul     z0.d, z0.d, #0  // 00100101-11110000-11000000-00000000
// CHECK: mul     z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11000000-00000000
MUL     Z0.D, Z0.D, #0  // 00100101-11110000-11000000-00000000
// CHECK: mul     z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11000000-00000000
mul     z23.d, z23.d, #109  // 00100101-11110000-11001101-10110111
// CHECK: mul     z23.d, z23.d, #109 // encoding: [0xb7,0xcd,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11001101-10110111
MUL     Z23.D, Z23.D, #109  // 00100101-11110000-11001101-10110111
// CHECK: mul     z23.d, z23.d, #109 // encoding: [0xb7,0xcd,0xf0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110000-11001101-10110111
