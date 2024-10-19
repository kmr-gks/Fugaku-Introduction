program hdf5_example
  use hdf5
  implicit none

  ! 変数定義 (Specification statements)
  integer(hid_t) :: file_id      ! ファイル識別子
  integer(hid_t) :: dset_id      ! データセット識別子
  integer(hid_t) :: dataspace_id ! データスペース識別子
  integer :: status              ! ステータスコード

  integer, parameter :: rank = 1  ! データセットの次元数
  integer, dimension(4) :: data = (/ 1, 2, 3, 4 /)  ! 書き込むデータ
  integer(hsize_t), dimension(rank) :: dims = (/ 4 /) ! データセットの次元

  integer, dimension(4) :: read_data  ! 読み込み用の変数
  integer :: i

  ! 実行文 (Executable statements)

  ! HDF5ファイルの作成
  call h5open_f(status)  ! HDF5ライブラリの初期化
  call h5fcreate_f('example.h5', H5F_ACC_TRUNC_F, file_id, status)

  ! データスペースの作成（1次元配列）
  call h5screate_simple_f(rank, dims, dataspace_id, status)

  ! データセットの作成
  call h5dcreate_f(file_id, 'dset', H5T_NATIVE_INTEGER, dataspace_id, dset_id, status)

  ! データの書き込み
  call h5dwrite_f(dset_id, H5T_NATIVE_INTEGER, data, dims, status)

  ! リソースの解放
  call h5dclose_f(dset_id, status)
  call h5sclose_f(dataspace_id, status)
  call h5fclose_f(file_id, status)
  call h5close_f(status)  ! HDF5ライブラリの終了

  ! データの読み込み

  ! HDF5ファイルの再度オープン
  call h5open_f(status)
  call h5fopen_f('example.h5', H5F_ACC_RDONLY_F, file_id, status)

  ! データセットのオープン
  call h5dopen_f(file_id, 'dset', dset_id, status)

  ! データの読み込み
  call h5dread_f(dset_id, H5T_NATIVE_INTEGER, read_data, dims, status)

  ! 読み込んだデータを表示
  print *, 'Read data:'
  do i = 1, 4
     print *, read_data(i)
  end do

  ! リソースの解放
  call h5dclose_f(dset_id, status)
  call h5fclose_f(file_id, status)
  call h5close_f(status)

end program hdf5_example
