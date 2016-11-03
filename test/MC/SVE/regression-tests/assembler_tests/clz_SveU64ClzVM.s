// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clz     z23.d, p3/m, z13.d  // 00000100-11011001-10101101-10110111
// CHECK: clz     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10101101-10110111
CLZ     Z23.D, P3/M, Z13.D  // 00000100-11011001-10101101-10110111
// CHECK: clz     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10101101-10110111
clz     z31.d, p7/m, z31.d  // 00000100-11011001-10111111-11111111
// CHECK: clz     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10111111-11111111
CLZ     Z31.D, P7/M, Z31.D  // 00000100-11011001-10111111-11111111
// CHECK: clz     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10111111-11111111
clz     z21.d, p5/m, z10.d  // 00000100-11011001-10110101-01010101
// CHECK: clz     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10110101-01010101
CLZ     Z21.D, P5/M, Z10.D  // 00000100-11011001-10110101-01010101
// CHECK: clz     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10110101-01010101
clz     z0.d, p0/m, z0.d  // 00000100-11011001-10100000-00000000
// CHECK: clz     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10100000-00000000
CLZ     Z0.D, P0/M, Z0.D  // 00000100-11011001-10100000-00000000
// CHECK: clz     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-10100000-00000000
