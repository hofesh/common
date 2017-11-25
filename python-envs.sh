#! bash

# conda virtual envs
https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/

conda -V # 1. Check conda is installed and in your PATH
conda update conda # 2. Check conda is up to date
conda create -n ______ python=x.x anaconda # 3. Create a virtual environment for your project
source activate ______ # 4. Activate your virtual environment.
conda install -n ______ [package] # 5. Install additional Python packages to a virtual environment.
source deactivate # 6. Deactivate your virtual environment.
conda remove -n ______ -all # 6. Delete a no longer needed virtual environment
conda info --envs # view all envs
conda env list    # view all envs
conda install python=3.5  # change python version in env
conda install -n ______ pip # using pip in env
conda list # view packages
conda list python # view specific package


# vanilla virtual envs
pip install virtualenvwrapper
# MANUAL: add virtualenvwrapper_lazy.sh to .bashrc
mkvirtualenv mobile-sessions
workon mobile-sessions
rmvirtualenv mobile-sessions
