// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frinta  z0.d, p0/m, z0.d  // 01100101-11000100-10100000-00000000
// CHECK: frinta  z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10100000-00000000
FRINTA  Z0.D, P0/M, Z0.D  // 01100101-11000100-10100000-00000000
// CHECK: frinta  z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10100000-00000000
frinta  z21.d, p5/m, z10.d  // 01100101-11000100-10110101-01010101
// CHECK: frinta  z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10110101-01010101
FRINTA  Z21.D, P5/M, Z10.D  // 01100101-11000100-10110101-01010101
// CHECK: frinta  z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10110101-01010101
frinta  z31.d, p7/m, z31.d  // 01100101-11000100-10111111-11111111
// CHECK: frinta  z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10111111-11111111
FRINTA  Z31.D, P7/M, Z31.D  // 01100101-11000100-10111111-11111111
// CHECK: frinta  z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10111111-11111111
frinta  z23.d, p3/m, z13.d  // 01100101-11000100-10101101-10110111
// CHECK: frinta  z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10101101-10110111
FRINTA  Z23.D, P3/M, Z13.D  // 01100101-11000100-10101101-10110111
// CHECK: frinta  z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-10101101-10110111
