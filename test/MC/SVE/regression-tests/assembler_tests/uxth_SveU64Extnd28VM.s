// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uxth    z21.d, p5/m, z10.d  // 00000100-11010011-10110101-01010101
// CHECK: uxth    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10110101-01010101
UXTH    Z21.D, P5/M, Z10.D  // 00000100-11010011-10110101-01010101
// CHECK: uxth    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10110101-01010101
uxth    z23.d, p3/m, z13.d  // 00000100-11010011-10101101-10110111
// CHECK: uxth    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10101101-10110111
UXTH    Z23.D, P3/M, Z13.D  // 00000100-11010011-10101101-10110111
// CHECK: uxth    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10101101-10110111
uxth    z0.d, p0/m, z0.d  // 00000100-11010011-10100000-00000000
// CHECK: uxth    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10100000-00000000
UXTH    Z0.D, P0/M, Z0.D  // 00000100-11010011-10100000-00000000
// CHECK: uxth    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10100000-00000000
uxth    z31.d, p7/m, z31.d  // 00000100-11010011-10111111-11111111
// CHECK: uxth    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10111111-11111111
UXTH    Z31.D, P7/M, Z31.D  // 00000100-11010011-10111111-11111111
// CHECK: uxth    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010011-10111111-11111111
