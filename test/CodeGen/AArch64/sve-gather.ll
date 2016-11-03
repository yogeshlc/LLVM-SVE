; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*>, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*>, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>)
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*>, i32, <n x 2 x i1>, <n x 2 x float>)
declare <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*>, i32, <n x 4 x i1>, <n x 4 x i8>)
declare <n x 4 x i16> @llvm.masked.gather.nxv4i16(<n x 4 x i16*>, i32, <n x 4 x i1>, <n x 4 x i16>)
declare <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*>, i32, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*>, i32, <n x 4 x i1>, <n x 4 x float>)

declare <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*>, i32, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 32 x i32> @llvm.masked.gather.nxv32i32(<n x 32 x i32*>, i32, <n x 32 x i1>, <n x 32 x i32>)

define <n x 2 x i8> @masked_gather_nxv2i8(i8* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2i8:
; CHECK: ld1sb {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  ret <n x 2 x i8> %data
}

define <n x 2 x i16> @masked_gather_nxv2i16(i16* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2i16:
; CHECK: ld1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]
; CHECK: ret
  %ptrs = getelementptr i16, i16* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  ret <n x 2 x i16> %data
}

define <n x 2 x i32> @masked_gather_nxv2i32(i32* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2i32:
; CHECK: ld1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  ret <n x 2 x i32> %data
}

