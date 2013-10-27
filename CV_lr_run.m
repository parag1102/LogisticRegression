function [accuracy] = CV_lr_run(Xtrain,Ytrain,Xtest,Ytest,lambda,alpha)
    
    [model] = CV_lr_train(Xtrain,Ytrain,lambda,alpha);
    [Pred_lr] = CV_lr_test(model,Xtest);

    Ytest = full(Ytest);
    combine = [Ytest,Pred_lr];
    
    tp=sum( (combine(:,1)==1) & (combine(:,2)==1) );
    tn=sum( (combine(:,1)==0) & (combine(:,2)==0) );
    fp=sum( (combine(:,1)==0) & (combine(:,2)==1) );
    fn=sum( (combine(:,1)==1) & (combine(:,2)==0) );

    %precision = tp / (tp + fp);
    %recall = tp / (tp + fn);
    accuracy = (tp + tn)/(tp+fp+fn+tn);
    
end
