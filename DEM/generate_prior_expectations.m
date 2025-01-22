function x = generate_prior_expectations(priors_value, phantom_sound, continuous_sound, N)
    % Generates prior expectations fror user - useful for users who do not
    % know what exactly prior values should be
    prior = priors_value;
    phantom = phantom_sound;
    continuous = continuous_sound;
    generated_priors=zeros(1,N);
    
    %phantom
    if phantom && prior<=0.5
        prior=1;
    end
    
    % continuous
    if continuous && prior<1
         x = zeros(1,N)+prior;
    elseif continuous && prior==1
         x = ones(1,N);
    elseif continuous == false
         x = exp(-((1:N) - N/2).^2/(4.^2))*prior;
    end
end

