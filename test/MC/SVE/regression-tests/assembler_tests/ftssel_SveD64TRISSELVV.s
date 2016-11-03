// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftssel  z23.d, z13.d, z8.d  // 00000100-11101000-10110001-10110111
// CHECK: ftssel  z23.d, z13.d, z8.d // encoding: [0xb7,0xb1,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-10110001-10110111
FTSSEL  Z23.D, Z13.D, Z8.D  // 00000100-11101000-10110001-10110111
// CHECK: ftssel  z23.d, z13.d, z8.d // encoding: [0xb7,0xb1,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-10110001-10110111
ftssel  z0.d, z0.d, z0.d  // 00000100-11100000-10110000-00000000
// CHECK: ftssel  z0.d, z0.d, z0.d // encoding: [0x00,0xb0,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10110000-00000000
FTSSEL  Z0.D, Z0.D, Z0.D  // 00000100-11100000-10110000-00000000
// CHECK: ftssel  z0.d, z0.d, z0.d // encoding: [0x00,0xb0,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10110000-00000000
ftssel  z31.d, z31.d, z31.d  // 00000100-11111111-10110011-11111111
// CHECK: ftssel  z31.d, z31.d, z31.d // encoding: [0xff,0xb3,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-10110011-11111111
FTSSEL  Z31.D, Z31.D, Z31.D  // 00000100-11111111-10110011-11111111
// CHECK: ftssel  z31.d, z31.d, z31.d // encoding: [0xff,0xb3,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-10110011-11111111
ftssel  z21.d, z10.d, z21.d  // 00000100-11110101-10110001-01010101
// CHECK: ftssel  z21.d, z10.d, z21.d // encoding: [0x55,0xb1,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-10110001-01010101
FTSSEL  Z21.D, Z10.D, Z21.D  // 00000100-11110101-10110001-01010101
// CHECK: ftssel  z21.d, z10.d, z21.d // encoding: [0x55,0xb1,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-10110001-01010101
