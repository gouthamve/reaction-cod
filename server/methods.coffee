Meteor.methods
  updatePincodes: ->
    key = ReactionCore.Collections.Packages.findOne({name:"reaction-cod"}).settings.sheetKey.toString()
    Meteor.call "spreadsheet/fetch", key, "", "", 1
    spreadsheetData = GASpreadsheet.findOne({})
    pincodes = []
    for index,row of spreadsheetData.cells
      pincodes.push(parseInt(row[1].value))
    ReactionCore.Collections.Packages.update({name:"reaction-cod"}, {$set:{"settings.pincodes": pincodes}})
  isValidPin: (currPin) ->
    check currPin, Number
    return false unless currPin
    return true unless ReactionCore.Collections.Packages.findOne({name:"reaction-cod"}).settings.pincodes[0]
    if ReactionCore.Collections.Packages.findOne({name:"reaction-cod", "settings.pincodes": currPin})
      return true
    else
      return false
