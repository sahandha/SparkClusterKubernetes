from fabric.api import *
from OpenStackVirtualMachine import OSVM
import time
import socket


def startInstance():
    print "\n+++ Set Up and Instantiate the VM +++"
    vmname = raw_input("Enter VM name: ")
    vm = OSVM(vmname)
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()
    print "++++++ Done with Setting Up :) +++++++\n"
    return vm

def setFabCreds(vm):
    print "Set Fabric env values for authentication."
    env.user = 'ubuntu'
    env.host_string = (vm._Host).ip
    env.key_filename = './acx.key'


def setUpMyVM():
    vm=startInstance()
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()

    print "Communicating with the remote VM..."
    put('./StarterScript.sh')
    put('~/.vim')
    put('~/.vimrc')
    run('source ./StarterScript.sh')

def waitForSSH():
    print "Pinging the remote VM for readiness..."
    address=env.host_string
    port=22
    while True:
        time.sleep(2)
        try:
            s=socket.socket()
            s.connect((address,port))
            print "Connected :). \n"
            return
        except Exception,e:
            print "Failed to connect to %s:%s. VM not up yet..." %(address,port)
            pass
