; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Strided Gather Loads/Scatter Stores - nx4xT with seriesvector of addresses

declare <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*>, i32, <n x 4 x i1>, <n x 4 x i8>)
declare <n x 4 x i16> @llvm.masked.gather.nxv4i16(<n x 4 x i16*>, i32, <n x 4 x i1>, <n x 4 x i16>)
declare void @llvm.masked.scatter.nxv4i8(<n x 4 x i8>, <n x 4 x i8*>,  i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4i16(<n x 4 x i16>, <n x 4 x i16*>,  i32, <n x 4 x i1>)

;; Split nxv4i64 load/store index vector into 2 x nxv2i64

define void @masked_gather_scatter_series_nxv4i8_offset_i64(i8* %a) {
; CHECK-LABEL: masked_gather_scatter_series_nxv4i8_offset_i64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: rdvl  [[VL:x[0-9]+]], #1
; CHECK-DAG: index [[IDX0:z[0-9]+]].d, #0, #7
; CHECK-DAG: decd  [[VL]]
; CHECK-DAG: index [[IDX1:z[0-9]+]].d, [[VL]], #7
; CHECK-DAG: ld1sb {[[LD0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x0, [[IDX0]].d]
; CHECK-DAG: ld1sb {[[LD1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x0, [[IDX1]].d]
; CHECK-DAG: uzp1  [[ZP:z[0-9]+]].s, [[LD0]].s, [[LD1]].s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, [[ZP]].s
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, [[ZP]].s
; CHECK-DAG: st1b  {[[LO]].d}, {{p[0-9]+}}, [x0, [[IDX0]].d]
; CHECK-DAG: st1b  {[[HI]].d}, {{p[0-9]+}}, [x0, [[IDX1]].d]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i8 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i8> zeroinitializer

  %sv = seriesvector i64 0, 7 as <n x 4 x i64>
  %ptrs = getelementptr i8, i8* %a, <n x 4 x i64> %sv
  %in_vals = call <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %out_vals = add <n x 4 x i8> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv4i8(<n x 4 x i8> %out_vals, <n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_series_nxv4i16_offset_i64(i16* %a) {
; CHECK-LABEL: masked_gather_scatter_series_nxv4i16_offset_i64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: rdvl  [[VL:x[0-9]+]], #1
; CHECK-DAG: orr   [[STEP:x[0-9]+]], xzr, #0x100000000
; CHECK-DAG: index [[IDX0:z[0-9]+]].d, #0, [[STEP]]
; CHECK-DAG: lsl   [[START:x[0-9]+]], [[VL]], #29
; CHECK-DAG: index [[IDX1:z[0-9]+]].d, [[START]]
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [x0, [[IDX0]].d, lsl #1]
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [x0, [[IDX1]].d, lsl #1]
; CHECK-DAG: uzp1  [[ZP:z[0-9]+]].s, [[LD0]].s, [[LD1]].s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, [[ZP]].s
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, [[ZP]].s
; CHECK-DAG: st1h  {[[LO]].d}, {{p[0-9]+}}, [x0, [[IDX0]].d, lsl #1]
; CHECK-DAG: st1h  {[[HI]].d}, {{p[0-9]+}}, [x0, [[IDX1]].d, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i16 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i16> zeroinitializer

  %sv = seriesvector i64 0, 4294967296 as <n x 4 x i64>
  %ptrs = getelementptr i16, i16* %a, <n x 4 x i64> %sv
  %in_vals = call <n x 4 x i16> @llvm.masked.gather.nxv4i16(<n x 4 x i16*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %out_vals = add <n x 4 x i16> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv4i16(<n x 4 x i16> %out_vals, <n x 4 x i16*> %ptrs, i32 1, <n x 4 x i1> %mask)
  ret void
}