define <n x 2 x i64> @masked_gather_nxv2i64(i64* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2i64:
; CHECK: ld1d  {z0.d}, p0/z, [x0, z0.d, sxtw #3]
; CHECK: ret
  %ptrs = getelementptr i64, i64* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  ret <n x 2 x i64> %data
}

define <n x 2 x float> @masked_gather_nxv2f32(float* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2f32:
; CHECK: ld1w {z0.d}, p0/z, [x0, z0.d, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr float, float* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  ret <n x 2 x float> %data
}

define <n x 2 x double> @masked_gather_nxv2f64(double* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv2f64:
; CHECK: ld1d  {z0.d}, p0/z, [x0, z0.d, sxtw #3]
; CHECK: ret
  %ptrs = getelementptr double, double* %base, <n x 2 x i32> %indices
  %data = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  ret <n x 2 x double> %data
}

define <n x 4 x i8> @masked_gather_nxv4i8(i8* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv4i8:
; CHECK: ld1sb {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 4 x i32> %indices
  %data = call <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  ret <n x 4 x i8> %data
}

define <n x 4 x i16> @masked_gather_nxv4i16(i16* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv4i16:
; CHECK: ld1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1]
; CHECK: ret
  %ptrs = getelementptr i16, i16* %base, <n x 4 x i32> %indices
  %data = call <n x 4 x i16> @llvm.masked.gather.nxv4i16(<n x 4 x i16*> %ptrs, i32 2, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  ret <n x 4 x i16> %data
}

define <n x 4 x i32> @masked_gather_nxv4i32(i32* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv4i32:
; CHECK: ld1w {z0.s}, p0/z, [x0, z0.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 4 x i32> %indices
  %data = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  ret <n x 4 x i32> %data
}

define <n x 4 x float> @masked_gather_nxv4f32(float* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv4f32:
; CHECK: ld1w {z0.s}, p0/z, [x0, z0.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr float, float* %base, <n x 4 x i32> %indices
  %data = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x float> undef)
  ret <n x 4 x float> %data
}

;;
;; As above but with unsigned indices.
;;

define <n x 2 x i8> @masked_gather_uxtw_nxv2i8(i8* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2i8:
; CHECK: ld1sb {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr i8, i8* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  ret <n x 2 x i8> %data
}

define <n x 2 x i16> @masked_gather_uxtw_nxv2i16(i16* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2i16:
; CHECK: ld1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  ret <n x 2 x i16> %data
}

define <n x 2 x i32> @masked_gather_uxtw_nxv2i32(i32* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2i32:
; CHECK: ld1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  ret <n x 2 x i32> %data
}

define <n x 2 x i64> @masked_gather_uxtw_nxv2i64(i64* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2i64:
; CHECK: ld1d  {z0.d}, p0/z, [x0, z0.d, uxtw #3]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr i64, i64* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  ret <n x 2 x i64> %data
}

define <n x 2 x float> @masked_gather_uxtw_nxv2f32(float* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2f32:
; CHECK: ld1w {z0.d}, p0/z, [x0, z0.d, uxtw #2]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr float, float* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  ret <n x 2 x float> %data
}

define <n x 2 x double> @masked_gather_uxtw_nxv2f64(double* %base, <n x 2 x i32> %indices, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv2f64:
; CHECK: ld1d  {z0.d}, p0/z, [x0, z0.d, uxtw #3]
; CHECK: ret
  %indices.uxtw = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %ptrs = getelementptr double, double* %base, <n x 2 x i64> %indices.uxtw
  %data = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  ret <n x 2 x double> %data
}

; TODO: placeholder for better code generation
define <n x 4 x i8> @masked_gather_uxtw_nxv4i8(i8* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv4i8:
; CHECK-TODO: ld1sb {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK: ret
  %indices.uxtw = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %ptrs = getelementptr i8, i8* %base, <n x 4 x i64> %indices.uxtw
  %data = call <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  ret <n x 4 x i8> %data
}

; TODO: placeholder for better code generation
define <n x 4 x i16> @masked_gather_uxtw_nxv4i16(i16* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv4i16:
; CHECK-TODO: ld1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1]
; CHECK: ret
  %indices.uxtw = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 4 x i64> %indices.uxtw
  %data = call <n x 4 x i16> @llvm.masked.gather.nxv4i16(<n x 4 x i16*> %ptrs, i32 2, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  ret <n x 4 x i16> %data
}

; TODO: placeholder for better code generation
define <n x 4 x i32> @masked_gather_uxtw_nxv4i32(i32* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv4i32:
; CHECK-TODO: ld1w {z0.s}, p0/z, [x0, z0.s, uxtw #2]
; CHECK: ret
  %indices.uxtw = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 4 x i64> %indices.uxtw
  %data = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  ret <n x 4 x i32> %data
}

; TODO: placeholder for better code generation
define <n x 4 x float> @masked_gather_uxtw_nxv4f32(float* %base, <n x 4 x i32> %indices, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_uxtw_nxv4f32:
; CHECK-TODO: ld1w {z0.s}, p0/z, [x0, z0.s, uxtw #2]
; CHECK: ret
  %indices.uxtw = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %ptrs = getelementptr float, float* %base, <n x 4 x i64> %indices.uxtw
  %data = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x float> undef)
  ret <n x 4 x float> %data
}

; Code generate the worst case scenario when all vector types are legal.
define <n x 16 x i8> @masked_gather_nxv16i8(i8* %base, <n x 16 x i8> %indices, <n x 16 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv16i8:
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 16 x i8> %indices
  %data = call <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  ret <n x 16 x i8> %data
}

; Code generate the worst case scenario when all vector types are illegal.
define <n x 32 x i32> @masked_gather_nxv32i32(i32* %base, <n x 32 x i32> %indices, <n x 32 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_nxv32i32:
; CHECK-NOT: unpkhi
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z0.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z1.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z2.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z3.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z4.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z5.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z6.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z7.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 32 x i32> %indices
  %data = call <n x 32 x i32> @llvm.masked.gather.nxv32i32(<n x 32 x i32*> %ptrs, i32 4, <n x 32 x i1> %mask, <n x 32 x i32> undef)
  ret <n x 32 x i32> %data
}

;;
;; Index a vector of pointers using a scalar index.
;;

define <n x 2 x i8> @masked_gather_scalar_idx_nxv2i8(<n x 2 x i8*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2i8:
; CHECK: ld1sb {z0.d}, p0/z, [x0, z0.d]
; CHECK: ret
  %ptrs = getelementptr i8, <n x 2 x i8*> %bases, i64 %index
  %data = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  ret <n x 2 x i8> %data
}

define <n x 2 x i16> @masked_gather_scalar_idx_nxv2i16(<n x 2 x i16*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2i16:
; CHECK: lsl x[[OFFSET:[0-9]+]], x0, #1
; CHECK: ld1sh {z0.d}, p0/z, [x[[OFFSET]], z0.d]
; CHECK: ret
  %ptrs = getelementptr i16, <n x 2 x i16*> %bases, i64 %index
  %data = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  ret <n x 2 x i16> %data
}

define <n x 2 x i32> @masked_gather_scalar_idx_nxv2i32(<n x 2 x i32*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2i32:
; CHECK: lsl x[[OFFSET:[0-9]+]], x0, #2
; CHECK: ld1sw {z0.d}, p0/z, [x[[OFFSET]], z0.d]
; CHECK: ret
  %ptrs = getelementptr i32, <n x 2 x i32*> %bases, i64 %index
  %data = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  ret <n x 2 x i32> %data
}

define <n x 2 x i64> @masked_gather_scalar_idx_nxv2i64(<n x 2 x i64*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2i64:
; CHECK: lsl x[[OFFSET:[0-9]+]], x0, #3
; CHECK: ld1d {z0.d}, p0/z, [x[[OFFSET]], z0.d]
; CHECK: ret
  %ptrs = getelementptr i64, <n x 2 x i64*> %bases, i64 %index
  %data = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  ret <n x 2 x i64> %data
}

define <n x 2 x float> @masked_gather_scalar_idx_nxv2f32(<n x 2 x float*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2f32:
; CHECK: lsl x[[OFFSET:[0-9]+]], x0, #2
; CHECK: ld1w {z0.d}, p0/z, [x[[OFFSET]], z0.d]
; CHECK: ret
  %ptrs = getelementptr float, <n x 2 x float*> %bases, i64 %index
  %data = call <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  ret <n x 2 x float> %data
}

define <n x 2 x double> @masked_gather_scalar_idx_nxv2f64(<n x 2 x double*> %bases, i64 %index, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_gather_scalar_idx_nxv2f64:
; CHECK: lsl x[[OFFSET:[0-9]+]], x0, #3
; CHECK: ld1d {z0.d}, p0/z, [x[[OFFSET]], z0.d]
; CHECK: ret
  %ptrs = getelementptr double, <n x 2 x double*> %bases, i64 %index
  %data = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  ret <n x 2 x double> %data
}
