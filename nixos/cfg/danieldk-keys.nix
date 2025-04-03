{ ... }:

{

  users.users.daniel.openssh.authorizedKeys.keys = [
    # YubiKey 5 FIDO2
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDA1t6QKNTYwEScT1pLkk0QItRe33nRJizpsA/hd2LI7AAAABHNzaDo= me@danieldk.eu"
    # YubiKey 5
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBuV5m0qobDslRXc6+kGDjfOhjeYVw+PpwuPtg5/bbORAAAABHNzaDo= ssh:"
    # YubiKey Nano
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFmm3Wq0H+ch6Tt6d8vNo00jti+NjcEkJbyFh+SX4/aCAAAABHNzaDo= YubiKey Nano"
    # 1Password
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6l265QPVJjOMTXZGjKYX7lIlpn3rPWWUoN01MHvOdl"
  ];

}
