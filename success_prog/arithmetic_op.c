#include <stdio.h>

int main() {
   	int a = 21;
   	int b = 10;
   	int c;

	c = a + b;
	printf("Value of c is %d\n", c);
	
	c = a - b;
	printf("Value of c is %d\n", c);
	
	c = a * b;
	printf("Value of c is %d\n", c);
	
	c = a / b;
	printf("Value of c is %d\n", c);
	
	c = a % b;
	printf("Value of c is %d\n", c);
	
	c = a ^ b;
	printf("Value of c is %d\n", c);
	
	c = a++; 
	printf("Value of c is %d\n", c);
	
	c = a--; 
	printf("Value of c is %d\n", c);
   
	return 0;
}
