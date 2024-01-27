clear sum;
sum = 0;
for i = 0:3;
    disp(['outer is = ', num2str(i*2)])
    for j = 2:3;
        disp(['inner is = ', num2str(j)])
    end;
    disp('Done inner')
end;
disp('Done outer')