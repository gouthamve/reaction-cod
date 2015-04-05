uiEnd = (template, buttonText) ->
  template.$(":input").removeAttr("disabled")
  template.$("#btn-complete-order").text(buttonText)
  template.$("#btn-processing").addClass("hidden")

paymentAlert = (errorMessage) ->
  $(".alert").removeClass("hidden").text(errorMessage)

hidePaymentAlert = () ->
  $(".alert").addClass("hidden").text('')

handleStripeSubmitError = (error) ->
  singleError = error
  serverError = error?.message
  if serverError
    paymentAlert "Oops! #{serverError}"
  else if singleError
    paymentAlert "Oops! #{singleError}"

# used to track asynchronous submitting for UI changes
submitting = false

AutoForm.addHooks "stripe-payment-form",
  onSubmit: (doc) ->
    # Process form (pre-validated by autoform)
    submitting = true
    template = this.template
    hidePaymentAlert()

    # Format data
    form = {
      name: doc.payerName
      number: doc.cardNumber
      expire_month: doc.expireMonth
      expire_year: doc.expireYear
      cvv2: doc.cvv
      type: getCardType(doc.cardNumber)
    }

    # Reaction only stores type and 4 digits
    storedCard = form.type.charAt(0).toUpperCase() + form.type.slice(1) + " " + doc.cardNumber.slice(-4)

    # Submit for processing
    Meteor.Stripe.authorize form,
      total: ReactionCore.Collections.Cart.findOne().cartTotal()
      currency: Shops.findOne().currency
    , (error, transaction) ->
      submitting = false
      if error
        # this only catches connection/authentication errors
        handleStripeSubmitError(error)
        # Hide processing UI
        uiEnd(template, "Resubmit payment")
        return
      else
        if transaction.saved is true #successful transaction

          # Normalize status
          normalizedStatus = switch
            when not transaction.response.captured and not transaction.response.failure_code then "created"
            when transaction.response.captured is true and not transaction.response.failure_code then "settled"
            when transaction.response.failure_code then "failed"
            else "failed"

          # Normalize mode
          normalizedMode = switch
            when not transaction.response.captured and not transaction.response.failure_code then "authorize"
            when transaction.response.captured then "capture"
            else "capture"

          # Format the transaction to store with order and submit to CartWorkflow
          paymentMethod =
            processor: "Stripe"
            storedCard: storedCard
            method: transaction.response.source.funding
            transactionId: transaction.response.id
            amount: transaction.response.amount * 0.01
            status: normalizedStatus
            mode: normalizedMode
            createdAt: new Date(transaction.response.created)
            transactions: []
          paymentMethod.transactions.push transaction.response

          # Store transaction information with order
          # paymentMethod will auto transition to
          # CartWorkflow.paymentAuth() which
          # will create order, clear the cart, and update inventory,
          # and goto order confirmation page
          CartWorkflow.paymentMethod(paymentMethod)
          return
        else # card errors are returned in transaction
          handleStripeSubmitError(transaction.error)
          # Hide processing UI
          uiEnd(template, "Resubmit payment")
          return

    return false;

  beginSubmit: (formId, template) ->
    # Show Processing
    template.$(":input").attr("disabled", true)
    template.$("#btn-complete-order").text("Submitting ")
    template.$("#btn-processing").removeClass("hidden")
  endSubmit: (formId, template) ->
    # Hide processing UI here if form was not valid
    uiEnd(template, "Complete your order") if not submitting
