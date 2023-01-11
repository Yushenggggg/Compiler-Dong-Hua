
INT fac(INT x)
BEGIN
   INT z;
   IF (x == 1) z := 1;
   ELSE z := x * fac( x - 1 );
   RETURN z;
END
INT MAIN f()
BEGIN
   INT x;
   READ(x, "Input an integer value for x:");
   INT z;
   z := fac(x);
   WRITE(z, "fac(x) =");
END

