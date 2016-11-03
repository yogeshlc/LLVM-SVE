; RUN: llc -mtriple=aarch64 -O3 -sve-lower-gather-scatter-to-interleaved=true -mattr=+sve < %s | FileCheck %s
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks that the SVE post-vectorize pass can re-order scatters by sinking them
; below gathers to form scatter groups using alias analysis.
; In order to generate interleaved accesses it also requires that the GEPs are transformed
; from addressing using a struct type as the basis to instead use the first element type.

%struct.dcomplex = type { double, double }

@main.u1 = external hidden global [128 x %struct.dcomplex], align 8

; Function Attrs: nounwind
define void @test_reorder([128 x %struct.dcomplex]* nocapture %xout) unnamed_addr #1 {
; CHECK-LABEL: test_reorder:
entry:
  %y03 = alloca [128 x %struct.dcomplex], align 8
  %y14 = alloca [128 x %struct.dcomplex], align 8
  %wide.end.idx.splatinsert52 = insertelement <n x 2 x i64> undef, i64 42, i32 0
  %wide.end.idx.splat53 = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert52, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %vecidx = icmp ugt <n x 2 x i64> %wide.end.idx.splat53, seriesvector (i64 0, i64 1)
  br label %vector.ph

vector.ph:
  %scevgep62 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* @main.u1, i64 0, i64 0
  %scevgep63 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0
  %scevgep64 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* @main.u1, i64 0, i64 0, i32 1
  %scevgep65 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0, i32 1
  %predicate.entry54 = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %vecidx
  br label %vector.body

vector.body:
; CHECK: ld2d
; CHECK: st2d
  %index55 = phi i64 [ 0, %vector.ph ], [ %index.next68, %vector.body ]
  %predicate56 = phi <n x 2 x i1> [ %predicate.entry54, %vector.ph ], [ %predicate.next69, %vector.body ]
  %a13 = icmp ult i64 %index55, 4294967296
  call void @llvm.assume(i1 %a13)
  %a14 = seriesvector i64 %index55, 1 as <n x 2 x i64>
  %a15 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep62, <n x 2 x i64> %a14
  %a16 = bitcast <n x 2 x %struct.dcomplex*> %a15 to <n x 2 x i64*>
  %a17 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %a16, i32 8, <n x 2 x i1> %predicate56, <n x 2 x i64> undef), !tbaa !5
  %a18 = seriesvector i64 %index55, 1 as <n x 2 x i64>
  %a19 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep63, <n x 2 x i64> %a18
  %a20 = bitcast <n x 2 x %struct.dcomplex*> %a19 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %a17, <n x 2 x i64*> %a20, i32 8, <n x 2 x i1> %predicate56), !tbaa !5
  %a21 = shl nuw i64 %index55, 1
  %a22 = seriesvector i64 %a21, 2 as <n x 2 x i64>
  %a23 = getelementptr double, double* %scevgep64, <n x 2 x i64> %a22
  %a24 = bitcast <n x 2 x double*> %a23 to <n x 2 x i64*>
  %a25 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %a24, i32 8, <n x 2 x i1> %predicate56, <n x 2 x i64> undef), !tbaa !8
  %a26 = shl nuw i64 %index55, 1
  %a27 = seriesvector i64 %a26, 2 as <n x 2 x i64>
  %a28 = getelementptr double, double* %scevgep65, <n x 2 x i64> %a27
  %a29 = bitcast <n x 2 x double*> %a28 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %a25, <n x 2 x i64*> %a29, i32 8, <n x 2 x i1> %predicate56), !tbaa !8
  %index.next68 = add nuw nsw i64 %index55, elementcount (<n x 2 x i64> undef)
  %a30 = add nuw nsw i64 %index55, elementcount (<n x 2 x i64> undef)
  %a31 = seriesvector i64 %a30, 1 as <n x 2 x i64>
  %a32 = icmp ult <n x 2 x i64> %a31, %wide.end.idx.splat53
  %predicate.next69 = propff <n x 2 x i1> %predicate56, %a32
  %a33 = test first true <n x 2 x i1> %predicate.next69
  br i1 %a33, label %vector.body, label %vec.loopexit, !llvm.loop !9

vec.loopexit:
  br label %vec.ph2

vec.ph2:
  %wide.end.idx.splatinsert = insertelement <n x 2 x i64> undef, i64 42, i32 0
  %wide.end.idx.splat = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a41 = icmp ugt <n x 2 x i64> %wide.end.idx.splat, seriesvector (i64 0, i64 1)
  %scevgep = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0
  %scevgep40 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %xout, i64 0, i64 0
  %scevgep41 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0, i32 1
  %scevgep42 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %xout, i64 0, i64 0, i32 1
  %predicate.entry = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %a41
  br label %vector.body2

vector.body2:
; CHECK: ld2d
; CHECK: st2d
  %index = phi i64 [ 0, %vec.ph2 ], [ %index.next, %vector.body2 ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %vec.ph2 ], [ %predicate.next, %vector.body2 ]
  %a42 = icmp ult i64 %index, 4294967296
  call void @llvm.assume(i1 %a42)
  %a43 = seriesvector i64 %index, 1 as <n x 2 x i64>
  %a44 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep, <n x 2 x i64> %a43
  %a45 = bitcast <n x 2 x %struct.dcomplex*> %a44 to <n x 2 x i64*>
  %a46 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %a45, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef), !tbaa !5
  %a47 = seriesvector i64 %index, 1 as <n x 2 x i64>
  %a48 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep40, <n x 2 x i64> %a47
  %a49 = bitcast <n x 2 x %struct.dcomplex*> %a48 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %a46, <n x 2 x i64*> %a49, i32 8, <n x 2 x i1> %predicate), !tbaa !5
  %a50 = shl nuw i64 %index, 1
  %a51 = seriesvector i64 %a50, 2 as <n x 2 x i64>
  %a52 = getelementptr double, double* %scevgep41, <n x 2 x i64> %a51
  %a53 = bitcast <n x 2 x double*> %a52 to <n x 2 x i64*>
  %a54 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %a53, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef), !tbaa !8
  %a55 = shl nuw i64 %index, 1
  %a56 = seriesvector i64 %a55, 2 as <n x 2 x i64>
  %a57 = getelementptr double, double* %scevgep42, <n x 2 x i64> %a56
  %a58 = bitcast <n x 2 x double*> %a57 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %a54, <n x 2 x i64*> %a58, i32 8, <n x 2 x i1> %predicate), !tbaa !8
  %index.next = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %a59 = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %a60 = seriesvector i64 %a59, 1 as <n x 2 x i64>
  %a61 = icmp ult <n x 2 x i64> %a60, %wide.end.idx.splat
  %predicate.next = propff <n x 2 x i1> %predicate, %a61
  %a62 = test first true <n x 2 x i1> %predicate.next
  br i1 %a62, label %vector.body2, label %vec.loopexit2, !llvm.loop !12


vec.loopexit2:
  br label %end

end:
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #2

; Function Attrs: nounwind readonly
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>) #3

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>) #2

attributes #0 = { argmemonly nounwind }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !7, i64 0}
!6 = !{!"", !7, i64 0, !7, i64 8}
!7 = !{!"double", !3, i64 0}
!8 = !{!6, !7, i64 8}
!9 = distinct !{!9, !10, !11}
!10 = !{!"llvm.loop.vectorize.width", i32 1}
!11 = !{!"llvm.loop.interleave.count", i32 1}
!12 = distinct !{!12, !10, !11}
