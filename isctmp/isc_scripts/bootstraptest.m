
function [nulldistribution] = bootstraptest(x,iteration)

    nulldistribution = zeros(iteration,1);
    for n =  1:iteration
        [x_t,x_amp,sym_phase] = phase_rand_corr_mat_new(x,1);
        r = corr(x_t,x);
        nulldistribution(n) = r;
        nulldistribution = sort(nulldistribution);
    end
end
