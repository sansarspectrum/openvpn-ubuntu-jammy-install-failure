openvpn can't be installed in jammy
---

build.openvpn.net repo for jammy is broken

build this Dockerfile and see

focal
---

```
cd focal
date && time docker build -t openvpn-ubuntu-jammy-install-success .
```

jammy
---

```
cd jammy
date && time docker build -t openvpn-ubuntu-jammy-install-failure .
```

* you can see that it fails on `apt-get update`
