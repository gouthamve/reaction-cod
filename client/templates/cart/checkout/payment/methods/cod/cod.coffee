Template.codPaymentForm.events
  'click .btn-complete-order': () ->
    total = ReactionCore.Collections.Cart.findOne().cartTotal()
    normalizedStatus = "settled"
    normalizedMode = "capture"
    id = new Mongo.ObjectID().toString()
    response = {
      captured: true,
      amount: total * 100
    }
    paymentMethod =
      processor: "COD"
      amount: total
      status: normalizedStatus
      mode: normalizedMode
      transactionId: id
      createdAt: new Date()
      transactions: []
    CartWorkflow.paymentMethod(paymentMethod)

  #TODO: Add check PIN functionality
  #'click .btn-check-pin': (event,template) ->
  #  testPin = parseInt(template.find("input[name=testPin]").value)

Template.codPaymentForm.helpers
 validPin: ->
  cartId = ReactionCore.Collections.Cart.findOne()._id
  Meteor.call "isValidPin", cartId, (err, result)->
    if result
      Session.set "isValidPin", true
    else
      Session.set "isValidPin", false
  return Session.get "isValidPin"