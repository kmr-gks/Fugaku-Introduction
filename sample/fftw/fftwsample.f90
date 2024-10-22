program fft_example
  implicit none

  ! FFTWのヘッダーファイルをインクルード
  ! include 'fftw3.f'
  
  ! 型の宣言
  integer :: N, i
  real(8), dimension(:), allocatable :: inout
  integer(4) :: plan  ! fftw_plan の型は integer(8)

  ! インターフェース宣言（C関数をFortranで呼び出すために使用）
  interface
     function fftw_plan_dft_r2c_1d(n, in, out, flag) bind(C, name="fftw_plan_dft_r2c_1d")
       use, intrinsic :: iso_c_binding
       integer(c_int) :: fftw_plan_dft_r2c_1d
       integer(c_int), value :: n
       real(c_double), dimension(*) :: in
       real(c_double), dimension(*) :: out
       integer(c_int), value :: flag
     end function fftw_plan_dft_r2c_1d

     subroutine fftw_execute(plan) bind(C, name="fftw_execute")
       use, intrinsic :: iso_c_binding
       integer(c_int), value :: plan
     end subroutine fftw_execute

     subroutine fftw_destroy_plan(plan) bind(C, name="fftw_destroy_plan")
       use, intrinsic :: iso_c_binding
       integer(c_int), value :: plan
     end subroutine fftw_destroy_plan

     subroutine fftw_cleanup() bind(C, name="fftw_cleanup")
       use, intrinsic :: iso_c_binding
     end subroutine fftw_cleanup
  end interface

  ! フーリエ変換するデータのサイズを設定
  N = 8

  ! データ配列のメモリを確保
  allocate(inout(N))

  ! 入力データの初期化
  inout = [(i, i=1,N)]
  print *, "Input data:"
  print *, inout

  ! FFTWプランを作成 (r2c: real to complex)
  plan = fftw_plan_dft_r2c_1d(N, inout, inout, 64)  ! 64 = FFTW_ESTIMATE

  ! フーリエ変換を実行
  call fftw_execute(plan)

  ! 出力結果を表示
  print *, "Transformed data (complex output):"
  print *, inout

  ! FFTWプランを解放
  call fftw_destroy_plan(plan)

  ! メモリを解放
  call fftw_cleanup()

end program fft_example
