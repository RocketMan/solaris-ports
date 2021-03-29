## GNOME Weather

With the GNOME Weather application, you can view the current conditions
at your location or from weather stations around the world.

### Requirements

You will need the `libgweather` and `timezone` packages from the
userland gate, built on or after 2018-12-10, as these contain fixes on
which GNOME Weather depends for correct operation.  In addition, if
you want automatic geolocation to work, you will need to enable system
DBus activation (by default, this is disabled).  The latter is
required for `geoclue`.

### Screenshots
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/gnome-weather/screenshot.png "GNOME Weather Hourly")

![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/gnome-weather/screenshot2.png "GNOME Weather Daily")
