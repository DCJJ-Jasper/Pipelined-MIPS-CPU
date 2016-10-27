#include <stdio.h>

extern int puts(const char *str);

// basic non-optimized recusive fibonacci generator
// int factorial1(int n)
// {
//    if ( n == 1 )
//       return 1;
//    else
//       return ( factorial1(n-1) * n );
// } 

int fool(int a, int b)
{
	if (a == 1)
		return (a & b) + (a | b) - a;
	else 
		return a * a;
} 


int main(void)
{
    char s[128]= {0};
    int f = fool(2,4);
    puts("Result is:");
    puts(itoa(f));
    puts("\n");


}
