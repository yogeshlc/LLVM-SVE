// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
eor     z0.d, z0.d, z0.d  // 00000100-10100000-00110000-00000000
// CHECK: eor     z0.d, z0.d, z0.d // encoding: [0x00,0x30,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00110000-00000000
EOR     Z0.D, Z0.D, Z0.D  // 00000100-10100000-00110000-00000000
// CHECK: eor     z0.d, z0.d, z0.d // encoding: [0x00,0x30,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00110000-00000000
eor     z31.d, z31.d, z31.d  // 00000100-10111111-00110011-11111111
// CHECK: eor     z31.d, z31.d, z31.d // encoding: [0xff,0x33,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00110011-11111111
EOR     Z31.D, Z31.D, Z31.D  // 00000100-10111111-00110011-11111111
// CHECK: eor     z31.d, z31.d, z31.d // encoding: [0xff,0x33,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00110011-11111111
eor     z21.d, z10.d, z21.d  // 00000100-10110101-00110001-01010101
// CHECK: eor     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00110001-01010101
EOR     Z21.D, Z10.D, Z21.D  // 00000100-10110101-00110001-01010101
// CHECK: eor     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00110001-01010101
eor     z23.d, z13.d, z8.d  // 00000100-10101000-00110001-10110111
// CHECK: eor     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00110001-10110111
EOR     Z23.D, Z13.D, Z8.D  // 00000100-10101000-00110001-10110111
// CHECK: eor     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00110001-10110111
