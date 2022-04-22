function omegab0_basisb = compute_omegab0(H_basisb,I_basisb)

omegab0_basisb = inv(I_basisb) * H_basisb;
end