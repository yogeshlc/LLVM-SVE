; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*>, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*>, i32, <n x 4 x i1>, <n x 4 x i8>)

declare <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*>, i32, <n x 2 x i1>, <n x 2 x i16>)

declare <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>)

;; Check sign extends of gathers get folded away

define <n x 2 x i64> @masked_sgather_nxv2i8(<n x 2 x i8*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_sgather_nxv2i8:
; CHECK: ld1sb {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %svals = sext <n x 2 x i8> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}

;; TODO: Currently, the sign extend gets applied to the values after a 'uzp1' of two
;; registers, so it doesn't get folded away. Same for any other vector-of-pointers
;; style gathers which don't fit in an <n x 2 x type*> single register. Better folding
;; is required before we can check those off.
;; TODO: Implement tests for the other gathers when such folding is available.
define <n x 4 x i32> @masked_sgather_nxv4i8(<n x 4 x i8*> %ptrs, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_sgather_nxv4i8:
  %vals = call <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %svals = sext <n x 4 x i8> %vals to <n x 4 x i32>
  ret <n x 4 x i32> %svals
}

define <n x 2 x i64> @masked_sgather_nxv2i16(<n x 2 x i16*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_sgather_nxv2i16:
; CHECK: ld1sh {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %svals = sext <n x 2 x i16> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}

define <n x 2 x i64> @masked_sgather_nxv2i32(<n x 2 x i32*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_sgather_nxv2i32:
; CHECK: ld1sw {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %svals = sext <n x 2 x i32> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}

;; Check zero extends of gathers get folded away

define <n x 2 x i64> @masked_zgather_nxv2i8(<n x 2 x i8*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zgather_nxv2i8:
; CHECK: ld1b {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %svals = zext <n x 2 x i8> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}

define <n x 2 x i64> @masked_zgather_nxv2i16(<n x 2 x i16*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zgather_nxv2i16:
; CHECK: ld1h {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %svals = zext <n x 2 x i16> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}

define <n x 2 x i64> @masked_zgather_nxv2i32(<n x 2 x i32*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zgather_nxv2i32:
; CHECK: ld1w {z0.d}, p0/z, [z0.d]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %svals = zext <n x 2 x i32> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %svals
}
