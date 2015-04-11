Meteor.methods
	updatePincodes: ->
		key = ReactionCore.Collections.Packages.findOne({name:"reaction-cod"}).settings.sheetKey.toString()
		Meteor.call "spreadsheet/fetch", key, "", "", 1
		spreadsheetData = GASpreadsheet.findOne({})
		pincodes = []
		for index,row of spreadsheetData.cells
			pincodes.push(parseInt(row[1].value))
		ReactionCore.Collections.Packages.update({name:"reaction-cod"}, {$set:{"settings.pincodes": pincodes}})
	validPin: (cartId) ->
		return false unless cartId
		check cartId, String
		currPin = parseInt(ReactionCore.Collections.Cart.findOne({_id: cartId}).shipping.address.postal)
		#if ReactionCore.Collections.Packages.findOne({name:"reaction-cod", "settings.pincodes": currPin})
		#	return true
		#else
		# return false
		return true
