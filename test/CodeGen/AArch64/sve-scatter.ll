; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare void @llvm.masked.scatter.nxv2i8(<n x 2 x i8>, <n x 2 x i8*>,  i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i16(<n x 2 x i16>, <n x 2 x i16*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i32(<n x 2 x i32>, <n x 2 x i32*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f32(<n x 2 x float>, <n x 2 x float*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>)

declare void @llvm.masked.scatter.nxv4i8(<n x 4 x i8>, <n x 4 x i8*>,  i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4i16(<n x 4 x i16>, <n x 4 x i16*>,  i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4i32(<n x 4 x i32>, <n x 4 x i32*>,  i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4f32(<n x 4 x float>, <n x 4 x float*>,  i32, <n x 4 x i1>)

declare void @llvm.masked.scatter.nxv16i8(<n x 16 x i8>, <n x 16 x i8*>,  i32, <n x 16 x i1>)
declare void @llvm.masked.scatter.nxv32i32(<n x 32 x i32>, <n x 32 x i32*>,  i32, <n x 32 x i1>)

define void @masked_scatter_nxv2i8(<n x 2 x i8> %data, i8* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2i8:
; CHECK: st1b  {z0.d}, p0, [x0, z1.d, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2i8(<n x 2 x i8> %data, <n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2i16(<n x 2 x i16> %data, i16* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2i16:
; CHECK: st1h {z0.d}, p0, [x0, z1.d, sxtw #1]
; CHECK: ret
  %ptrs = getelementptr i16, i16* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2i32(<n x 2 x i32> %data, i32* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2i32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2i64(<n x 2 x i64> %data, i64* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2i64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, sxtw #3]
; CHECK: ret
  %ptrs = getelementptr i64, i64* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %data, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2f32(<n x 2 x float> %data, float* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2f32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr float, float* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %data, <n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2f64(<n x 2 x double> %data, double* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv2f64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, sxtw #3]
; CHECK: ret
  %ptrs = getelementptr double, double* %base, <n x 2 x i32> %offsets
  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %data, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4i8(<n x 4 x i8> %data, i8* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv4i8:
; CHECK: st1b {z0.s}, p0, [x0, z1.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 4 x i32> %offsets
  call void @llvm.masked.scatter.nxv4i8(<n x 4 x i8> %data, <n x 4 x i8*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4i16(<n x 4 x i16> %data, i16* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv4i16:
; CHECK: st1h {z0.s}, p0, [x0, z1.s, sxtw #1]
; CHECK: ret
  %ptrs = getelementptr i16, i16* %base, <n x 4 x i32> %offsets
  call void @llvm.masked.scatter.nxv4i16(<n x 4 x i16> %data, <n x 4 x i16*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4i32(<n x 4 x i32> %data, i32* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv4i32:
; CHECK: st1w {z0.s}, p0, [x0, z1.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 4 x i32> %offsets
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %data, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4f32(<n x 4 x float> %data, float* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv4f32:
; CHECK: st1w {z0.s}, p0, [x0, z1.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr float, float* %base, <n x 4 x i32> %offsets
  call void @llvm.masked.scatter.nxv4f32(<n x 4 x float> %data, <n x 4 x float*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

;;
;; As above but with unsigned offsets.
;;

define void @masked_scatter_uxtw_nxv2i8(<n x 2 x i8> %data, i8* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2i8:
; CHECK: st1b  {z0.d}, p0, [x0, z1.d, uxtw]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i8, i8* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2i8(<n x 2 x i8> %data, <n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_uxtw_nxv2i16(<n x 2 x i16> %data, i16* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2i16:
; CHECK: st1h {z0.d}, p0, [x0, z1.d, uxtw #1]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_uxtw_nxv2i32(<n x 2 x i32> %data, i32* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2i32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, uxtw #2]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_uxtw_nxv2i64(<n x 2 x i64> %data, i64* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2i64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, uxtw #3]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i64, i64* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %data, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_uxtw_nxv2f32(<n x 2 x float> %data, float* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2f32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, uxtw #2]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr float, float* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %data, <n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_uxtw_nxv2f64(<n x 2 x double> %data, double* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv2f64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, uxtw #3]
; CHECK: ret
  %offsets.uxtw = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr double, double* %base, <n x 2 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %data, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

; TODO: placeholder for better code generation
define void @masked_scatter_uxtw_nxv4i8(<n x 4 x i8> %data, i8* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv4i8:
; CHECK-TODO: st1b {z0.s}, p0, [x0, z1.s, uxtw]
; CHECK: ret
  %offsets.uxtw = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr i8, i8* %base, <n x 4 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv4i8(<n x 4 x i8> %data, <n x 4 x i8*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

; TODO: placeholder for better code generation
define void @masked_scatter_uxtw_nxv4i16(<n x 4 x i16> %data, i16* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv4i16:
; CHECK-TODO: st1h {z0.s}, p0, [x0, z1.s, uxtw #1]
; CHECK: ret
  %offsets.uxtw = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 4 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv4i16(<n x 4 x i16> %data, <n x 4 x i16*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

; TODO: placeholder for better code generation
define void @masked_scatter_uxtw_nxv4i32(<n x 4 x i32> %data, i32* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv4i32:
; CHECK-TODO: st1w {z0.s}, p0, [x0, z1.s, uxtw #2]
; CHECK: ret
  %offsets.uxtw = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 4 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %data, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

; TODO: placeholder for better code generation
define void @masked_scatter_uxtw_nxv4f32(<n x 4 x float> %data, float* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_uxtw_nxv4f32:
; CHECK-TODO: st1w {z0.s}, p0, [x0, z1.s, uxtw #2]
; CHECK: ret
  %offsets.uxtw = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr float, float* %base, <n x 4 x i64> %offsets.uxtw
  call void @llvm.masked.scatter.nxv4f32(<n x 4 x float> %data, <n x 4 x float*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

; Code generate the worst case scenario when all vector types are legal.
define void @masked_scatter_nxv16i8(<n x 16 x i8> %data, i8* %base, <n x 16 x i8> %offsets, <n x 16 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv16i8:
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 16 x i8> %offsets
  call void @llvm.masked.scatter.nxv16i8(<n x 16 x i8> %data, <n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask)
  ret void
}

; Code generate the worst case scenario when all vector types are illegal.
define void @masked_scatter_nxv32i32(<n x 32 x i32> %data, i32* %base, <n x 32 x i32> %offsets, <n x 32 x i1> %mask) nounwind {
; CHECK-LABEL: masked_scatter_nxv32i32:
; CHECK-NOT: unpkhi
; CHECK-DAG: st1w {z0.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z1.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z2.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z3.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z4.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z5.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z6.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z7.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 32 x i32> %offsets
  call void @llvm.masked.scatter.nxv32i32(<n x 32 x i32> %data, <n x 32 x i32*> %ptrs, i32 4, <n x 32 x i1> %mask)
  ret void
}
