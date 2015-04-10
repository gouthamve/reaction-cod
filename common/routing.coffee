Router.map ->
  @route 'cod',
    controller: ShopAdminController
    path: 'dashboard/settings/cod',
    template: 'cod'
    waitOn: ->
      return ReactionCore.Subscriptions.Packages