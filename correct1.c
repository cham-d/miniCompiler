
#include "mslib.h"
#include <math.h>

/* program */ 


void fibonacci(double num)
{
double a, b, c, i=3;

	a = 0;
	b = 1;
	if (num == 1)
	writeNumber(a); 
	if (2 <= num)
{
	writeNumber(a);
	writeString("\t");
	writeNumber(b);} 
	while (i <= num)
{
	c = a + b;
	writeString("\t");
	writeNumber(c);
	a = b;
	b = c;
	i = i + 1;}
}

int main() {
   double num;

	writeString("Enter number of terms\t");
	num = readNumber();
	fibonacci(num);
} 
//Accepted!
