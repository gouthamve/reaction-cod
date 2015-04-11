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
  'click .btn-check-pin': () ->
    #TO-DO: Validate the pin
    
Template.codPaymentForm.helpers
 validPin: ->
  cartId = ReactionCore.Collections.Cart.findOne()._id
  console.log Meteor.call "validPin", cartId #Showing undefined??
  return true
