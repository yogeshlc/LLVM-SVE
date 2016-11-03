// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmeq   p7.d, p3/z, z13.d, #0.0  // 01100101-11010010-00101101-10100111
// CHECK: fcmeq   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xa7,0x2d,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00101101-10100111
FCMEQ   P7.D, P3/Z, Z13.D, #0.0  // 01100101-11010010-00101101-10100111
// CHECK: fcmeq   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xa7,0x2d,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00101101-10100111
fcmeq   p5.d, p5/z, z10.d, #0.0  // 01100101-11010010-00110101-01000101
// CHECK: fcmeq   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x45,0x35,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00110101-01000101
FCMEQ   P5.D, P5/Z, Z10.D, #0.0  // 01100101-11010010-00110101-01000101
// CHECK: fcmeq   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x45,0x35,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00110101-01000101
fcmeq   p0.d, p0/z, z0.d, #0.0  // 01100101-11010010-00100000-00000000
// CHECK: fcmeq   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x00,0x20,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00100000-00000000
FCMEQ   P0.D, P0/Z, Z0.D, #0.0  // 01100101-11010010-00100000-00000000
// CHECK: fcmeq   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x00,0x20,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00100000-00000000
fcmeq   p15.d, p7/z, z31.d, #0.0  // 01100101-11010010-00111111-11101111
// CHECK: fcmeq   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xef,0x3f,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00111111-11101111
FCMEQ   P15.D, P7/Z, Z31.D, #0.0  // 01100101-11010010-00111111-11101111
// CHECK: fcmeq   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xef,0x3f,0xd2,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010010-00111111-11101111
