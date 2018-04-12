## cpulimit - CPU usage limiter

# What is it?
cpulimit is a simple program which attempts to limit the cpu usage of
a process (expressed in percentage, not in cpu time). This is useful
to control batch jobs, when you don't want them to eat too much
cpu. It does not act on the nice value or other scheduling priority
stuff, but on the real cpu usage. Also, it is able to adapt itself to
the overall system load, dynamically and quickly.

# How it works
Note that you don't need to read this paragraph in order to use
cpulimit, you can safely skip it if you are not interested in tweaking
cpulimit.  So, you are curious to know the secrets of cpulimit :) Of
course there is no secret if you are a C developer, but I will try to
explain to everyone. The work of cpulimit is done all in userspace, so
it doesn't interfere with the kernel scheduler. Basically, the target
process, which you can specify by pid, name, or command line, is
continuosly paused and resumed by sending it SIGSTOP and SIGCONT
signals. Signals are sent by cpulimit in appropriate moments, based on
the limit specified by user and the process statistics read from
/proc.

# Notes
If your machine has one processor you can limit the percentage from 0%
to 100%, which means that if you set for example 50%, your process
cannot use more than 500 ms of cpu time for each second. But if your
machine has four processors, percentage may vary from 0% to 400%, so
setting the limit to 200% means to use no more than half of the
available power. In any case, the percentage is the same of what you
see when you run top.

# Author
cpulimit was originally developed by Angelo Marletta <angelo dot marletta
at gmail dot com>, maintained by Denis Denisov (https://github.com/denji),
and ported to Solaris by Jim Mason <jmason at ibinx dot com>.
