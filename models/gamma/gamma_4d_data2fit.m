function mfs_fn = gamma_4d_data2fit(s, mfs_fn, opt)
% function mfs_fn = gamma_4d_data2fit(s, mfs_fn, opt)

if (nargin < 3), opt = []; end

ind = 1:s.xps.n;

% Verify the xps
gamma_check_xps(s.xps);

% Loop over the volume and fit the model
xps = s.xps; % this appears to improve parallel performance
f = @(signal) gamma_1d_data2fit(signal, xps, opt, ind);

mfs_fn = mio_fit_model(f, s, mfs_fn, opt);

