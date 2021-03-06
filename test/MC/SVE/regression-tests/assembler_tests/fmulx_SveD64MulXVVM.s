// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmulx   z31.d, p7/m, z31.d, z31.d  // 01100101-11001010-10011111-11111111
// CHECK: fmulx   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10011111-11111111
FMULX   Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11001010-10011111-11111111
// CHECK: fmulx   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10011111-11111111
fmulx   z21.d, p5/m, z21.d, z10.d  // 01100101-11001010-10010101-01010101
// CHECK: fmulx   z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10010101-01010101
FMULX   Z21.D, P5/M, Z21.D, Z10.D  // 01100101-11001010-10010101-01010101
// CHECK: fmulx   z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10010101-01010101
fmulx   z23.d, p3/m, z23.d, z13.d  // 01100101-11001010-10001101-10110111
// CHECK: fmulx   z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10001101-10110111
FMULX   Z23.D, P3/M, Z23.D, Z13.D  // 01100101-11001010-10001101-10110111
// CHECK: fmulx   z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10001101-10110111
fmulx   z0.d, p0/m, z0.d, z0.d  // 01100101-11001010-10000000-00000000
// CHECK: fmulx   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10000000-00000000
FMULX   Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11001010-10000000-00000000
// CHECK: fmulx   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xca,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001010-10000000-00000000
