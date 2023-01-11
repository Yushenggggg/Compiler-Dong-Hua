#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void tiny_readint ( int *x, char *s ) {
  printf("%s ", s);
  scanf("%d", x);
}
void tiny_readreal ( float *x, char *s ) {
  printf("%s ", s);
  scanf("%f", x);
}
void tiny_readstr ( char *x, char *s ) {
  printf("%s ", s);
  scanf("%s", x);
}
void tiny_writeint ( int x, char *s ) {
  printf("%s ", s);
  printf("%d\n", x);
}
void tiny_writereal ( float x, char *s ) {
  printf("%s ", s);
  printf("%f\n", x);
}
void tiny_writestr ( char* x, char *s ) {
  printf("%s ", s);
  printf("%s\n", x);
}
int f2 ( int x, int y)
{ int z;
z = x * x - y * y;
return z;}
int main ( )
{ int x;
tiny_readint(&x, "A41.input");
int y;
tiny_readint(&y, "A42.input");
int z;
z = f2(x,y) + f2(y,x);
tiny_writeint(z, "A4.output");
}
