; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @andnot_to_bic_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: andnot_to_bic_i8:
; CHECK-NOT: and z
; CHECK-NOT: eor z
; CHECK: bic z0.d, z0.d, z1.d
; CHECK: ret
  %allones = seriesvector i8 -1, 0 as <n x 16 x i8>
  %inv_b = xor <n x 16 x i8> %b, %allones
  %res = and <n x 16 x i8> %a, %inv_b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @andnot_to_bic_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: andnot_to_bic_i16:
; CHECK-NOT: and z
; CHECK-NOT: eor z
; CHECK: bic z0.d, z0.d, z1.d
; CHECK: ret
  %allones = seriesvector i16 -1, 0 as <n x 8 x i16>
  %inv_b = xor <n x 8 x i16> %b, %allones
  %res = and <n x 8 x i16> %a, %inv_b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @andnot_to_bic_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: andnot_to_bic_i32:
; CHECK-NOT: and z
; CHECK-NOT: eor z
; CHECK: bic z0.d, z0.d, z1.d
; CHECK: ret
  %allones = seriesvector i32 -1, 0 as <n x 4 x i32>
  %inv_b = xor <n x 4 x i32> %b, %allones
  %res = and <n x 4 x i32> %a, %inv_b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @andnot_to_bic_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: andnot_to_bic_i64:
; CHECK-NOT: and z
; CHECK-NOT: eor z
; CHECK: bic z0.d, z0.d, z1.d
; CHECK: ret
  %allones = seriesvector i64 -1, 0 as <n x 2 x i64>
  %inv_b = xor <n x 2 x i64> %b, %allones
  %res = and <n x 2 x i64> %a, %inv_b
  ret <n x 2 x i64> %res
}

