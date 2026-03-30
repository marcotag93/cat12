function cat12norm(t1w_src, spm12_dir, nproc, vox, surface)

    narginchk(2, 5);

    if ~ischar(t1w_src) || ~exist(t1w_src, 'file')
        error('cat12norm:invalidInput', 'Input image not found: %s', t1w_src);
    end
    if ~ischar(spm12_dir) || ~exist(spm12_dir, 'dir')
        error('cat12norm:invalidInput', 'SPM12 directory not found: %s', spm12_dir);
    end

    if nargin < 3 || isempty(nproc)
        nproc = feature('numcores');
    end
    if nargin < 4 || isempty(vox)
        vox = 1.5;
    end
    if nargin < 5 || isempty(surface)
        surface = 1;
    end

    addpath(spm12_dir);
    cat12_dir = fullfile(spm12_dir, 'toolbox', 'cat12');
    if ~exist(cat12_dir, 'dir')
        error('cat12norm:missingDep', 'CAT12 not found in: %s', cat12_dir);
    end
    addpath(cat12_dir);

    if ~exist('spm', 'file')
        error('cat12norm:missingDep', 'SPM12 is not on the MATLAB path.');
    end
    if ~exist('cat12', 'file')
        error('cat12norm:missingDep', 'CAT12 is not on the MATLAB path.');
    end

    spm('defaults', 'fmri');
    spm_jobman('initcfg');

    matlabbatch{1}.spm.tools.cat.estwrite.data = {t1w_src};
    matlabbatch{1}.spm.tools.cat.estwrite.data_wmh = {''};
    matlabbatch{1}.spm.tools.cat.estwrite.nproc = nproc;
    matlabbatch{1}.spm.tools.cat.estwrite.useprior = '';
    tpm_path = fullfile(spm12_dir, 'tpm', 'TPM.nii');
    matlabbatch{1}.spm.tools.cat.estwrite.opts.tpm = {tpm_path};
    matlabbatch{1}.spm.tools.cat.estwrite.opts.affreg = 'mni';
    matlabbatch{1}.spm.tools.cat.estwrite.opts.biasacc = 0.5;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.restypes.optimal = [1 0.3];
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.setCOM = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.APP = 1070;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.affmod = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.spm_kamap = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.LASstr = 0.5;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.LASmyostr = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.gcutstr = 2;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.WMHC = 2;
    shootingtpm_path = fullfile(spm12_dir, 'toolbox', 'cat12', 'templates_MNI152NLin2009cAsym', 'Template_0_GS.nii');
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.registration.shooting.shootingtpm = {shootingtpm_path};
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.registration.shooting.regstr = 0.5;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.vox = vox;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.bb = 12;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.SRP = 22;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.ignoreErrors = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.BIDS.BIDSno = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.surface = surface;
    matlabbatch{1}.spm.tools.cat.estwrite.output.surf_measures = surface;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.neuromorphometrics = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.lpba40 = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.cobra = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.hammers = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.thalamus = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.thalamic_nuclei = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.suit = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.ibsr = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ROImenu.atlases.ownatlas = {''};
    matlabbatch{1}.spm.tools.cat.estwrite.output.GM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.GM.mod = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.GM.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WM.mod = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WM.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.mod = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ct.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ct.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.ct.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.pp.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.pp.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.pp.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.mod = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.SL.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.SL.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.SL.mod = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.SL.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.TPMC.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.TPMC.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.TPMC.mod = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.TPMC.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.atlas.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.label.native = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.label.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.label.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.labelnative = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.bias.warped = 1;
    matlabbatch{1}.spm.tools.cat.estwrite.output.las.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.las.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.las.dartel = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.jacobianwarped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.warps = [1 0];
    matlabbatch{1}.spm.tools.cat.estwrite.output.rmat = 0;

    spm_jobman('run', matlabbatch);

end
