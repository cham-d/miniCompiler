
#include "mslib.h"
#include <math.h>

/* program */ 

int main() {
   double i, size, big;

	
double a[50];
	writeString("\nEnter the size of the array: ");
	size = readNumber();
	writeString("\n\nEnter the ");
	writeNumber(size);
	writeString(" elements of the array: \n\n");
	for (i = 0;i < size;i = i + 1)
		a[(int)i] = readNumber();
	big = a[0];
	for (i = 0;i < size;i = i + 1)
	{
	if (big < a[(int)i])
{
	big = a[(int)i];} }
	writeString("\n\nThe largest element is: ");
	writeNumber(big);
} 
//Accepted!
