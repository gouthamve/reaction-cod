ReactionCore.Schemas.CodPackageConfig = new SimpleSchema([
  ReactionCore.Schemas.PackageConfig
  {
    "settings.additionalCharge":
      type: Number
      defaultValue: 0

    "settings.sheetKey":
    	type: String
    	defaultValue: ""

    "settings.pincodes":
    	type:[Number]
  }
])