reaction-cod
=============
[![forthebadge](http://forthebadge.com/images/badges/uses-js.svg)](http://forthebadge.com)

Meteor package adds COD Payments for Reaction Commerce.

This is a prototype module -> pull requests are celebrated, feedback encouraged.

**Usage**
```bash
meteor add gouthamve:reaction-cod
```

In the settings of this package you can set the additional charge and import valid pincodes.

Please note: While the additional charge option is enabled, there is no effect on the final cart right now. A PR is welcome to solve this.

For importing pincodes, please put them in a google sheet and publish it to the web. 
![](https://raw.githubusercontent.com/ongoworks/meteor-google-spreadsheets/master/spreadsheet-publish.png)

Format of spreadsheet: Name the first column of the first row ```Pincode`` and then add the pin codes to the first column as shown.

![screen shot 2015-04-18 at 2 56 30 am](https://cloud.githubusercontent.com/assets/7354143/7211343/8d13ba16-e577-11e4-9857-009ac3c41909.png)

Please see [issues](https://github.com/Gouthamve/reaction-cod/issues).
