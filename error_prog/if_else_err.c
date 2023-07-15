/* 
	Getting error, because "else" should be implemented after "if".
*/

#include <stdio.h>

int main() {
	int i = 2;
	
	else {
		printf("It's zero");
	}
	if (i > 0) {
		printf("It's positive");
	}
	else if (i < 0) {
		printf("it's negative");	
	}

	
	return 0;
}
