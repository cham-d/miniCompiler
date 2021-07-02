function fibonacci(num: number):  { //Efoson h synarthsh den epistrefei kati paraleipetai o typos epistrofhs
        var a,b,c,i=3:number;
        a=0;
        b=1;
        if(num == 1)
         writeNumber(a);

         if(2 <= num )
         { 
          writeNumber(a);
          writeString("\t");
          writeNumber(b);
        };
         while(i <= num)
        {
            c = a+b;
            writeString("\t");
            writeNumber(c);

            a = b;
            b = c;
            i=i+1;
        };
}

function start(): void {
        var num:number;
        writeString("Enter number of terms\t");
        num=readNumber();
        fibonacci(num);
}
