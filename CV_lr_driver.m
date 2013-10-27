function [] = CV_lr_driver(Xtrain,Ytrain)
    Xtrain = full(Xtrain);
    Ytrain = full(Ytrain);
    
    s=size(Xtrain);
    countTrainEg = s(1,1);
    
    chunkSize = countTrainEg/10;
    lambdas = [1 0.1 0.01 0.001 0.0001 10^(-5) 10^(-6) 10^(-7)];
    alphas = [0.001 0.001 0.01 0.01 0.01 0.1 0.1 0.1];
    
    for Lind = 1:8
        sumAccuracy = 0;
        l=lambdas(1,Lind);
        a=alphas(1,Lind);
        fprintf('For lambda = %f :: ',l);
        for ind = 1:10
            mybegin = (chunkSize*(ind-1))+1;
            myend = chunkSize*(ind);

            myXtest = Xtrain(mybegin:myend,:);
            myYtest = Ytrain(mybegin:myend,:);

            if(ind == 1)
                myXtrain = Xtrain(myend+1:countTrainEg,:);
                myYtrain = Ytrain(myend+1:countTrainEg,:);
            else
                if(ind == 10)
                    myXtrain = Xtrain(1:mybegin-1,:);
                    myYtrain = Ytrain(1:mybegin-1,:);
                else
                    Xmat1 = Xtrain(1:mybegin-1,:);
                    Xmat2 = Xtrain(myend+1:countTrainEg,:);
                    Ymat1 = Ytrain(1:mybegin-1,:);
                    Ymat2 = Ytrain(myend+1:countTrainEg,:);

                    myXtrain = [Xmat1;Xmat2];
                    myYtrain = [Ymat1;Ymat2];
                end
            end
            accuracy = CV_lr_run(myXtrain,myYtrain,myXtest,myYtest,l,a);
            sumAccuracy = sumAccuracy + accuracy;
        
        end
        fprintf('Average Accuracy: %.3f\n', (sumAccuracy/10));
        
    end
end