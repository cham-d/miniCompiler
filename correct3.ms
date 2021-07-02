//Programma pou ypologizei to mikrotero arithmo se ena monodiastato pinaka
function start(): void {
	var i,size,big :number;
	a[50]:number; 
	writeString("\nEnter the size of the array: ");
	size = readNumber();
	writeString("\n\nEnter the ");
	writeNumber(size);
        writeString(" elements of the array: \n\n");
	for (i=0;i<size;i=i+1)
		a[i]=readNumber();
	big=a[0];
	for (i=0;i<size;i=i+1)
	{
		if (big<a[i])
		{
			big=a[i];
		};
	};
	writeString("\n\nThe largest element is: ");
	writeNumber(big);
    
}

