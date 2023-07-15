/* 
	Getting error, because there's extra ";" after "i++"
	and that is illegal to do.
*/

#include <stdio.h>

int main() {
	int i;
	
	for (i = 0; i < 5; i++;) {
		printf("Hello world!");
	} 
	
	return 0;	
}
