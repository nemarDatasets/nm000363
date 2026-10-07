# Dataset of human medial temporal lobe neurons, scalp and intracranial EEG during a verbal working memory task

## Summary
We present an electrophysiological dataset recorded from nine subjects during a verbal working memory task. Subjects were epilepsy patients undergoing intracranial monitoring for localization of epileptic seizures. Subjects performed a modified Sternberg task in which the encoding of memory items, maintenance, and recall were temporally separated. The dataset includes simultaneously recorded scalp EEG with the 10-20 system, intracranial EEG (iEEG) recorded with depth electrodes, waveforms and spike times of 1526 units recorded in the medial temporal lobe, and the MNI coordinates and anatomical labels of all intracranial electrodes. Subject characteristics and information on sessions (set size, match/mismatch, correct/incorrect, response, response time for each trial) are also provided. This dataset enables the investigation of working memory by providing simultaneous scalp EEG and iEEG recordings, which can be used for connectivity analysis, alongside hard to obtain unit recordings from humans.  

## Downloading the data

### Using gin

Create an account on gin and download the *gin* client as described [here](https://web.gin.g-node.org/G-Node/Info/wiki/gin-cli). On your computer, log in using
```bash
gin login
```

Clone the repository using:
```bash
gin get USZ_NCH/Human_MTL_units_scalp_EEG_and_iEEG_verbal_WM   
```

Large data files will not be downloaded automatically. To get them, use
```bash
gin get-content <filename>
```

Downloaded large files will be locked (read-only). You must unlock the files using
```bash
gin unlock <filename>
```

To remove the contents of a large file again, use
```bash
gin lock <filename>
gin remove-content <filename>
```

See [here](https://web.gin.g-node.org/G-Node/Info/wiki/gin-cli+tutorial) for detailed information on how to use *gin*.


### Using git annex

Make sure git and git-annex are installed on your computer. Create an account on gin and upload your public SSH key to your gin profile. Then clone the repository using
```bash
git clone git@gin.g-node.org:/USZ_NCH/Human_MTL_units_scalp_EEG_and_iEEG_verbal_WM.git
```

Large data files will not be downloaded automatically. To get them, use
```bash
git annex get <filename>
```

Downloaded large files will be locked (read-only). You must unlock the files using
```bash
git annex unlock <filename>
```

To remove the contents of a large file again, use
```bash
git annex --force lock <filename>
git annex drop <filename>
```

See the *git annex* documentation for details.


### Using the web browser

Download the latest release as a zip file by clicking on *Releases* on the main page at https://gin.g-node.org/USZ_NCH/Human_MTL_units_scalp_EEG_and_iEEG_verbal_WM. This zip file will contain all small (text) files only, while large data files will not be downloaded automatically and an empty placeholder will be put in their place. To get the full content of such a large file , download these files individually as needed from the web interface by clicking on them in the repository browser.

## Repository structure

### Main directory
Contains Subject_Characteristics.pdf which describes subjects and NIX_File_Structure.pdf which describes the structure of the nix files.

### Directory code_MATLAB
Contains a MATLAB script (Load_Data_Example_Script.m) with code snippets to read data and task related information.

### Directory data_nix
Contains nix files for each session of the task. Each file is named with the format:  
Data\_Subject\_\<subject number>\_Session\_\<session number>.h5

## Updates
Updated versions of the data and codes will be provided at:
https://gin.g-node.org/USZ_NCH/.

## Support
For questions on the dataset or the task, contact [Johannes.Sarnthein@usz.ch](Johannes.Sarnthein@usz.ch).

## Related Publications
* Boran E, Fedele T, Klaver P, Hilfiker P, Stieglitz L, Grunwald T, Sarnthein J. Persistent hippocampal neural firing and hippocampal-cortical coupling predict verbal working memory load. Sci Adv 2019;5(3):eaav3687. http://doi.org/10.1126/sciadv.aav3687.

## Licensing
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

See `LICENSE.txt` for the full license.