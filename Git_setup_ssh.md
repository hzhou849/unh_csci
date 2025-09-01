## SEtup SSH key to access git/stash

1. Continue to create rsa key to connect

2.  In a terminal generate an rsa key pair
```
ssh-keygen -t rsa
```
Just hit enter and use all the default options
when asked for a passphrase just hit 'Enter' to keep it blank
Example: 
```
Generating public/private rsa key pair.
        Enter file in which to save the key (/home/USER/.ssh/id_rsa):
        Enter passphrase (empty for no passphrase):
        Enter same passphrase again:
        Your identification has been saved in temp.
        Your public key has been saved in temp.pub.
        The key fingerprint is:
        b8:84:d1:c1:54:86:09:f9:ce:2a:2e:7d:d1:dd:6c:e8 USER@USER-HP-Z420-Workstation
        The key's randomart image is:
        +--[ RSA 2048]----+
        | o.o             |
        +-----------------+
```

* Output the key to the termial adn copy the ssh key into the clipboard /.ssh/id_rsa.pub
should look like this:
```
cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJi7IaxlsjhSK3Aaj9azuHUnG356bJpUB1BX3S5IHWc1bWw6KW7.....19rNPbtEY2jOscc8cfOoX0c= user@host
```

1. Open git account
2. goto settings -> SSH Keys and GP
3. add key and paste this key from above
4. done!

## Other stuff
1. Check if your terminal/repo is configured for SSH
```bash
git remote -v
```
```
# This should not be https: 
origin  https://github.com/<username>/unh_csci.git (fetch)
origin  https://github.com/<username>/unh_csci.git (push)

# should be SSH
origin  git@github.com:<username>/unh_csci.git (fetch)
origin  git@github.com:<username>/unh_csci.git (push)
```

* Fix it using
```
git remote set-url origin git@github.com:<username>/<repository>.git
```
* test the ssh connection
```
ssh -T git@github.com
```

