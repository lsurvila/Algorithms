#include <stdio.h>
#include <stdlib.h>

void printIntArray(int *array, int arraySize, const char *arrayName) {
    for (int i = 0; i < arraySize; i++) {
        printf("%s[%d] = %d ", arrayName, i, array[i]);
    }
    printf("\n");
}

void merge(int *A, int nA, int *B, int nB, int *C, int n) {
    int i, j, k;

    i = 0;
    j = 0;
    for (k = 0; k < n; k++) {

        // make sure we don't read split arrays out of bounds
        if (i < nA && j < nB) {

            // if element is smaller in first array, then put it to result array
            if (A[i] < B[j]) {
                C[k] = A[i];
                i++;
            // if element is smaller (or equal) in second array, then put it to result array
            } else if (B[j] <= A[i]) {
                C[k] = B[j];
                j++;
            }

        // if we are in situation where last element is remained
        } else {

            // if it's in first array
            if (i < nA) {
                C[k] = A[i];
                i++;
            }
            // if it's in second array
            if (j < nB) {
                C[k] = B[j];
                j++;
            }
        }

    }

}

void splitArray(int *C, int n, int *A, int *B, int mid) {
    int i;
    // fills first array
    for (i = 0; i < mid; i++) {
        A[i] = C[i];
    }
    // fills second array
    for (i = mid; i < n; i++) {
        B[i - mid] = C[i];
    }
}

void mergeSort(int *C, int n) {
    int *A, *B, nA, nB, mid;

    // if array size is less than 2 it's sorted already
    if (n < 2) {
        return;
    }

    // split array in two, if uneven count of elements, second array will be larger
    mid = n / 2;
    nA = mid;
    nB = n - nA;
    A = (int *) malloc(nA * sizeof(int));
    B = (int *) malloc(nB * sizeof(int));
    splitArray(C, n, A, B, mid);

    // recursively calling to split, sort and merge
    mergeSort(A, nA);
    mergeSort(B, nB);
    // split sorted arrays are merged into one sorted array
    merge(A, nA, B, nB, C, n);

    // free memory
    free(A);
    free(B);
}


void runMergeSort() {
    int C[9] = {5, 4, 1, 8, 7, 2, 6, 3};
    int n = sizeof(C) / sizeof(C[0]);

    printIntArray(C, n, "C");
    mergeSort(C, n);
    printIntArray(C, n, "C");

//    int n = 9;
//    int C[n];
//    int A[4] = { 1, 4, 6, 8 };
//    int B[5] = { -1, 1, 2, 5, 6 };
//    int nA = sizeof(A) / sizeof(A[0]);
//    int nB = sizeof(B) / sizeof(B[0]);
//
//    merge(A, nA, B, nB, C, n);
//    printIntArray(C, n, "C");
}

