# GSmartControl - GUI frontend for S.M.A.R.T. tools

## Overview
GSmartControl is a graphical user interface for `smartctl` from the
`system/storage/smartmontools` package, which is available in the
[Solaris Userland
Consolidation](https://github.com/oracle/solaris-userland).  This tool
supports the querying and controlling of S.M.A.R.T. (Self-Monitoring,
Analysis, and Reporting Technology) data on modern hard disk and
solid-state drives. It allows you to inspect the drive's
S.M.A.R.T. data to determine its health as well as run various tests.

## Features
* automatically reports and highlights any anomalies;
* allows enabling/disabling S.M.A.R.T.;
* allows enabling/disabling Automatic Offline Data Collection - a short self-check that the drive will perform automatically every four hours with no impact on performance;
* supports configuration of global and per-drive options for smartctl;
* performs S.M.A.R.T. self-tests;
* displays drive identity information, capabilities, attributes, device statistics, etc.;
* can read in smartctl output from a saved file, interpreting it as a read-only virtual device.

## GNU C++ Name Mangling

Solaris 11.4 and later ship with various C++ libraries that employ GNU C++
name mangling.  Among them are: glibmm, cairomm, pangomm, gtkmm, and sigcpp.

If you are running on 11.4 or later, or have rebuilt these libraries on 11.3,
then this is the target for you.

## Screenshots
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/gsmartcontrol/screenshot.png "GSmartControl")
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/gsmartcontrol/screenshot2.png "GSmartControl Details")
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/gsmartcontrol/screenshot3.png "GSmartControl Temperature Log")