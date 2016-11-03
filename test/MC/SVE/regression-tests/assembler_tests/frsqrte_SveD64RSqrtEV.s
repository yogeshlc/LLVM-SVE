// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frsqrte z21.d, z10.d  // 01100101-11001111-00110001-01010101
// CHECK: frsqrte z21.d, z10.d // encoding: [0x55,0x31,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110001-01010101
FRSQRTE Z21.D, Z10.D  // 01100101-11001111-00110001-01010101
// CHECK: frsqrte z21.d, z10.d // encoding: [0x55,0x31,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110001-01010101
frsqrte z23.d, z13.d  // 01100101-11001111-00110001-10110111
// CHECK: frsqrte z23.d, z13.d // encoding: [0xb7,0x31,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110001-10110111
FRSQRTE Z23.D, Z13.D  // 01100101-11001111-00110001-10110111
// CHECK: frsqrte z23.d, z13.d // encoding: [0xb7,0x31,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110001-10110111
frsqrte z0.d, z0.d  // 01100101-11001111-00110000-00000000
// CHECK: frsqrte z0.d, z0.d // encoding: [0x00,0x30,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110000-00000000
FRSQRTE Z0.D, Z0.D  // 01100101-11001111-00110000-00000000
// CHECK: frsqrte z0.d, z0.d // encoding: [0x00,0x30,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110000-00000000
frsqrte z31.d, z31.d  // 01100101-11001111-00110011-11111111
// CHECK: frsqrte z31.d, z31.d // encoding: [0xff,0x33,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110011-11111111
FRSQRTE Z31.D, Z31.D  // 01100101-11001111-00110011-11111111
// CHECK: frsqrte z31.d, z31.d // encoding: [0xff,0x33,0xcf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001111-00110011-11111111
