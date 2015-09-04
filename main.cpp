#include <iostream>
#include <mpi.h>

int main(int argc, char **argv) {
  int rank, size;
  MPI_Init(&argc, &argv);

  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);

  for (int i = 0; i < size; i++) {
    if (i == rank) {
      std::cout << i << " ";
    }
    MPI_Barrier(MPI_COMM_WORLD);
  }
  if (rank == 0) {
    std::cout << std::endl;
  }

  MPI_Finalize();
  return 0;
}
