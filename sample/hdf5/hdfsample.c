#include <hdf5.h>
#include <stdio.h>

#define FILE_NAME "sample.h5"
#define DATASET_NAME "dset"
#define DIM0 4 // データセットの次元

int main() {
    // ファイルとデータセットの識別子
    hid_t file_id, dataset_id, dataspace_id;
    herr_t status;

    // データセットに書き込むデータ
    int data[DIM0] = {1, 2, 3, 4};

    // データスペースの次元
    hsize_t dims[1] = {DIM0};

    // HDF5ファイルを作成
    file_id = H5Fcreate(FILE_NAME, H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);

    // データスペースを作成 (1次元)
    dataspace_id = H5Screate_simple(1, dims, NULL);

    // データセットを作成
    dataset_id = H5Dcreate2(file_id, DATASET_NAME, H5T_NATIVE_INT, dataspace_id,
                            H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);

    // データセットにデータを書き込む
    status = H5Dwrite(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT, data);

    // リソースの解放
    status = H5Dclose(dataset_id);
    status = H5Sclose(dataspace_id);
    status = H5Fclose(file_id);

    // データを読み込む
    int read_data[DIM0];

    // ファイルを開く
    file_id = H5Fopen(FILE_NAME, H5F_ACC_RDONLY, H5P_DEFAULT);

    // データセットを開く
    dataset_id = H5Dopen2(file_id, DATASET_NAME, H5P_DEFAULT);

    // データセットからデータを読み込む
    status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT, read_data);

    // 読み込んだデータを表示
    printf("Read data: ");
    for (int i = 0; i < DIM0; i++) {
        printf("%d ", read_data[i]);
    }
    printf("\n");

    // リソースの解放
    status = H5Dclose(dataset_id);
    status = H5Fclose(file_id);

    return 0;
}