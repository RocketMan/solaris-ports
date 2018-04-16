# gFTP

## Introduction

gFTP is a multithreaded file transfer client.  It supports the FTP,
FTPS(**see NOTE below), HTTP, HTTPS, SSH, and FSP protocols, as well
as FTP and HTTP proxy server support, and file transfers between
remote FTP servers via FXP.

gFTP includes both a graphical user interface (GUI) and a command-line
interface.

## NOTE - Full support for FTPS
While the upstream gFTP source code supports encryption on the FTP
control channel, it has never had working support for encryption on
the *data channel*.

Unlike the upstream source code, this release of gFTP for Solaris has
full FTPS support for encryption on **both** the control channel and
the data channel.  On account of this additional functionality, this
release is being numbered 2.0.19.1, to differentiate it from the
upstream source release 2.0.19.
