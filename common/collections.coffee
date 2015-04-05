###
#  Meteor.settings.stripe =
#    mode: false  #sandbox
#    api_key: ""
#  see: https://stripe.com/docs/api
###

ReactionCore.Schemas.StripePackageConfig = new SimpleSchema([
  ReactionCore.Schemas.PackageConfig
  {
    "settings.mode":
      type: Boolean
      defaultValue: false
    "settings.api_key":
      type: String
      label: "API Client ID"
  }
])

ReactionCore.Schemas.StripePayment = new SimpleSchema
  payerName:
    type: String
    label: "Cardholder name"
  cardNumber:
    type: String
    min: 14
    max: 16
    label: "Card number"
  expireMonth:
    type: String
    max: 2
    label: "Expiration month"
  expireYear:
    type: String
    max: 4
    label: "Expiration year"
  cvv:
    type: String
    max: 4
    label: "CVV"

ReactionCore.Schemas.StripePayment.messages
  "regEx payerName": "[label] must include both first and last name"
