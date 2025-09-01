## Fixed Point Numbers
Limited precision provided: Fixed-point numbers have a limited number of digits they can store, meaning they can only represent numbers up to a certain precision or accuracy.

Performance gains over Floating Point - Standard Binary Arithmetic: Fixed-point arithmetic is often faster than floating-point arithmetic on some hardware because it only deals with integers and doesn't need to handle the complexities of floating-point operations (which involve fractions and exponents).

Floating Point must represent whole, fractional and exponent: A floating-point number represents a value in three parts:

A whole number (integer part),
A fractional part (decimals), and
An exponent (which scales the number, e.g., powers of 10).
Example: In the number 6.022 × 10^23 (which is Avogadro’s number), 6.022 is the whole number, the exponent is 23, and there’s a sign to indicate whether it's positive or negative.

Namely a.b * exp{c} or 6.022x10^23 (sign is also required!): This is just another way of expressing the floating-point format (a × 10^c), where "a" is the number with both whole and fractional parts, and "exp{c}" represents the exponent.

Raw binary operations on a float are not possible like a fixed-point number: When working with floating-point numbers, simple operations in binary (like adding, subtracting) are complicated because they also involve the exponent. Fixed-point numbers are simpler because they don't have this complication—they only have integer values.

Floats have whole, fractional and exponents encoded: Floating-point numbers store all three parts (whole, fractional, and exponent) in a specific way, which makes operations more complex.

Requires additional work to do basic arithmetic: Since floating-point numbers are more complex, performing arithmetic operations with them takes more steps than with fixed-point numbers.

Our Pis have Hardware Coprocessors that are specialized to handle Floats: Many modern computers, including Raspberry Pi computers (likely referenced here), have specialized hardware (called coprocessors) that handle floating-point arithmetic efficiently.

Fixed Point Arithmetic - Error
Computer memory is finite so we have a fixed number of bits to represent our data: Computers have limited memory, and the number of bits (the smallest unit of memory) determines how much information they can store. This limits the precision of numbers they can represent.

This introduces error if we are trying to represent a real number in an interval: Because of the limited number of bits, the computer can only approximate real numbers. For example, it can't store every decimal exactly and might round or truncate the number, causing a small error.

Interval is continuous and so ideally limitless precision: Real numbers (like 1.33333...) can have infinite decimal places, so they are continuous. But computers can't represent this continuous range perfectly because of their finite memory.

We have a fixed precision of N bits: The number of bits (N) determines the precision of the representation. If you have fewer bits, you get less precision.

Example: 32 bits to represent values from 0.01 to 100.00 to a precision of 0.005: If you're using 32 bits to represent numbers, and the range of values is from 0.01 to 100.00, the computer can only represent numbers to the nearest 0.005 (this is the "precision").

So any number N in this span equates to N+/-0.005: If you try to represent a number within this range, it can be off by up to ±0.005 due to the precision limit.

This represents a worst case error in % 0.005/0.01 * 100 = 50%: To understand the worst-case error in percentage, take the error (0.005) and divide it by the smallest step size (0.01), then multiply by 100 to get the error percentage. Here, the error is 50%.

We have a worst case error of +/-50%: This means that when using 32 bits to represent values with a step size of 0.005, the error could be as high as ±50% of the value you're trying to represent.
