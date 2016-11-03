// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rb   {z21.d}, p5/z, [x10, #21]  // 10000100-01010101-11110101-01010101
// CHECK: ld1rb   {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0xf5,0x55,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01010101-11110101-01010101
LD1RB   {Z21.D}, P5/Z, [X10, #21]  // 10000100-01010101-11110101-01010101
// CHECK: ld1rb   {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0xf5,0x55,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01010101-11110101-01010101
ld1rb   {z0.d}, p0/z, [x0]  // 10000100-01000000-11100000-00000000
// CHECK: ld1rb   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01000000-11100000-00000000
LD1RB   {Z0.D}, P0/Z, [X0]  // 10000100-01000000-11100000-00000000
// CHECK: ld1rb   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01000000-11100000-00000000
ld1rb   {z31.d}, p7/z, [sp, #63]  // 10000100-01111111-11111111-11111111
// CHECK: ld1rb   {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0xff,0x7f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01111111-11111111-11111111
LD1RB   {Z31.D}, P7/Z, [SP, #63]  // 10000100-01111111-11111111-11111111
// CHECK: ld1rb   {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0xff,0x7f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01111111-11111111-11111111
ld1rb   {z23.d}, p3/z, [x13, #8]  // 10000100-01001000-11101101-10110111
// CHECK: ld1rb   {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0xed,0x48,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01001000-11101101-10110111
LD1RB   {Z23.D}, P3/Z, [X13, #8]  // 10000100-01001000-11101101-10110111
// CHECK: ld1rb   {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0xed,0x48,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01001000-11101101-10110111
