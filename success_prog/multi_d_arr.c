#include <stdio.h>
 
int main () {
   int arr[5][2] = {{0,0}, {1,2}, {2,4}, {3,6}, {4,8}};
   int i, j;
 
   for (i = 0; i < 5; i++) {
      for (j = 0; j < 2; j++) {
         printf("array[%d][%d] = %d\n", i,j, arr[i][j]);
      }
   }
   return 0;
}
