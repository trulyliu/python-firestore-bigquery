FROM python:3.11-slim AS python-firestore-bigquery

WORKDIR /app

ADD requirement.txt .

# Add non-root user
ARG USERNAME=runner
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Create the user
RUN <<EOF
groupadd --gid $USER_GID $USERNAME
useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
#
# [Optional] Add sudo support. Omit if you don't need to install software after connecting.
#apt-get update
#apt-get install -y sudo
#echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
#chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Install build-essential
apt-get update
apt-get install -y build-essential
#python3-wheel python3-setuptools
apt-get clean
rm -rf /var/lib/apt/lists/*


# Install firebase and bigquery python sdk
MAKEFLAGS="-j\$(nproc)" pip install -r requirement.txt \
    && rm -rf /root/.cache

chown -R $USER_GID:$USER_UID /app

EOF
#RUN rm -rf requirement.txt

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
CMD ["pip", "list"]
