#include <stdio.h>

extern int puts(const char *str);

int fool(int a, int b)
{

	if (a == 1)
		return 1;
	else if (a & b)  // & the upper 1 bits : 8 & 4 = 1000 & 0100 = 0
		return (a * b);
	else if (a | b) 
		return (a + b);
	else 
		return (a - b);

} 


int main(void)
{
    char s[128]= {0};
    int f = fool(8,4);
    puts("Result is:");
    puts(itoa(f));
    puts("\n");


}
