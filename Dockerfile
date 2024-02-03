FROM parrotsec/security

# Create a new user
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# Give sudo privileges to the user
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME

# SSH setup
RUN mkdir /home/$USERNAME/.ssh
COPY id_rsa.pub /home/$USERNAME/.ssh/authorized_keys
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
RUN chmod 700 /home/$USERNAME/.ssh
RUN chmod 600 /home/$USERNAME/.ssh/authorized_keys

USER $USERNAME
