#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add &&
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker adminuser

echo "-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAQEAsdt8hqK02STmlntVXQocCvJxBuHLAclhFqq/k9b1QrWBy/8ww3fS
38vcaRO8qZjnogNv9uLj5E6vjNOOEUpWha5oXfVVKO/tYDCH7gUUL+keqYvJMdiRn7aIAh
aBieG4b4Kz1imF4yvij/U4kC5TVdFEASLWn0tgvIjbKQemamaAk5DeQ6Wu32QppSEwHDZE
3DFzQ7d1F7E5mhXlxxJ4rQuioOTwJmPO0cZvcd07IrvUfyy1VsNGtIXzqC1SjipSDitwoS
GOUPpu3355BYv0fI/ArsLqSR0GTsEr1oOqRCdA72y49J/59qowif5n3SNHcFSY7FcX08/j
hgFRvR3rQQAAA9iELxpzhC8acwAAAAdzc2gtcnNhAAABAQCx23yGorTZJOaWe1VdChwK8n
EG4csByWEWqr+T1vVCtYHL/zDDd9Lfy9xpE7ypmOeiA2/24uPkTq+M044RSlaFrmhd9VUo
7+1gMIfuBRQv6R6pi8kx2JGftogCFoGJ4bhvgrPWKYXjK+KP9TiQLlNV0UQBItafS2C8iN
spB6ZqZoCTkN5Dpa7fZCmlITAcNkTcMXNDt3UXsTmaFeXHEnitC6Kg5PAmY87Rxm9x3Tsi
u9R/LLVWw0a0hfOoLVKOKlIOK3ChIY5Q+m7ffnkFi/R8j8CuwupJHQZOwSvWg6pEJ0DvbL
j0n/n2qjCJ/mfdI0dwVJjsVxfTz+OGAVG9HetBAAAAAwEAAQAAAP86lByV5hqQ0LRl9VK1
CYoIRC913Vcudu2yL+icd6vP4jPqotEbsj2TCUDGfRvMrwLw1TmG+TwvcaoCRM15Dw+r71
rfdT89jYQL4c30aCbCOoFjGm+2blVmDZqCat6uU5RWFMumbLnbJUgGf+QdEDYEeH1xryWj
N/Bkjp2gP3oc7octlzfcAFZlZkbx0phqcA9nNdsseK6NnCQbhAq4LXgn1cf/KKHeAgN6/B
L4ncQJd5Fme/bgGAf+o5D+E+bVhItsYFcSXXDacImQBhY6mA+g/eaieEhhgOE5SiKe5Vzi
MsJ/sMEPecI53mEwI5Vl37vDr7skKiI1/WvvN/lrVzEAAACAezxc8aSQFuBttB6G4Ks0cI
7bH3ktZfNBmuj1s28RI6cY0Qd1xMQczpTpom0+1RUiCWvlvMBu0s8/rWnSo3D+EGEkOFAF
HtV6Vm8NWdkDBxQK56XpCVIImdfvJEeuK8ZO56bcwBco0AhjIbeEz86rdpSkFlItSqhPNO
K6G+wwR3AAAACBAO8efRACChc9+NMqeBSbyPmxFLn7baxxt4BqaICars/SIj1XSAubcnt3
0w2RstDHZFhbOtZ+CC/vnXqijDX6i4fkyGSiCncsGBxyEXBKe4W4N3SR7j+uU3hWTGHAEC
S2Z7XpYwb8wIgB/SdMwCSuz8MVpLve0z+GAemwf3p0KBa5AAAAgQC+adZVnmeh9h4MHFZm
72ZVNyTXsUGRuF6KuwRVOkvpBRnc0PSZxi2M+RohY9AhBfnnuE5HAkA0ggAfDkzgHvjggS
t+niuL4UmUjwsEn7IWv+8N12QfmKdDmlOd+zvBu2itmCC16Z0Y4734hRfj73RdOROqkXM4
4Mj3/Sim8fq0yQAAAB9uYXJjb3NlbkBuYXJjb3Nlbi1UaGlua1BhZC1UNDUwAQIDBAU=
-----END OPENSSH PRIVATE KEY-----
" > /home/adminuser/.ssh/id_rsa