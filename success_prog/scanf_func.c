#include <stdio.h>

int main() {
	int a, b, c;
	printf("Enter three angle to check:\n");
	scanf("%d %d %d" &a, &b, &c);
	
	if (a + b + c == 180) {
		printf("It's an triangle");
	} else {
		printf("It's not an triangle");
	}
	return 0;
}
