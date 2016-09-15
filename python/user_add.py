import os

if os.system('test -e /etc/redhat-release'):
    os.system('sed -i "s/sudo/wheel/"')
else:
    os.system('sed -i "s/wheel/sudo/"')

file = open("/home/hinimix/myscript/source_file", "r")
i = 1

for line in file:
    #user information
    temp = line.split('\t')
    user = temp[1].split('.')[0]
    #group information
    group=temp[2]
    groups=temp[-1]
    os.system('groupadd %s' %temp[2])
    os.system('groupadd %s' %temp[-1].split(',')[1])
    os.system('useradd -m -s /bin/bash -g %s -G %s %s' %(group,groups,user))
    if os.system('id %s' %user):
        continue
    os.system('echo "%s:abcd1234" | /usr/sbin/chpasswd' %user)
file.close()
