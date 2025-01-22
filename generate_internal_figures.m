function generate_internal_figures(num_channels, current_channel, channel_input, priors_value, phantom_sound, continuous_sound, custom_prior_set)
% function used to set all relevant variable values and calls spm functions

% process (G) and model (M)
%==========================================================================
 
% parameters
%========================================================================== 
% internal greater than external 

channel = current_channel;
priors = priors_value;
external_input_sound = channel_input;
custom_priors = custom_prior_set;

% set dimensions for generalised coordinates
%--------------------------------------------------------------------------
G(1).f  = inline('tanh(a) - x/4','x','v','a','P');
G(1).g  = inline('[x; v + x]','x','v','a','P');
G(1).x  = 0;                           % hidden state%
G(1).U  = [exp(0) 0];                  % precision (action)
  
% level 2; causes
%--------------------------------------------------------------------------
G(2).v  = 0;                           % exogenous  cause
G(2).a  = 0;                           % endogenous cause (action)
 
% state-dependent precision (attentional bias) in generative model (M):
%--------------------------------------------------------------------------
M(1).f  = inline('v - x/4','x','v','P');
M(1).g  = inline('[x(1); sum(x)]','x','v','P');
M(1).x  = [0; 0];                      % hidden states
M(1).W  = exp(10);                      % precision (states)
M(1).ph = inline('[1; 1]*(8 - h*tanh(v(1) + x(1)))','x','v','h','M');
M(1).hE = 6;
 
% level 2; causes
%--------------------------------------------------------------------------
M(2).v  = [0; 0];                      % hidden cause
M(2).V  = [exp(6); exp(0)];
 
% Demonstration of the need for sensory attenuation
%==========================================================================
 
% hidden cause and prior expectations
%--------------------------------------------------------------------------
N      = 32;
C      = zeros(1,N);
if custom_priors == zeros(1,32)
    U(1,:) = generate_prior_expectations(priors_value, phantom_sound, continuous_sound, N);
else 
    U(1,:) = custom_priors;
end
%U(2,:) = U(1,:);
U(2,:) = zeros(1,N); 

% assemble model structure
%--------------------------------------------------------------------------
DEM.M = M;
DEM.G = G;
DEM.C = C;
DEM.U = U;
 
hE    = (-4:1:6);
for i = 1:length(hE)
    
    rng('default')
    
    LAP         = DEM;
    LAP         = spm_ALAP(LAP);
    
    % true and perceived force exerted (endogenously)
    %----------------------------------------------------------------------
   
    Px(i) = max(LAP.pU.x{1}(1,:));
    Qx(i) = max(LAP.qU.x{1}(1,:));
    
end
  
% Demonstration of sensory attenuation
%==========================================================================
 
% replay internal force as external force
%--------------------------------------------------------------------------
% external force set equal to internal
DEM.C = [C external_input_sound];
DEM.U = horzcat(U, U);
if custom_priors == zeros(1,32)
    DEM.U = horzcat(U, U);
else 
    DEM.U(1,32:end) = zeros;
    DEM.U(2,32:end) = zeros;
end
DEM    = spm_ALAP(DEM);
 
% plot
%--------------------------------------------------------------------------
spm_figure('GetWin',['CHANNEL ' num2str(channel) ': Figure 4 - Internal']);
spm_DEM_qU_tinnitus(DEM.qU,DEM.pU,'internal',external_input_sound)
 
save('DEM_store.mat',"DEM","channel",'-mat')
tinnitus_model_plot;


