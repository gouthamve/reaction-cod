
Template.cod.helpers
  packageData: ->
    return ReactionCore.Collections.Packages.findOne({name:"reaction-cod"})

AutoForm.hooks "cod-update-form":
  onSuccess: (operation, result, template) ->
    Alerts.removeSeen()
    Alerts.add "COD settings saved.", "success"
    key = ReactionCore.Collections.Packages.findOne({name:"reaction-cod"}).settings.sheetKey.toString()
    Meteor.call "spreadsheet/fetch", key, "", "", 1
    spreadsheetData = GASpreadsheet.findOne({})
    pincodes = []
    for index,row of spreadsheetData.cells
    	pincodes.push(parseInt(row[1].value))
    id = ReactionCore.Collections.Packages.findOne({name:"reaction-cod"})._id
    ReactionCore.Collections.Packages.update(id, {$set:{"settings.pincodes": pincodes}})

  onError: (operation, error, template) ->
    Alerts.removeSeen()
    Alerts.add "COD settings update failed. " + error, "danger"