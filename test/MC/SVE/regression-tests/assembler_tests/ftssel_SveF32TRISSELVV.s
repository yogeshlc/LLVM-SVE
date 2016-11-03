// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftssel  z31.s, z31.s, z31.s  // 00000100-10111111-10110011-11111111
// CHECK: ftssel  z31.s, z31.s, z31.s // encoding: [0xff,0xb3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10110011-11111111
FTSSEL  Z31.S, Z31.S, Z31.S  // 00000100-10111111-10110011-11111111
// CHECK: ftssel  z31.s, z31.s, z31.s // encoding: [0xff,0xb3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10110011-11111111
ftssel  z0.s, z0.s, z0.s  // 00000100-10100000-10110000-00000000
// CHECK: ftssel  z0.s, z0.s, z0.s // encoding: [0x00,0xb0,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10110000-00000000
FTSSEL  Z0.S, Z0.S, Z0.S  // 00000100-10100000-10110000-00000000
// CHECK: ftssel  z0.s, z0.s, z0.s // encoding: [0x00,0xb0,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10110000-00000000
ftssel  z21.s, z10.s, z21.s  // 00000100-10110101-10110001-01010101
// CHECK: ftssel  z21.s, z10.s, z21.s // encoding: [0x55,0xb1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10110001-01010101
FTSSEL  Z21.S, Z10.S, Z21.S  // 00000100-10110101-10110001-01010101
// CHECK: ftssel  z21.s, z10.s, z21.s // encoding: [0x55,0xb1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10110001-01010101
ftssel  z23.s, z13.s, z8.s  // 00000100-10101000-10110001-10110111
// CHECK: ftssel  z23.s, z13.s, z8.s // encoding: [0xb7,0xb1,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10110001-10110111
FTSSEL  Z23.S, Z13.S, Z8.S  // 00000100-10101000-10110001-10110111
// CHECK: ftssel  z23.s, z13.s, z8.s // encoding: [0xb7,0xb1,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10110001-10110111
