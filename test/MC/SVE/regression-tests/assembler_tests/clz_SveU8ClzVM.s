// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clz     z23.b, p3/m, z13.b  // 00000100-00011001-10101101-10110111
// CHECK: clz     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10101101-10110111
CLZ     Z23.B, P3/M, Z13.B  // 00000100-00011001-10101101-10110111
// CHECK: clz     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10101101-10110111
clz     z21.b, p5/m, z10.b  // 00000100-00011001-10110101-01010101
// CHECK: clz     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10110101-01010101
CLZ     Z21.B, P5/M, Z10.B  // 00000100-00011001-10110101-01010101
// CHECK: clz     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10110101-01010101
clz     z0.b, p0/m, z0.b  // 00000100-00011001-10100000-00000000
// CHECK: clz     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10100000-00000000
CLZ     Z0.B, P0/M, Z0.B  // 00000100-00011001-10100000-00000000
// CHECK: clz     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10100000-00000000
clz     z31.b, p7/m, z31.b  // 00000100-00011001-10111111-11111111
// CHECK: clz     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10111111-11111111
CLZ     Z31.B, P7/M, Z31.B  // 00000100-00011001-10111111-11111111
// CHECK: clz     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x19,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011001-10111111-11111111
