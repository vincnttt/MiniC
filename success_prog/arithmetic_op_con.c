#include <stdio.h>

int main() {
	int a = 12;
	int b = 7;
	
	a += b;
	printf("Value of a is %d\n", a);
	
	a -= b;
	printf("Value of a is %d\n", a);
	
	a *= b;
	printf("Value of a is %d\n", a);
	
	a /= b;
	printf("Value of a is %d\n", a);
	
	a %= b;
	printf("Value of a is %d\n", a);
	
	a ^= b;
	printf("Value of a is %d\n", a);
	
	return 0;
}
