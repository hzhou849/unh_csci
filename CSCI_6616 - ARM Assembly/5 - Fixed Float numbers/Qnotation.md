## Q2.2 Format Explanation:
Q2.2 format means:
Q2 (2 bits) for the integer part (to the left of the decimal point).
M2 (2 bits) for the fractional part (to the right of the decimal point).
So, we will represent numbers with 4 bits in total:
2 bits for the integer part.
2 bits for the fractional part.
Conversion Process for 3.25:
Step 1: Input the Number
We start with the number 3.25.

Step 2: Multiply by the Scaling Factor (4)
Since the Q2.2 format has 2 fractional bits, we multiply the number by 
2
2
=
4
2 
2
 =4 to convert it into the fixed-point format.

Fixed-point number
=
Input number
×
4
Fixed-point number=Input number×4
For 3.25:

3.25
×
4
=
13
3.25×4=13
So, 3.25 becomes 13 in Q2.2 format.

Step 3: Represent the Fixed-Point Value in Binary (Q2.2)
Now, we need to represent 13 in binary using 4 bits (since we are working with 4 bits for Q2.2 format).

In binary:

13
10
=
1101
2
13 
10
​
 =1101 
2
​
 
So, 13 in decimal becomes 1101 in binary.

Step 4: Breakdown into Q2.2 Format
We now interpret the binary number 1101 as a Q2.2 fixed-point number:

2 bits for the integer part (to the left of the decimal point).
2 bits for the fractional part (to the right of the decimal point).
Let's break it down:

The integer part (first 2 bits) is 11, which is 3 in decimal.
The fractional part (last 2 bits) is 01, which represents 0.25 (since 01 in binary is 
1
×
1
4
=
0.25
1× 
4
1
​
 =0.25).
Final Representation:
Thus, 3.25 in decimal is represented as:

3.25
10
=
11.01
2
(fixed-point Q2.2 representation)
3.25 
10
​
 =11.01 
2
​
 (fixed-point Q2.2 representation)
And the fixed-point value in Q2.2 format is the binary number:

1101
2
1101 
2
​
 
Step 5: Verify the Result
To verify, we can convert the fixed-point representation back to decimal:

The integer part (from the first 2 bits) is 3.
The fractional part (from the last 2 bits) is 0.25.
So, the fixed-point value 1101 (Q2.2 format) is:

3
+
0.25
=
3.25
3+0.25=3.25
Thus, the conversion is correct!

Summary of the Conversion Process for 3.25 to Q2.2:
Input: 3.25
Multiply by 4:
3.25
×
4
=
13
3.25×4=13
Convert to Binary:
13
10
=
1101
2
13 
10
​
 =1101 
2
​
 
Interpret in Q2.2 Format:
Integer part = 11 (binary) = 3
Fractional part = 01 (binary) = 0.25
Final Fixed-Point Value:
1101
2
1101 
2
​
  (Q2.2 format)
