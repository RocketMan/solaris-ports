# GSmartControl - Hard disk drive and SSD health inspection tool

## Overview
GSmartControl is a graphical user interface for `smartctl` from the
`system/storage/smartmontools` package, which is available in the
[Solaris Userland
Consolidation](https://github.com/oracle/solaris-userland).  This tool
supports the querying and controlling of S.M.A.R.T. (Self-Monitoring,
Analysis, and Reporting Technology) data on modern hard disk and
solid-state drives. It allows you to inspect the drive's
S.M.A.R.T. data to determine its health, as well as run various tests.

## Features
    * automatically reports and highlights any anomalies;
    * allows enabling/disabling S.M.A.R.T.;
    * allows enabling/disabling Automatic Offline Data Collection - a short self-check that the drive will perform automatically every four hours with no impact on performance;
    * supports configuration of global and per-drive options for smartctl;
    * performs S.M.A.R.T. self-tests;
    * displays drive identity information, capabilities, attributes, device statistics, etc.;
    * can read in smartctl output from a saved file, interpreting it as a read-only virtual device.

## Screenshot
![GSmartControl](https://github.com/RinTinCan/solaris-rtutils/components/gsmartcontrol/screenshot.png)
