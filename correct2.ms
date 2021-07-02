/*Programma to opoio den kaneio kati sygkekrimeno,apla anadeiknyei 
kapoia kommatia tou parser*/

//Prosoxh symfwname thn ekfwnhsh prwta dhlwnontai ta const kai meta ta var,alliws den ginetai dexto
const a=3:number; //An thelei kapoios na dhlwsei polles const ypoxrewtika tha prepei na tis dhlwsei se polles grammes,giati prepei na paroun timh
                //Tha mporouse na ftiaxtei kai me kommata opws to var,omws efoson h ekfwnhsh den prosdiorizei,epilexthke aytos o tropos
const b=4:number;
var d,e,f:number;

arr1[100]:number; //Efoson h ekfwnhsh den prosdiorizei thn thesh dhlwsh twn pinakwn,apofashsthke na dhlwnontai me ta tis var.


function dummy1(s[]: number): void
{
        s[1] = 2 * s[0];
        
        return ;
}


function dummy2(s[]: number): void
{       var i:number;
        s[9]=1;
        for (i=0;i<10;i=i+1)
        s[9] = s[9]*s[i];
        return ;
}


function printArray(s[]: number,size:number):void
{       var i:number;
        var tmp:number;
        for(i=0;i<size;i=i+1)
        {       tmp=s[i];
                writeNumber(tmp);
                writeString("\n");
        };
}


function foo(num: number):  { //Efoson h synarthsh den epistrefei kati paraleipetai o typos epistrofhs
        var foo_i:number;
        writeString("\nEnter the ");
	writeNumber(num);
        writeString(" elements of the array: \n\n");
        for(foo_i=0;foo_i<num;foo_i=foo_i+1)
         {
	  writeString("element - ");
          writeNumber(foo_i+1);
          writeString(" : ");
	 arr1[foo_i] = readNumber();
	 };
        if (num<=10)
                dummy1(arr1);
        else 
                dummy2(arr1);  
     
        writeString("Output:\n");
        printArray(arr1,num);
        
}


function start(): void {
        var num:number;
        writeString("Enter array size: \t");
        num=readNumber();
        foo(num);
}
