Router.map ->
  @route 'stripe',
    controller: ShopAdminController
    path: 'dashboard/settings/stripe',
    template: 'stripe'
    waitOn: ->
      return ReactionCore.Subscriptions.Packages