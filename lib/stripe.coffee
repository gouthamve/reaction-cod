Meteor.Stripe =
  accountOptions: ->
    # Note: Stripe does not have a flag for indicating sandbox vs production,
    #       it infers automatically based on the api key provided.
    settings = ReactionCore.Collections.Packages.findOne(name: "reaction-stripe").settings
    return settings.api_key

  # submit a payment authorization to Stripe
  authorize: (cardInfo, paymentInfo, callback) ->
    Meteor.call "stripeSubmit", "authorize", cardInfo, paymentInfo, callback
    return

  # TODO - add a "charge" function that creates a new charge and captures all at once

  # capture an existing charge, can capture a portion or whole amount.
  capture: (transactionId, amount, callback) ->
    captureDetails =
      amount: amount

    Meteor.call "stripeCapture", transactionId, captureDetails, callback
    return

  # config is for the stripe configuration settings.
  config: (options) ->
    @accountOptions = options
    return

  chargeObj: ->
    amount: ""
    currency: ""
    card: {}
    capture: true
    currency: ""

  # parseCardData puts card data into a stripe friendly format.
  parseCardData: (data) ->
    number: data.number
    name: data.name
    cvc: data.cvv2
    exp_month: data.expire_month
    exp_year: data.expire_year
