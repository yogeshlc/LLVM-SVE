// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1sb {z21.d}, p5/z, [z10.d, #21]  // 11000100-00110101-10110101-01010101
// CHECK: ldff1sb {z21.d}, p5/z, [z10.d, #21] // encoding: [0x55,0xb5,0x35,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00110101-10110101-01010101
LDFF1SB {Z21.D}, P5/Z, [Z10.D, #21]  // 11000100-00110101-10110101-01010101
// CHECK: ldff1sb {z21.d}, p5/z, [z10.d, #21] // encoding: [0x55,0xb5,0x35,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00110101-10110101-01010101
ldff1sb {z23.d}, p3/z, [z13.d, #8]  // 11000100-00101000-10101101-10110111
// CHECK: ldff1sb {z23.d}, p3/z, [z13.d, #8] // encoding: [0xb7,0xad,0x28,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00101000-10101101-10110111
LDFF1SB {Z23.D}, P3/Z, [Z13.D, #8]  // 11000100-00101000-10101101-10110111
// CHECK: ldff1sb {z23.d}, p3/z, [z13.d, #8] // encoding: [0xb7,0xad,0x28,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00101000-10101101-10110111
ldff1sb {z31.d}, p7/z, [z31.d, #31]  // 11000100-00111111-10111111-11111111
// CHECK: ldff1sb {z31.d}, p7/z, [z31.d, #31] // encoding: [0xff,0xbf,0x3f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00111111-10111111-11111111
LDFF1SB {Z31.D}, P7/Z, [Z31.D, #31]  // 11000100-00111111-10111111-11111111
// CHECK: ldff1sb {z31.d}, p7/z, [z31.d, #31] // encoding: [0xff,0xbf,0x3f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00111111-10111111-11111111
ldff1sb {z0.d}, p0/z, [z0.d]  // 11000100-00100000-10100000-00000000
// CHECK: ldff1sb {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0x20,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00100000-10100000-00000000
LDFF1SB {Z0.D}, P0/Z, [Z0.D]  // 11000100-00100000-10100000-00000000
// CHECK: ldff1sb {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0x20,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00100000-10100000-00000000
