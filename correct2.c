#include "mslib.h"
#include <math.h>

/* program */ 

const double a = 3; 
const double b = 4;
double d, e, f;

double arr1[100];

void dummy1(double  s[])
{

	s[1] = 2 * s[0];
	return;
} 
void dummy2(double  s[])
{
double i;

	s[9] = 1;
	for (i = 0;i < 10;i = i + 1)
		s[9] = s[9] * s[(int)i];
	return;
} 
void printArray(double  s[],double size)
{

double i;
double tmp;

	for (i = 0;i < size;i = i + 1)
	{
	tmp = s[(int)i];
	writeNumber(tmp);
	writeString("\n");}
} 
void foo(double num)
{
double foo_i;

	writeString("\nEnter the ");
	writeNumber(num);
	writeString(" elements of the array: \n\n");
	for (foo_i = 0;foo_i < num;foo_i = foo_i + 1)
	{
	writeString("element - ");
	writeNumber(foo_i + 1);
	writeString(" : ");
	arr1[(int)foo_i] = readNumber();}
	if (num <= 10)
	dummy1(arr1);
	else	dummy2(arr1); 
	writeString("Output:\n");
	printArray(arr1,num);
}

int main() {
   double num;

	writeString("Enter array size: \t");
	num = readNumber();
	foo(num);
} 
//Accepted!

