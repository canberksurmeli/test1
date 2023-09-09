FROM debian:11

LABEL author="author" description="description"

RUN apt-get update --fix-missing && \
apt-get install -y --no-install-recommends \
wget \
make \ 
curl

RUN apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN curl -fsSLk https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
bash miniconda.sh -b -u /opt/conda && \
rm miniconda.sh

RUN wget --quiet --no-check-certificate "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" && \
bash Mambaforge-$(uname)-$(uname -m).sh -b -f

ENV PATH="/opt/conda/bin:/root/mambaforge/bin:${PATH}"

COPY . /
RUN \
mamba env create -f /66f55610-9c5a-4046-8a5d-caeaa238747a.conda.yaml && \
mamba clean -a


ENV PATH /opt/conda/envs/66f55610-9c5a-4046-8a5d-caeaa238747a/bin:$PATH
