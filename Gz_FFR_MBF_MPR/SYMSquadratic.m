
syms TS alpha R0 N a A f c y top bottom
A = exp(-R0*TS)
 
A =
 
exp(-R0*TS)
 
bottom = 1-A
 
bottom =
 
1 - exp(-R0*TS)
 
top = 1-exp(-TS(1-f*c)*(R0+alpha*c))
Error using sym/subsindex (line 825)
Invalid indexing or function definition. Indexing must follow MATLAB indexing.
Function arguments must be symbolic variables, and function body must be sym
expression.

Error in sym/subsref (line 870)
            R_tilde = builtin('subsref',L_tilde,Idx);
 
top = 1-exp(-TS*(1-f*c)*(R0+alpha*c))
 
top =
 
1 - exp(TS*(c*f - 1)*(R0 + alpha*c))
 
N = top/bottom - 1
 
N =
 
(exp(TS*(c*f - 1)*(R0 + alpha*c)) - 1)/(exp(-R0*TS) - 1) - 1
 
simplify(N)
 
ans =
 
(exp(TS*(c*f - 1)*(R0 + alpha*c)) - 1)/(exp(-R0*TS) - 1) - 1
 
expand(N)
 
ans =
 
(exp(R0*TS*c*f)*exp(-R0*TS)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c))/(exp(-R0*TS) - 1) - 1/(exp(-R0*TS) - 1) - 1
 
pretty(N)
exp(TS (c f - 1) (R0 + alpha c)) - 1
------------------------------------ - 1
           exp(-R0 TS) - 1

top - 1 + A
 
ans =
 
exp(-R0*TS) - exp(TS*(c*f - 1)*(R0 + alpha*c))
 
expand(TS*(c*f - 1)*(R0 + alpha*c))
 
ans =
 
TS*alpha*c^2*f - TS*alpha*c - R0*TS + R0*TS*c*f
 
syms top_1
top_1 = exp(-R0*TS) - exp(TS*alpha*c^2*f - TS*alpha*c - R0*TS + R0*TS*c*f)
 
top_1 =
 
exp(-R0*TS) - exp(TS*alpha*c^2*f - TS*alpha*c - R0*TS + R0*TS*c*f)
 
top_1/exp(-R0*TS)
 
ans =
 
-exp(R0*TS)*(exp(TS*alpha*c^2*f - TS*alpha*c - R0*TS + R0*TS*c*f) - exp(-R0*TS))
 
expand(ans)
 
ans =
 
1 - exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c)
 
N = A/(1-A)*(1 - exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c))
 
N =
 
(exp(-R0*TS)*(exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c) - 1))/(exp(-R0*TS) - 1)
 
simplify(exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c))
 
ans =
 
exp(TS*c*(R0*f - alpha + alpha*c*f))
 
y = (TS*c*(R0*f - alpha + alpha*c*f)) 
 
y =
 
TS*c*(R0*f - alpha + alpha*c*f)
 
1/(1-A)*(1-exp(y))
 
ans =
 
(exp(TS*c*(R0*f - alpha + alpha*c*f)) - 1)/(exp(-R0*TS) - 1)
 
1/(1-A)*(1-exp(y)) -N
 
ans =
 
(exp(TS*c*(R0*f - alpha + alpha*c*f)) - 1)/(exp(-R0*TS) - 1) - (exp(-R0*TS)*(exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c) - 1))/(exp(-R0*TS) - 1)
 
simplify(ans)
 
ans =
 
1 - exp(TS*c*(R0*f - alpha + alpha*c*f))
 
A/(1-A)*(1-exp(y)) -N
 
ans =
 
(exp(-R0*TS)*(exp(TS*c*(R0*f - alpha + alpha*c*f)) - 1))/(exp(-R0*TS) - 1) - (exp(-R0*TS)*(exp(R0*TS*c*f)*exp(TS*alpha*c^2*f)*exp(-TS*alpha*c) - 1))/(exp(-R0*TS) - 1)
 
simplify(ans)
 
ans =
 
0
 
y
 
y =
 
TS*c*(R0*f - alpha + alpha*c*f)
 
help derivative
'derivative' requires Robotics System Toolbox.
help der

der not found.

Use the Help browser search field to search the documentation, or
type "help help" for help command options, such as help for methods.

diff(y, c)
 
ans =
 
TS*(R0*f - alpha + alpha*c*f) + TS*alpha*c*f
 
simplify(ans)
 
ans =
 
TS*(R0*f - alpha + 2*alpha*c*f)
 
syms diff_y
y
 
y =
 
TS*c*(R0*f - alpha + alpha*c*f)
 
y = exp(y)
 
y =
 
exp(TS*c*(R0*f - alpha + alpha*c*f))
 
diff_y = diff(y, c)
 
diff_y =
 
exp(TS*c*(R0*f - alpha + alpha*c*f))*(TS*(R0*f - alpha + alpha*c*f) + TS*alpha*c*f)
 
simplify(diff_y)
 
ans =
 
TS*exp(TS*c*(R0*f - alpha + alpha*c*f))*(R0*f - alpha + 2*alpha*c*f)
 
pretty(ans)
TS exp(TS c (R0 f - alpha + alpha c f)) (R0 f - alpha + 2 alpha c f)

ans
 
ans =
 
TS*exp(TS*c*(R0*f - alpha + alpha*c*f))*(R0*f - alpha + 2*alpha*c*f)
 
solve(diff_y ==0)
 
ans =
 
alpha/(R0 + 2*alpha*c)
 
solve(diff_y ==0, c)
 
ans =
 
(alpha - R0*f)/(2*alpha*f)