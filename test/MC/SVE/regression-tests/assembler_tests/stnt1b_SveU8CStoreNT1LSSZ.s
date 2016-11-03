// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
stnt1b  {z0.b}, p0, [x0, x0]  // 11100100-00000000-01100000-00000000
// CHECK: stnt1b  {z0.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-01100000-00000000
STNT1B  {Z0.B}, P0, [X0, X0]  // 11100100-00000000-01100000-00000000
// CHECK: stnt1b  {z0.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-01100000-00000000
stnt1b  {z5.b}, p3, [x17, x16]  // 11100100-00010000-01101110-00100101
// CHECK: stnt1b  {z5.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x10,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010000-01101110-00100101
STNT1B  {Z5.B}, P3, [X17, X16]  // 11100100-00010000-01101110-00100101
// CHECK: stnt1b  {z5.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x10,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010000-01101110-00100101
stnt1b  {z21.b}, p5, [x10, x21]  // 11100100-00010101-01110101-01010101
// CHECK: stnt1b  {z21.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x15,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010101-01110101-01010101
STNT1B  {Z21.B}, P5, [X10, X21]  // 11100100-00010101-01110101-01010101
// CHECK: stnt1b  {z21.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x15,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010101-01110101-01010101
stnt1b  {z23.b}, p3, [x13, x8]  // 11100100-00001000-01101101-10110111
// CHECK: stnt1b  {z23.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-01101101-10110111
STNT1B  {Z23.B}, P3, [X13, X8]  // 11100100-00001000-01101101-10110111
// CHECK: stnt1b  {z23.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-01101101-10110111
