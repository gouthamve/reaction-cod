
Template.cod.helpers
  packageData: ->
    return ReactionCore.Collections.Packages.findOne({name:"reaction-cod"})

AutoForm.hooks "cod-update-form":
  onSuccess: (operation, result, template) ->
    console.log template
    console.log ReactionCore.Collections.Packages.findOne({name:"reaction-cod"})
    Alerts.removeSeen()
    Alerts.add "COD settings saved.", "success"

  onError: (operation, error, template) ->
    Alerts.removeSeen()
    Alerts.add "COD settings update failed. " + error, "danger"