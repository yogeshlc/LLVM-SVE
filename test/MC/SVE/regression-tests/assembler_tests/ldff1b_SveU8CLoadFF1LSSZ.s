// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1b  {z0.b}, p0/z, [x0, x0]  // 10100100-00000000-01100000-00000000
// CHECK: ldff1b  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x60,0x00,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00000000-01100000-00000000
LDFF1B  {Z0.B}, P0/Z, [X0, X0]  // 10100100-00000000-01100000-00000000
// CHECK: ldff1b  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x60,0x00,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00000000-01100000-00000000
ldff1b  {z31.b}, p7/z, [sp, xzr]  // 10100100-00011111-01111111-11111111
// CHECK: ldff1b  {z31.b}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0x1f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00011111-01111111-11111111
LDFF1B  {Z31.B}, P7/Z, [SP, XZR]  // 10100100-00011111-01111111-11111111
// CHECK: ldff1b  {z31.b}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0x1f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00011111-01111111-11111111
ldff1b  {z23.b}, p3/z, [x13, x8]  // 10100100-00001000-01101101-10110111
// CHECK: ldff1b  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0x08,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00001000-01101101-10110111
LDFF1B  {Z23.B}, P3/Z, [X13, X8]  // 10100100-00001000-01101101-10110111
// CHECK: ldff1b  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0x08,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00001000-01101101-10110111
ldff1b  {z21.b}, p5/z, [x10, x21]  // 10100100-00010101-01110101-01010101
// CHECK: ldff1b  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x75,0x15,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00010101-01110101-01010101
LDFF1B  {Z21.B}, P5/Z, [X10, X21]  // 10100100-00010101-01110101-01010101
// CHECK: ldff1b  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x75,0x15,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00010101-01110101-01010101
