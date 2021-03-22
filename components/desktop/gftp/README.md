# gFTP

## Introduction

gFTP is a multithreaded file transfer client.  It supports the FTP,
FTPS(**see NOTE below), HTTP, HTTPS, and SSH protocols, as well
as FTP and HTTP proxy server support, and file transfers between
remote FTP servers via FXP.

gFTP includes both a graphical user interface (GUI) and a command-line
interface.

## NOTE - Full support for FTPS
RocketMan's patch for FTPS landed upstream.  As such, gFTP now
includes full FTPS support for encryption on **both** the control channel
as well as the data channel.
