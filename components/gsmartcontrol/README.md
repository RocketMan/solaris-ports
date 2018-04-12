# GSmartControl - Hard disk drive and SSD health inspection tool

## Overview
GSmartControl is a graphical user interface (GUI) for smartctl (from
[smartmontools](https://www.smartmontools.org/) package), which is a
tool for querying and controlling S.M.A.R.T. (Self-Monitoring,
Analysis, and Reporting Technology) data on modern hard disk and
solid-state drives. It allows you to inspect the drive's
S.M.A.R.T. data to determine its health, as well as run various tests
on it.

GSmartControl supports ATA drives (both PATA and SATA), various USB to
ATA bridges and drives behind some RAID controllers. See [Smartmontools
USB Device Support](http://www.smartmontools.org/wiki/Supported_USB-Devices)
page for a list of supported USB to ATA bridges.

## Features
    * automatically reports and highlights any anomalies;
    * allows enabling/disabling S.M.A.R.T.;
    * allows enabling/disabling Automatic Offline Data Collection - a short self-check that the drive will perform automatically every four hours with no impact on performance;
    * supports configuration of global and per-drive options for smartctl;
    * performs S.M.A.R.T. self-tests;
    * displays drive identity information, capabilities, attributes, device statistics, etc.;
    * can read in smartctl output from a saved file, interpreting it as a read-only virtual device;
    * works on most smartctl-supported operating systems;
    * has extensive help information. 
