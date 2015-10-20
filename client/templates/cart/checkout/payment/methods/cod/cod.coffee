Template.codPaymentForm.events
  'click .btn-complete-order': () ->
    total = ReactionCore.Collections.Cart.findOne().cartTotal()
    normalizedStatus = "settled"
    normalizedMode = "capture"
    id = new Mongo.ObjectID().toString()
    response = {
      captured: true,
      amount: parseFloat(total * 100)
    }
    paymentMethod =
      processor: "COD"
      amount: parseFloat(total)
      status: normalizedStatus
      mode: normalizedMode
      transactionId: id
      createdAt: new Date()
    Meteor.call "cart/submitPayment", paymentMethod

  #TODO: Better Alerts
  'click .btn-check-pin': (event,template) ->
    testPin = parseInt(template.find("input[name=testPin]").value)
    if testPin
      Meteor.call "isValidPin", testPin, (err, result)->
        if result
          Alerts.add Alerts.add "Pincode is serviceable", "success", autoHide: true
        else
          Alerts.add Alerts.add "Pincode is not serviceable", "danger", autoHide: true

Template.codPaymentForm.helpers
 validPin: ->
  pin = parseInt(_.first(ReactionCore.Collections.Cart.findOne().shipping).address.postal)
  Meteor.call "isValidPin", pin, (err, result)->
    if result
      Session.set "isValidPin", true
    else
      Session.set "isValidPin", false
  return Session.get "isValidPin"
