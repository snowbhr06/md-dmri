function fn = erf_pipe(s, paths, opt)
% function fn = erf_pipe(s, paths, opt)
%
% s     - input structure
% paths - either a pathname or a path structure (see mdm_paths)
% opt   - (optional) options that drive the pipeline
%
% fn    - a cell arary with filenames to generated nii files

if (nargin < 2), paths = fileparts(s.nii_fn); end
if (nargin < 3), opt.present = 1; end

opt = mdm_opt(opt);
opt = erf_opt(opt);
paths = mdm_paths(paths);     

msf_log(['Starting ' mfilename], opt);

% Prepare: mask etc
s = mdm_mask(s, @mio_mask_thresh, [], opt);
s = mdm_powder_average(s, fileparts(s.nii_fn), opt); 

% Run the analysis
mdm_data2fit(@erf_4d_data2fit, s, paths.mfs_fn, opt);
mdm_fit2param(@erf_4d_fit2param, paths.mfs_fn, paths.dps_fn, opt);


% Save nifti parameter maps    
fn = mdm_param2nii(paths.dps_fn, paths.nii_path, opt.erf, opt); 

