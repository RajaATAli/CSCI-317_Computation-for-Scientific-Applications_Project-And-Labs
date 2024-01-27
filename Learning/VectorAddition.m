% Create a vector 1-100 incremented by 2
v = 1:2:100; 
sum = 0;

for i = 1:length(v);
    sum = sum + v(i);
end;
disp(sum)