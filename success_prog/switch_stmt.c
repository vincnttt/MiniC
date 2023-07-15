#include <stdio.h>

int main() {
	int month;
	printf("Enter month (1 to 12):\n");
	scanf("%d", &month);
	
	switch(month) {
		case 3:
		case 4:
		case 5:
			printf("This is spring");
			break;
		case 6:
		case 7:
		case 8:
			printf("This is summer");
			break;
		case 9:
		case 10:
		case 11:
			printf("This is autumn");
			break;
		case 12:
		case 1:
		case 2:
			printf("This is winter");
			break;
		default:
			printf("Invalid input");
	}
	return 0;
}
