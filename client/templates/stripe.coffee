Template.stripe.helpers
  packageData: ->
    return ReactionCore.Collections.Packages.findOne({name:"reaction-stripe"})

AutoForm.hooks "stripe-update-form":
  onSuccess: (operation, result, template) ->
    Alerts.removeSeen()
    Alerts.add "Stripe settings saved.", "success"

  onError: (operation, error, template) ->
    Alerts.removeSeen()
    Alerts.add "Stripe settings update failed. " + error, "danger"