
Template.cod.helpers
  packageData: ->
    return ReactionCore.Collections.Packages.findOne({name:"reaction-cod"})

AutoForm.hooks "cod-update-form":
  onSuccess: (operation, result, template) ->
    Alerts.removeSeen()
    Alerts.add "COD settings saved.", "success"
    Meteor.call "updatePincodes"

  onError: (operation, error, template) ->
    Alerts.removeSeen()
    Alerts.add "COD settings update failed. " + error, "danger"