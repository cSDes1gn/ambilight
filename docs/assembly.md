# Assembly Guide

> This document is a work in progress

## Power Supply Hookup

AC wall plugs have 3 prongs:
1. Live (Black) - small prong
2. Neutral (White) - wider prong
3. Earth (Green) - bottom prong

The internal wire colors for each are noted above. Typically on PSUs the inputs for the wall socket will be labelled with L for live, N for neutral and an earth ground symbol for earth.

## Wire
I am using 24 AWG wire which is rated for a maximum current carrying capacity of 14.3 A which should be the upper limit of current draw for the LEDs on the strip. If the strip is carrying more than 200 LEDs then a higher gauge wire will be required. 

## Connectors
The APD board use standard JST connectors. The LED strips you buy off amazon do not use standard JST connectors so the ends will need to be recrimped. In addition the connector driving the Logic Level Converter will need to be crimped with a JST on the side of the APD and dupont connectors on the side of the RPI GPIO

https://www.youtube.com/watch?v=l0rAEPJoWeE
https://www.youtube.com/watch?v=jET1QTP1B7c&t=255s